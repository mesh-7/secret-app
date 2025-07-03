import 'package:flutter/material.dart';

/// Placeholder screen shown after successful authentication.
class VaultListScreen extends StatelessWidget {
  const VaultListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vault Items')),
      // An empty list view scaffold that will later display vault items.
      body: ListView.builder(
        itemCount: 0,
        itemBuilder: (_, __) => const SizedBox.shrink(),
      ),
    );
  }
}
