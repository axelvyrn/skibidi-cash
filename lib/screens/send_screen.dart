import 'package:flutter/material.dart';

class SendScreen extends StatefulWidget {
  @override
  _SendScreenState createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final _addressController = TextEditingController();
  final _amountController = TextEditingController();

  void _sendTransaction() {
    final address = _addressController.text;
    final amount = _amountController.text;

    // TODO: Integrate actual Bitcoin TX logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sending $amount sats to $address... (mocked)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💸 Send Skibidi')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: '👤 Receiver Address'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: '💰 Amount (sats)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _sendTransaction,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: Text('🚀 Send'),
            ),
          ],
        ),
      ),
    );
  }
}
