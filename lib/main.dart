import 'package:flutter/material.dart';

void main() => runApp(const TempConverterApp());

class TempConverterApp extends StatelessWidget {
  const TempConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Temperature Converter',
      home: ConverterScreen(),
    );
  }
}

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  String _selectedConversion = 'Fahrenheit to Celsius'; // Default conversion
  final TextEditingController _controller = TextEditingController();
  String _convertedValue = '';
  final List<String> _conversionHistory = [];

  void _convertTemperature() {
    double inputTemp = double.tryParse(_controller.text) ?? 0.0;
    double convertedTemp;
    String historyEntry;

    if (_selectedConversion == 'Fahrenheit to Celsius') {
      convertedTemp = (inputTemp - 32) * 5 / 9;
      historyEntry =
          'F to C: $inputTemp => ${convertedTemp.toStringAsFixed(2)}';
    } else {
      convertedTemp = (inputTemp * 9 / 5) + 32;
      historyEntry =
          'C to F: $inputTemp => ${convertedTemp.toStringAsFixed(2)}';
    }

    setState(() {
      _convertedValue = convertedTemp.toStringAsFixed(2);
      _conversionHistory.insert(0, historyEntry); // Add latest at the top
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio<String>(
                  value: 'Fahrenheit to Celsius',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                ),
                Expanded(child: const Text('Fahrenheit to Celsius')),
                Radio<String>(
                  value: 'Celsius to Fahrenheit',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                ),
                Expanded(child: const Text('Celsius to Fahrenheit')),
              ],
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Temperature',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: const Text('CONVERT'),
            ),
            const SizedBox(height: 16),
            Text(
              'Converted Value: $_convertedValue',
              style: const TextStyle(fontSize: 24),
            ),
            const Divider(),
            const Text(
              'Conversion History:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _conversionHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_conversionHistory[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
