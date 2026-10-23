import 'package:drift/drift.dart';
import 'tables.dart';
part 'database.g.dart';

@DriftDatabase(tables: [Contacts, Messages, Groups], daos: [MessageDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);
  @override
  int get schemaVersion => 1;

  // Auto-cleanup: delete messages older than 30 days
  Future<int> purgeOldMessages() async {
    final cutoff = DateTime.now().subtract(const Duration(days: 30));
    return customUpdate(
      'DELETE FROM messages WHERE timestamp < ?',
      variables: [Variable(cutoff)],
    );
  }

  Contacts get contacts => contacts; // placeholder for generated accessor
}

@DriftDao(tables: [Messages])
class MessageDao extends DatabaseAccessor<AppDatabase> with _$MessageDaoMixin {
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