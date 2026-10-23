import 'package:flutter/material.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Scan QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                border: Border.all(color: const Color(0xFF64FFDA), width: 2),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF64FFDA).withOpacity(0.15),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.qr_code_scanner,
                  size: 120,
                  color: Color(0xFF64FFDA),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Point your camera at a PeerNODE QR code',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFFCDD6F4),
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Link users securely via local scanning',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF6C7086),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}