from fastapi import FastAPI
from pydantic import BaseModel, Field
from typing import Literal
import pickle
import logging
import pandas as pd
from starlette.middleware.base import BaseHTTPMiddleware
from fastapi.responses import RedirectResponse

# Basic logging configuration
logging.basicConfig(level=logging.INFO)

# Custom middleware to log request info
class LoggingMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        logging.info(f"Request: {request.method} {request.url}")
        response = await call_next(request)
        logging.info(f"Response: {response.status_code}")
        return response

# Initialize FastAPI app
app = FastAPI()

# Add middleware
app.add_middleware(LoggingMiddleware)

# Load encoders and the trained model
with open('encoders.pkl', 'rb') as f:
    encoders = pickle.load(f)  # Load the saved encoders

energy_model = pickle.load(open('linear_model.sav', 'rb'))  # Load the trained model

# Define the input model
class model_input(BaseModel):
    Temperature: float = Field(..., ge=-50, le=50)  # Temperature between -50 and 50°C
    Humidity: float = Field(..., ge=0, le=100)  # Humidity between 0% and 100%
    SquareFootage: float = Field(..., gt=0)  # Square footage must be greater than 0
    Occupancy: int = Field(..., ge=1)  # Occupancy must be at least 1 person
    HVACUsage: str  # Categorical input
    LightingUsage: str  # Categorical input
    RenewableEnergy: float = Field(..., ge=0)  # Renewable energy value
    DayOfWeek: str  # Categorical input
    Holiday: str  # Categorical input
    EnergyConsumption_L1: float = Field(..., ge=0)  # Previous energy consumption value


@app.get("/")
def redirect_to_docs():
    return RedirectResponse(url="/docs")



# Define the POST endpoint
@app.post('/predictor')
def energy_pred(input_parameters: model_input):
    # Transform categorical features using the saved encoders
    input_data = {
        'Temperature': input_parameters.Temperature,
        'Humidity': input_parameters.Humidity,
        'SquareFootage': input_parameters.SquareFootage,
        'Occupancy': input_parameters.Occupancy,
        'RenewableEnergy': input_parameters.RenewableEnergy,
        'EnergyConsumption.L1': input_parameters.EnergyConsumption_L1,
        'HVACUsage_encoded': encoders['HVACUsage'].transform([input_parameters.HVACUsage])[0],
        'LightingUsage_encoded': encoders['LightingUsage'].transform([input_parameters.LightingUsage])[0],
        'DayOfWeek_encoded': encoders['DayOfWeek'].transform([input_parameters.DayOfWeek])[0],
        'Holiday_encoded': encoders['Holiday'].transform([input_parameters.Holiday])[0]
    }
    
    # Convert the input into a DataFrame
    input_df = pd.DataFrame([input_data])
    
    # Log the input for debugging
    logging.info(f"Input data: {input_df}")

    # Make a prediction using the model
    prediction = energy_model.predict(input_df)
    
    # Return the prediction result
    return {"prediction": prediction[0]}