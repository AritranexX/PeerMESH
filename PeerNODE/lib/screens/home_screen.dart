import 'package:flutter/material.dart';
import '../widgets/chat_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock chat list data
  final List<ChatMessage> _chats = [
    ChatMessage(
      id: '1',
      title: 'Alice',
      lastMessage: 'Hey! Are you free?',
      time: '2:14 PM',
      unreadCount: 3,
      avatarColor: Color(0xFF64FFDA),
    ),
    ChatMessage(
      id: '2',
      title: 'Bob',
      lastMessage: 'Check out this link',
      time: 'Yesterday',
      unreadCount: 0,
      avatarColor: Color(0xFF80CBC4),
    ),
    ChatMessage(
      id: '3',
      title: 'Charlie',
      lastMessage: 'Dinner tonight?',
      time: 'Mar 15',
      unreadCount: 1,
      avatarColor: Color(0xFFA5D6A7),
    ),
  ];

  // Simulate navigating to a chat
  void _onChatTapped(ChatMessage chat) {
    // Navigate to chat screen with mock data
    // In a real app, we'd pass chat ID or data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PeerNODE'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          return ChatListTile(
            chat: _chats[index],
            onTap: () => _onChatTapped(_chats[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to QR scanner
          Navigator.of(context).pushNamed('/qr-scanner');
        },
        child: const Icon(Icons.qr_code_scanner),
        tooltip: 'Scan QR Code',
      ),
    );
  }
}

// Data model for a chat message/thread
class ChatMessage {
  final String id;
  final String title;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final Color avatarColor;

  ChatMessage({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.avatarColor,
  });
}