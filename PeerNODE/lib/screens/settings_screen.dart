import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'services/deep_link_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.storage, size: 24),
              title: const Text('Storage Management'),
              subtitle: const Text('View and manage local cache, media files'),
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Storage Management - Coming Soon')),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.auto_fix_high, size: 24),
              title: const Text('Auto-Cleanup Settings'),
              subtitle: const Text('Automatically delete old media and cache'),
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Auto-Cleanup Settings - Coming Soon')),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.qr_code, size: 24),
                  title: const Text('Link Devices'),
                  subtitle: const Text('Scan QR codes or share invite links'),
                  trailing: const Icon(Icons.chevron_right, size: 20),
                  onTap: () {
                    Navigator.of(context).pushNamed('/profile-qr');
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.link, size: 24),
                  title: const Text('Copy Invite Link'),
                  subtitle: const Text('Copy personal chat link to clipboard'),
                  trailing: const Icon(Icons.copy, size: 20),
                  onTap: () {
                    final link = DeepLinkService.buildChatLink('YOUR_PUBLIC_KEY');
                    Share.share(link);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Link copied: $link')),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.notifications, size: 24),
              title: const Text('Notifications'),
              subtitle: const Text('Configure push and local notifications'),
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notifications - Coming Soon')),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.privacy_tip, size: 24),
              title: const Text('Privacy & Security'),
              subtitle: const Text('End-to-end encryption settings'),
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Privacy & Security - Coming Soon')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
