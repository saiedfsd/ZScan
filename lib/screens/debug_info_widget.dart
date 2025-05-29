import 'dart:typed_data';
import 'package:flutter/material.dart';

class DebugInfoWidget extends StatelessWidget {
  final int successScans;
  final int failedScans;
  final String? error;
  final int duration;
  final VoidCallback onReset;
  final Uint8List? imageBytes;

  const DebugInfoWidget({
    super.key,
    required this.successScans,
    required this.failedScans,
    required this.error,
    required this.duration,
    required this.onReset,
    this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Card(
        color: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Debug Info',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Success: $successScans', style: TextStyle(color: Colors.greenAccent)),
                  Text('Failed: $failedScans', style: TextStyle(color: Colors.redAccent)),
                ],
              ),
              const SizedBox(height: 4),
              Text('Duration: ${duration}ms', style: TextStyle(color: Colors.white70)),
              if (error != null && error!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text('Error: $error', style: TextStyle(color: Colors.orangeAccent)),
              ],
              if (imageBytes != null) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(imageBytes!, height: 100),
                ),
              ],
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onReset,
                  icon: Icon(Icons.refresh, color: Colors.white70),
                  label: Text('Reset', style: TextStyle(color: Colors.white70)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
