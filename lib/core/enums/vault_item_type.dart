/// Types of items that can be stored in the vault.
/// Extend this enum as new item types are supported.
enum VaultItemType { password, note, card, pin }

extension VaultItemTypeX on VaultItemType {
  /// String representation used in JSON (enum name).
  String get json => name;

  /// Parse from the stored string.
  static VaultItemType fromJson(String value) =>
      VaultItemType.values.firstWhere((e) => e.name == value,
          orElse: () => VaultItemType.note);
}
