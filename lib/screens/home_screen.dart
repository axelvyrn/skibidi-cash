import 'package:flutter/material.dart';
import 'package:skibidi_wallet/wallet/wallet.dart'; // adjust path if needed
import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SkibidiWallet wallet = SkibidiWallet();
  final player = AudioPlayer();

  String address = 'Loading...';
  int balance = 0;

  // ⚠️ Replace with a real testnet mnemonic!
  final String mnemonic = 'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';

  @override
  void initState() {
    super.initState();
    initWalletAndLoadData();
  }

  Future<void> initWalletAndLoadData() async {
    playSound('skibidi.mp3');

    await wallet.initWallet(mnemonic: mnemonic);
    await wallet.syncWallet();

    final newAddress = await wallet.getNewAddress();
    final walletBalance = await wallet.getBalance();

    setState(() {
      address = newAddress;
      balance = walletBalance;
    });

    playSound('bombastico.mp3');
  }

  void playSound(String fileName) async {
    await player.play(AssetSource('audio/$fileName'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Brutalist background
      appBar: AppBar(
        title: const Text('💸 Skibidi Wallet'),
        backgroundColor: Colors.deepPurple.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📬 Your BTC Testnet Address:',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 8),
            SelectableText(
              address,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.lightGreenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              '💰 Balance: $balance sats',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: const Icon(Icons.sync),
                label: const Text("🚽 Refresh Balance"),
                onPressed: () async {
                  playSound('flush.mp3');
                  await wallet.syncWallet();
                  final newBalance = await wallet.getBalance();
                  setState(() => balance = newBalance);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
