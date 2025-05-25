import 'package:bip39/bip39.dart' as bip39;

class WalletService {
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  bool validateMnemonic(String mnemonic) {
    return bip39.validateMnemonic(mnemonic);
  }

  // Future TX functions here
}