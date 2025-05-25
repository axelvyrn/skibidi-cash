import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class ReceiveScreen extends StatelessWidget {
  final String address = 'bc1qexampleaddress1234567890skibidicash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Receive Skibidi')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '📬 Your Wallet Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            QrImageView(
              data: address,
              version: QrVersions.auto,
              size: 220.0,
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 16),
            SelectableText(
              address,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.cyanAccent),
            ),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: address));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Copied to clipboard 🔥'))
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text('📋 Copy'),
            ),
          ],
        ),
      ),
    );
  }
}