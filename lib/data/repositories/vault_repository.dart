import 'package:secure_vault/data/models/vault_item.dart';
import 'package:secure_vault/data/storage/vault_storage.dart';

/// High-level CRUD operations for vault items.
///
/// This repository abstracts away the storage layer so the rest of the app does
/// not depend on file I/O specifics.
class VaultRepository {
  VaultRepository(this._storage);

  final VaultStorage _storage;

  /// Returns a fresh list of all items.
  Future<List<VaultItem>> getAll() => _storage.readAll();

  /// Adds [item] to storage.
  Future<void> add(VaultItem item) async {
    final items = List<VaultItem>.from(await _storage.readAll());
    items.add(item);
    await _storage.writeAll(items);
  }

  /// Updates an existing item (matched by id). No-op if not found.
  Future<void> update(VaultItem updated) async {
    final items = List<VaultItem>.from(await _storage.readAll());
    final idx = items.indexWhere((e) => e.id == updated.id);
    if (idx == -1) return;
    items[idx] = updated;
    await _storage.writeAll(items);
  }

  /// Deletes item with [id]. No-op if id not present.
  Future<void> delete(String id) async {
    final items = List<VaultItem>.from(await _storage.readAll());
    items.removeWhere((e) => e.id == id);
    await _storage.writeAll(items);
  }
}
