import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:secure_vault/data/models/vault_item.dart';
import 'package:secure_vault/core/enums/vault_item_type.dart';
import 'package:secure_vault/data/storage/vault_storage.dart';

void main() {
  test('export then import yields identical list', () async {
    final Directory dir1 = await Directory.systemTemp.createTemp('vault_import1');
    addTearDown(() => dir1.delete(recursive: true));
    final storage1 = VaultStorage(overrideDir: dir1);

    final items = [
      VaultItem(
        id: '42',
        type: VaultItemType.password,
        title: 'Email',
        encryptedData: 'ciphertext',
        timestamp: DateTime.now().toUtc(),
      ),
    ];

    await storage1.writeAll(items);
    final String cipher = await storage1.exportToJson();

    // Import into a separate storage instance / directory
    final Directory dir2 = await Directory.systemTemp.createTemp('vault_import2');
    addTearDown(() => dir2.delete(recursive: true));
    final storage2 = VaultStorage(overrideDir: dir2);

    final imported = await storage2.importFromJson(cipher);

    expect(imported, items);
    final readBack = await storage2.readAll();
    expect(readBack, items);
  });
}
