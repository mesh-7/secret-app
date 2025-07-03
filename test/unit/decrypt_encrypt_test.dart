import 'package:flutter_test/flutter_test.dart';
import 'package:secure_vault/core/utils/decrypt_encrypt.dart';

void main() {
  test('AES encrypt → decrypt round-trip', () {
    const original = 'hello';
    final cipher = DecryptEncrypt.encrypt(original);
    final plain = DecryptEncrypt.decrypt(cipher);

    expect(plain, original);
  });
}
