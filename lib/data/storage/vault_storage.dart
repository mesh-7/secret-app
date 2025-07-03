import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:secure_vault/core/constants/app_constants.dart';
import 'package:secure_vault/data/models/vault_item.dart';
import 'package:secure_vault/core/utils/decrypt_encrypt.dart';

/// Handles persistence of the vault file on disk.
class VaultStorage {
  VaultStorage({Directory? overrideDir}) : _overrideDir = overrideDir;

  final Directory? _overrideDir;

  Future<File> _getFile() async {
    final Directory dir = _overrideDir ?? await getApplicationDocumentsDirectory();
    return File('${dir.path}/${AppConstants.storageFile}');
  }

  /// Reads the vault file and returns the list of items.
  /// If the file doesn’t exist yet, an empty list is returned.
  Future<List<VaultItem>> readAll() async {
    final File file = await _getFile();
    if (!await file.exists()) return <VaultItem>[];

    final String jsonStr = await file.readAsString();
    if (jsonStr.isEmpty) return <VaultItem>[];

    final List<dynamic> decoded = jsonDecode(jsonStr) as List<dynamic>;
    return decoded
        .cast<Map<String, dynamic>>()
        .map(VaultItem.fromJson)
        .toList(growable: false);
  }

  /// Serializes [items] and writes them to the vault file, overwriting any
  /// previous content.
  Future<void> writeAll(List<VaultItem> items) async {
    final File file = await _getFile();
    final String jsonStr = jsonEncode(items.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonStr, flush: true);
  }

  /// Exports all vault items as an **encrypted JSON** string that can be
  /// shared or backed up. The caller is responsible for securely persisting
  /// or transmitting the returned ciphertext.
  Future<String> exportToJson() async {
    final items = await readAll();
    final String jsonStr = jsonEncode(items.map((e) => e.toJson()).toList());
    return DecryptEncrypt.encrypt(jsonStr);
  }

  /// Imports vault data from an **encrypted JSON** [cipherText]. Parsed items
  /// are written to storage and also returned. Any existing data is replaced.
  Future<List<VaultItem>> importFromJson(String cipherText) async {
    final String plain = DecryptEncrypt.decrypt(cipherText);
    final List<dynamic> decoded = jsonDecode(plain) as List<dynamic>;
    final items = decoded
        .cast<Map<String, dynamic>>()
        .map(VaultItem.fromJson)
        .toList(growable: false);
    await writeAll(items);
    return items;
  }
}
