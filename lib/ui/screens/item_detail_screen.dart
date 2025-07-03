import 'package:flutter/material.dart';

/// A simple detail screen that displays information for a single vault item.
/// For now it only shows the [id] in the app bar – content will be added later.
class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Item $id')),
      body: const Center(
        child: Text('Detail view coming soon.'),
      ),
    );
  }
}
