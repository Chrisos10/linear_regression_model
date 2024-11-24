import 'package:flutter/material.dart';

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
  final TextEditingController renewableEnergyController = TextEditingController();
  final TextEditingController dayOfWeekController = TextEditingController();
  final TextEditingController holidayController = TextEditingController();
  final TextEditingController energyUsedPreviouslyController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

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
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      color: Colors.black54,
                      child: const Text(
                        'Anticipate Energy demand surges and energy shortages to create adaptable and robust systems.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
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
                      _buildTextField('Temperature (°C)', temperatureController),
                      _buildTextField('Humidity', humidityController),
                      _buildTextField('Square Footage', squareFootageController),
                      _buildTextField('Occupancy', occupancyController),
                      _buildTextField('HVAC Usage', hvacUsageController),
                      _buildTextField('Lighting Usage', lightingUsageController),
                      _buildTextField('Renewable Energy', renewableEnergyController),
                      _buildTextField('Day Of The Week', dayOfWeekController),
                      _buildTextField('Holiday', holidayController),
                      _buildTextField('Energy Used Previously', energyUsedPreviouslyController),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      print("Predict button pressed!");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(21, 34, 56, 1),
                      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: const Text(
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
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Predicted Energy To Be Consumed',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'The Predicted Energy to be Consumed Is: (Predicted Value)',
                style: TextStyle(
                  fontSize: 16.0,
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
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        ),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
