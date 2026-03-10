import 'package:flutter/material.dart';

/// A reusable widget that handles loading, error, and empty states.
class AsyncContent<T> extends StatelessWidget {
  final bool loading;
  final String? error;
  final T? data;
  final VoidCallback onRetry;
  final Widget Function(T data) builder;

  const AsyncContent({
    super.key,
    required this.loading,
    required this.error,
    required this.data,
    required this.onRetry,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
              const SizedBox(height: 16),
              Text(
                error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red[700]),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      );
    }
    if (data == null) {
      return const Center(child: Text('Aucune donnée'));
    }
    return builder(data as T);
  }
}
