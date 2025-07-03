import 'package:encrypt/encrypt.dart' as enc;

/// AES-256 encryption/decryption helper.
///
/// NOTE: For the MVP we use a hard-coded key/IV so the app can work completely
/// offline without any setup. Replace these with a securely generated key that
/// is stored in the device’s secure enclave/keystore for production.
class DecryptEncrypt {
  // 32-byte (256-bit) key – *placeholder only*.
  static final enc.Key _key = enc.Key.fromUtf8(
    '0123456789ABCDEF0123456789ABCDEF', // length 32
  );

  // 16-byte IV (AES block size). Using a constant IV keeps the implementation
  // simple for the MVP. For real security, generate a random IV per message and
  // prepend it to the ciphertext.
  static final enc.IV _iv = enc.IV.fromUtf8('ABCDEF0123456789');

  static final enc.Encrypter _encrypter =
      enc.Encrypter(enc.AES(_key, mode: enc.AESMode.cbc));

  /// Encrypts [plainText] using AES-256/CBC and returns a base64 string.
  static String encrypt(String plainText) {
    final enc.Encrypted encrypted =
        _encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  /// Decrypts [cipherText] (base64) and returns the original plain text.
  static String decrypt(String cipherText) {
    final enc.Encrypted encrypted = enc.Encrypted.fromBase64(cipherText);
    return _encrypter.decrypt(encrypted, iv: _iv);
  }
}
