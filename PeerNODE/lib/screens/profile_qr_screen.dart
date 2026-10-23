import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'services/deep_link_service.dart';
import 'data/database.dart';

class ProfileQrScreen extends StatelessWidget {
  final String publicKey;
  const ProfileQrScreen({super.key, required this.publicKey});

  @override
  Widget build(BuildContext context) {
    final link = DeepLinkService.buildChatLink(publicKey.isNotEmpty ? publicKey : 'YOUR_PUBLIC_KEY');
    return Scaffold(
      appBar: AppBar(title: const Text('My QR Identity')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: link,
              version: QrVersions.auto,
              size: 240.0,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 24),
            const Text('Scan this code to link with me securely',
                style: TextStyle(color: Color(0xFFCDD6F4))),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy Link'),
                  onPressed: () {
                    Share.share(link);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Link copied: $link')),
                    );
                  },
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                  onPressed: () => Share.share(link),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
