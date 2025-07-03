import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:secure_vault/data/models/vault_item.dart';
import 'package:secure_vault/core/enums/vault_item_type.dart';
import 'package:secure_vault/data/storage/vault_storage.dart';

void main() {
  test('VaultStorage write → read round-trip', () async {
    // Create a temp directory so the test does not touch real user data.
    final Directory tempDir = await Directory.systemTemp.createTemp('vault_test');
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
    final readBack = await storage.readAll();

    expect(readBack, items);
  });
}
