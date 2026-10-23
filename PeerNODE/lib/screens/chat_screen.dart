import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'services/deep_link_service.dart';
import 'data/database.dart';

class ChatScreen extends StatefulWidget {
  final String? chatTitle;
  final String? chatId;
  final AppDatabase db;

  const ChatScreen({
    super.key,
    this.chatTitle,
    this.chatId,
    required this.db,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Mock messages for UI demonstration
  final List<MockMessage> _messages = [
    MockMessage(text: 'Hey! Are you free?', isMine: false, time: '2:10 PM'),
    MockMessage(text: "Yeah, what's up?", isMine: true, time: '2:11 PM'),
    MockMessage(text: 'Just wanted to check in. PeerNODE is pretty cool!', isMine: false, time: '2:12 PM'),
    MockMessage(text: 'Thanks! It\'s serverless P2P — no middlemen reading our messages.', isMine: true, time: '2:13 PM'),
    MockMessage(text: 'That\'s the best part.', isMine: false, time: '2:14 PM'),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(MockMessage(text: text, isMine: true, time: 'Now'));
    });

    _messageController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _clearChatHistory() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Chat History'),
        content: const Text('This will delete all messages in this chat. This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final chatId = widget.chatId ?? 'default';
    await widget.db.clearChatHistory(chatId);
    setState(() {
      _messages.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chat history cleared')),
    );
  }

  Future<void> _shareGroupLink() async {
    final link = DeepLinkService.buildGroupLink('GROUP_123', 'CREATOR_KEY');
    Share.share(link);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final title = widget.chatTitle ?? 'Chat';
    final isGroup = widget.chatId != null && widget.chatId!.startsWith('group');

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 48,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: colorScheme.primary,
              child: Text(
                title.isNotEmpty ? title[0].toUpperCase() : '?',
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const Text(
                  'P2P Encrypted',
                  style: TextStyle(fontSize: 11, color: Color(0xFF64FFDA)),
                ),
              ],
            ),
          ],
        ),
        actions: [
          if (isGroup)
            IconButton(
              icon: const Icon(Icons.link),
              tooltip: 'Share Group Link',
              onPressed: _shareGroupLink,
            ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      title: const Text('Clear Chat History',
                          style: TextStyle(color: Colors.redAccent)),
                      onTap: () {
                        Navigator.of(ctx).pop();
                        _clearChatHistory();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.close),
                      title: const Text('Cancel'),
                      onTap: () => Navigator.of(ctx).pop(),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(context, msg);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: const Color(0xFF1E1E2E),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      minLines: 1,
                      maxLines: 5,
                      style: const TextStyle(color: Color(0xFFCDD6F4)),
                      decoration: const InputDecoration(
                        hintText: 'Message...',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send_rounded),
                    color: colorScheme.primary,
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, MockMessage msg) {
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: msg.isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        decoration: BoxDecoration(
          color: msg.isMine ? colorScheme.primary.withOpacity(0.2) : const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(msg.isMine ? 16 : 4),
            bottomRight: Radius.circular(msg.isMine ? 4 : 16),
          ),
          border: Border.all(
            color: msg.isMine
                ? colorScheme.primary.withOpacity(0.3)
                : const Color(0xFF313244),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              msg.text,
              style: const TextStyle(color: Color(0xFFCDD6F4), fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              msg.time,
              style: const TextStyle(color: Color(0xFF6C7086), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class MockMessage {
  final String text;
  final bool isMine;
  final String time;

  MockMessage({
    required this.text,
    required this.isMine,
    required this.time,
  });
}

