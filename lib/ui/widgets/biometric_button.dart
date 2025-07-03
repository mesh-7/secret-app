import 'package:flutter/material.dart';

/// A reusable button with a fingerprint icon that triggers biometric auth or
/// any provided callback when tapped. Designed for both screens and unit tests.
class BiometricButton extends StatelessWidget {
  const BiometricButton({
    super.key,
    required this.onTap,
    this.label = 'Authenticate',
  });

  /// Callback invoked when the button is tapped.
  final VoidCallback onTap;

  /// Text label displayed next to the icon.
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.fingerprint),
      label: Text(label),
      onPressed: onTap,
    );
  }
}
