import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class ChatListTile extends StatelessWidget {
  final ChatMessage chat;
  final VoidCallback onTap;

  const ChatListTile({
    super.key,
    required this.chat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: chat.avatarColor,
                child: Text(
                  chat.title.isNotEmpty ? chat.title[0].toUpperCase() : '?',
                  style: const TextStyle(
                    color: Color(0xFF003828),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Title + subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFFCDD6F4),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      chat.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6C7086),
                      ),
                    ),
                  ],
                ),
              ),

              // Timestamp + unread badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    chat.time,
                    style: const TextStyle(fontSize: 11, color: Color(0xFF6C7086)),
                  ),
                  const SizedBox(height: 6),
                  if (chat.unreadCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF64FFDA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${chat.unreadCount}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF003828),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
