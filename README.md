# Energy Consumption Prediction Project
This repository contains a comprehensive implementation of a Regression Model to predict energy consumption, alongside an API and a Flutter mobile app for making real-time predictions.

The idea to build such a model is based on the mission which states,
"Facilitating sustainable infrastructure development by harnessing cutting-edge technological solutions, fostering innovation, and building resilient systems."

With the energy prediction model,from households to institutional buildings and other multi-purpose buildings, informed decisions can be made on how to take action on the energy being consumed sustainably.

# Project Overview
The project is divided into the following key tasks:

- ## Task 1: Regression Models
Building regression models (Linear regression, Random Forest, and Decision tree regression models) to predict energy consumption based on multivariate input features such as:
- Temperature
- Humidity
- SquareFootage
- Occupancy
- HVACUsage
- LightingUsage
- Holiday
- DayOfWeek
- RenewableEnergyvariables.

# Dataset
The dataset used for this project is focused on energy consumption and includes multiple numerical and categorical features. it can be found here: 

https://www.kaggle.com/datasets/mrsimple07/energy-consumption-prediction?select=Energy_consumption.csv

# Best Performing Model Evaluation 
In the three models built namely;
_ Linear Regression
- Decision Trees
- Random Forest
The model was chosen basing on the lowest Root Mean Squared Error (RMSE) and was selected and saved using pickle.


# Task 2: API Development
A FastAPI-based RESTful API was developed for prediction, featuring:

Endpoints: A POST request endpoint that accepts JSON input.
Input Validation: Enforced data types and value ranges using Pydantic.
Middleware: Configured CORS (Cross-Origin Resource Sharing) for secure access.
Deployment: Hosted on Render with a publicly accessible Swagger UI for testing.


# Task 3: Flutter App
A Flutter-based mobile application was built to interact with the API:

- Input Fields: Dynamically captures all required input variables for prediction.
- Button: A "Predict" button triggers the API call.
- Display Area: Displays the prediction result or error messages.
- User-Friendly Interface: Ensures a clean and organized layout for better usability.

# Task 4: Demo Video
A demovideo showcasing the whole process can be found at:


## Python Dependencies
Install Python dependencies using the requirements.txt file:

bash
Copy code
```
pip install -r requirements.txt
```
## Flutter Dependencies
Run the following commands to install Flutter packages:

```
flutter pub get
```

# Usage Instructions
1. Train the Model
Run the Jupyter notebook to preprocess data, train the model, and save it as a .sav file.
2. Start the API
Navigate to the API directory and start the FastAPI server:
```
uvicorn main:app --reload
```
Access Swagger UI at: http://127.0.0.1:8000/docs
3. Use the Flutter App
Connect the app to the hosted API.
Input prediction values in the app and view the results.
4. Test the Application
Use the app and Swagger UI for testing and demonstration.

# Deployment
- API Hosting: The API is hosted on Render and can be accessed at: Swagger UI
- Flutter App: Deployed on a physical or virtual mobile device.
# Results
Best Model: linear regression model with the lowest RMSE of 5.01.
