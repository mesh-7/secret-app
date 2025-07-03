import 'package:equatable/equatable.dart';

import '../../core/enums/vault_item_type.dart';

/// Model representing a single item stored in the vault.
class VaultItem extends Equatable {
  const VaultItem({
    required this.id,
    required this.type,
    required this.title,
    required this.encryptedData,
    required this.timestamp,
  });

  final String id;
  final VaultItemType type;
  final String title;
  final String encryptedData;
  final DateTime timestamp;

  /// Creates a new instance from persisted JSON.
  factory VaultItem.fromJson(Map<String, dynamic> json) => VaultItem(
        id: json['id'] as String,
        type: VaultItemTypeX.fromJson(json['type'] as String),
        title: json['title'] as String,
        encryptedData: json['encryptedData'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );

  /// Serializes this instance to JSON for persistence.
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.json,
        'title': title,
        'encryptedData': encryptedData,
        'timestamp': timestamp.toIso8601String(),
      };

  @override
  List<Object?> get props => [id, type, title, encryptedData, timestamp];
}
