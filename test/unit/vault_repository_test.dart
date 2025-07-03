import 'package:flutter_test/flutter_test.dart';
import 'package:secure_vault/data/models/vault_item.dart';
import 'package:secure_vault/core/enums/vault_item_type.dart';
import 'package:secure_vault/data/repositories/vault_repository.dart';
import 'package:secure_vault/data/storage/vault_storage.dart';

class _MemoryVaultStorage extends VaultStorage {
  _MemoryVaultStorage() : super(overrideDir: null);

  List<VaultItem> _items = [];

  @override
  Future<List<VaultItem>> readAll() async => List.unmodifiable(_items);

  @override
  Future<void> writeAll(List<VaultItem> items) async {
    _items = List<VaultItem>.from(items);
  }
}

void main() {
  late VaultRepository repo;
  late _MemoryVaultStorage storage;

  setUp(() {
    storage = _MemoryVaultStorage();
    repo = VaultRepository(storage);
  });

  test('add & getAll', () async {
    final item = VaultItem(
      id: '1',
      type: VaultItemType.password,
      title: 'Email',
      encryptedData: 'cipher',
      timestamp: DateTime.now(),
    );

    await repo.add(item);
    final all = await repo.getAll();
    expect(all, [item]);
  });

  test('update', () async {
    final item = VaultItem(
      id: '1',
      type: VaultItemType.note,
      title: 'Note',
      encryptedData: 'cipher',
      timestamp: DateTime.now(),
    );
    await repo.add(item);

    final updated = VaultItem(
      id: '1',
      type: VaultItemType.note,
      title: 'Updated',
      encryptedData: 'cipher2',
      timestamp: DateTime.now(),
    );
    await repo.update(updated);

    final all = await repo.getAll();
    expect(all, [updated]);
  });

  test('delete', () async {
    final item = VaultItem(
      id: '1',
      type: VaultItemType.card,
      title: 'Card',
      encryptedData: 'cipher',
      timestamp: DateTime.now(),
    );
    await repo.add(item);
    await repo.delete('1');
    final all = await repo.getAll();
    expect(all, isEmpty);
  });
}
