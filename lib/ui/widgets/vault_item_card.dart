import 'package:flutter/material.dart';

/// A simple card representing a vault item.
/// Currently displays only a [title]; this will be expanded with more
/// metadata and actions in later tasks.
class VaultItemCard extends StatelessWidget {
  const VaultItemCard({super.key, required this.title});

  /// Title text to display for the vault item.
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.lock_outline),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Placeholder tap handler; navigation will be wired later.
        },
      ),
    );
  }
}
