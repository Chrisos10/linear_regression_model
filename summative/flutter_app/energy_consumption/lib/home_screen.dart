import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http; // For HTTP requests

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController humidityController = TextEditingController();
  final TextEditingController squareFootageController = TextEditingController();
  final TextEditingController occupancyController = TextEditingController();
  final TextEditingController hvacUsageController = TextEditingController();
  final TextEditingController lightingUsageController = TextEditingController();
  final TextEditingController renewableEnergyController =
      TextEditingController();
  final TextEditingController dayOfWeekController = TextEditingController();
  final TextEditingController holidayController = TextEditingController();
  final TextEditingController energyUsedPreviouslyController =
      TextEditingController();

  final ScrollController _scrollController = ScrollController();
  String predictedValue = "(Predicted Value)";
  bool isLoading = false;

  Future<void> predictEnergy() async {
    // Validate inputs
    if (temperatureController.text.isEmpty ||
        humidityController.text.isEmpty ||
        squareFootageController.text.isEmpty ||
        occupancyController.text.isEmpty ||
        hvacUsageController.text.isEmpty ||
        lightingUsageController.text.isEmpty ||
        renewableEnergyController.text.isEmpty ||
        dayOfWeekController.text.isEmpty ||
        holidayController.text.isEmpty ||
        energyUsedPreviouslyController.text.isEmpty) {
      setState(() {
        predictedValue = "Please fill in all required fields.";
      });
      return;
    }

    // Gather input values
    final input = {
      "Temperature": double.tryParse(temperatureController.text) ?? 0.0,
      "Humidity": double.tryParse(humidityController.text) ?? 0.0,
      "SquareFootage": double.tryParse(squareFootageController.text) ?? 0.0,
      "Occupancy": int.tryParse(occupancyController.text) ?? 0,
      "HVACUsage": hvacUsageController.text.trim(),
      "LightingUsage": lightingUsageController.text.trim(),
      "RenewableEnergy": double.tryParse(renewableEnergyController.text) ?? 0.0,
      "DayOfWeek": dayOfWeekController.text.trim(),
      "Holiday": holidayController.text.trim(),
      "EnergyConsumption_L1":
          double.tryParse(energyUsedPreviouslyController.text) ?? 0.0,
    };

    setState(() {
      isLoading = true;
    });

    try {
      // Send POST request to API
      final response = await http.post(
        Uri.parse("https://energy-prediction-t29f.onrender.com/predictor"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(input),
      );

      // Handle response
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          predictedValue = responseData['prediction']?.toStringAsFixed(2) ??
              "No value returned";
        });
      } else {
        setState(() {
          predictedValue = "Error: ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        predictedValue = "Failed to connect to the server.";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color.fromRGBO(21, 34, 56, 1),
        title: const Center(
          child: Column(
            children: [
              Text(
                'Energy Consumption',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Predictions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.network(
                  'https://images2.rextag.com/public/blog/The%20Future%20of%20Renewable%20Energy.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      // color: Colors.black54,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Anticipate energy demand surges and energy shortages to create adaptable and robust systems.',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Predict The Energy Consumption.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 3.5,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildTextField(
                          'Temperature (°C)', temperatureController),
                      _buildTextField('Humidity', humidityController),
                      _buildTextField(
                          'Square Footage', squareFootageController),
                      _buildTextField('Occupancy', occupancyController),
                      _buildTextField('HVAC Usage (On/Off)', hvacUsageController),
                      _buildTextField(
                          'Lighting Usage (On/Off)', lightingUsageController),
                      _buildTextField(
                          'Renewable Energy', renewableEnergyController),
                      _buildTextField('Day Of The Week', dayOfWeekController),
                      _buildTextField('Holiday (Yes/No)', holidayController),
                      _buildTextField('Energy Used Previously',
                          energyUsedPreviouslyController),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: isLoading ? null : predictEnergy,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(21, 34, 56, 1),
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Predict',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'RESULT: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'The Predicted Energy to be Consumed is: \n $predictedValue Units',
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        maxLines: 1,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          hintText: labelText,
          hintStyle: const TextStyle(fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: const Color(0xFFF2F2F2),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        ),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
