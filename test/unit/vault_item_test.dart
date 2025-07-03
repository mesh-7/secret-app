import 'package:flutter_test/flutter_test.dart';
import 'package:secure_vault/data/models/vault_item.dart';
import 'package:secure_vault/core/enums/vault_item_type.dart';

void main() {
  test('VaultItem JSON round-trip', () {
    final item = VaultItem(
      id: '1',
      type: VaultItemType.password,
      title: 'My Email',
      encryptedData: 'cipher',
      timestamp: DateTime.parse('2025-01-01T00:00:00Z'),
    );

    final json = item.toJson();
    final parsed = VaultItem.fromJson(json);

    expect(parsed, item);
  });
}
