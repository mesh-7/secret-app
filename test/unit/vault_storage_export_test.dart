import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:secure_vault/data/models/vault_item.dart';
import 'package:secure_vault/core/enums/vault_item_type.dart';
import 'package:secure_vault/data/storage/vault_storage.dart';
import 'package:secure_vault/core/utils/decrypt_encrypt.dart';

void main() {
  test('exportToJson returns encrypted, decryptable JSON', () async {
    final Directory tempDir = await Directory.systemTemp.createTemp('vault_export_test');
    addTearDown(() => tempDir.delete(recursive: true));

    final storage = VaultStorage(overrideDir: tempDir);

    final items = [
      VaultItem(
        id: '1',
        type: VaultItemType.note,
        title: 'Secret',
        encryptedData: 'cipher',
        timestamp: DateTime.now().toUtc(),
      ),
    ];
    await storage.writeAll(items);

    final cipher = await storage.exportToJson();

    // Should not equal plaintext JSON
    expect(cipher.contains('"title":"Secret"'), isFalse);

    final String plain = DecryptEncrypt.decrypt(cipher);
    final List<dynamic> decoded = jsonDecode(plain);
    expect(decoded, isA<List<dynamic>>());
    expect(decoded.first['title'], 'Secret');
  });
}
