import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SkibidiWallet {
  late Wallet _wallet;

  Future<void> initWallet({required String mnemonic}) async {
    final descriptor = await _createDescriptor(mnemonic);
    final changeDescriptor = await _createDescriptor(mnemonic, isChange: true);

    final dir = await getApplicationDocumentsDirectory();
    final dbPath = '${dir.path}/skibidi_wallet';

    _wallet = await Wallet.create(
      descriptor: descriptor,
      changeDescriptor: changeDescriptor,
      network: Network.TESTNET,
      databaseConfig: const DatabaseConfig.memory(),
    );
  }

  Future<String> getNewAddress() async {
    final addressInfo = await _wallet.getAddress(addressIndex: const AddressIndex());
    return addressInfo.address;
  }

  Future<int> getBalance() async {
    final balance = await _wallet.getBalance();
    return balance.total;
  }

  Future<void> syncWallet() async {
    final blockchain = await Blockchain.create(
      config: BlockchainConfig.esplora(
        baseUrl: 'https://blockstream.info/testnet/api', // or your own Esplora instance
        timeout: 5,
      ),
    );
    await _wallet.sync(blockchain);
  }

  Future<String> sendToAddress(String toAddress, int amountSats) async {
    final txBuilder = TxBuilder()
      ..addRecipient(
        Address(address: toAddress, network: Network.TESTNET),
        amountSats,
      );

    final psbt = await txBuilder.finish(wallet: _wallet);
    await _wallet.sign(psbt);
    final txid = await _wallet.broadcast(psbt);
    return txid;
  }

  Future<String> _createDescriptor(String mnemonic, {bool isChange = false}) async {
    final mnemonicObj = await Mnemonic.fromString(mnemonic);
    final xprv = await DescriptorSecretKey.create(
      network: Network.TESTNET,
      mnemonic: mnemonicObj,
    );

    final path = isChange ? "m/84'/1'/0'/1" : "m/84'/1'/0'/0";
    final derived = await xprv.derive(path: path);
    final descriptor = await Descriptor.newBip84(
      secretKey: derived,
      network: Network.TESTNET,
    );

    return descriptor.asString();
  }
}