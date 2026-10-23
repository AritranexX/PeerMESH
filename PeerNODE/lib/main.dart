import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/qr_scanner_screen.dart';
import 'screens/profile_qr_screen.dart';
import 'services/deep_link_service.dart';
import 'data/database.dart';

final AppDatabase _db = AppDatabase(NativeQueryExecutor);

void main() {
  runApp(const PeerNODEApp());
}

class PeerNODEApp extends StatelessWidget {
  const PeerNODEApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize deep-link listener
    DeepLinkService(_db).init();

    return MaterialApp(
      title: 'PeerNODE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/chat': (context) => const ChatScreen(),
        '/qr-scanner': (context) => const QRScannerScreen(),
        '/profile-qr': (context) => const ProfileQrScreen(publicKey: ''),
      },
    );
  }
}
