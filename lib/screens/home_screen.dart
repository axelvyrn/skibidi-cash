import 'package:flutter/material.dart';
import '../services/wallet_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _mnemonic;
  final WalletService _walletService = WalletService();

  void _generateSkibidiWallet() {
    setState(() {
      _mnemonic = _walletService.generateMnemonic();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skibidi Cash')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Choose your Skibidi destiny:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateSkibidiWallet,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('🎲 Summon Skibidi Wallet'),
            ),
            const SizedBox(height: 20),
            if (_mnemonic != null) ...[
              const Text(
                '🔥 Your Skibidi Spell 🔥',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                _mnemonic!,
                style: const TextStyle(fontSize: 16, color: Colors.cyanAccent),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
