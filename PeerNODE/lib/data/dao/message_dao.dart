import 'package:drift/drift.dart';
import 'database.dart';

part 'message_dao.g.dart';

@DriftDao(tables: [Messages])
class MessageDao extends _$MessageDaoMixin {
  MessageDao(super.db);

  Stream<List<Message>> get allMessages => select(messages).watch();
  Stream<List<Message>> watchMessagesByChat(String chatId) =>
      (select(messages)..where((m) => m.chatId.equals(chatId))).watch();

  Future<void> clearChatHistory(String chatId) async {
    await (delete(messages)..where((m) => m.chatId.equals(chatId))).go();
  }

  Future<void> clearGroupHistory(String groupId) async {
    await (delete(messages)..where((m) => m.chatId.equals(groupId))).go();
    await (delete(groups)..where((g) => g.id.equals(groupId))).go();
  }
}