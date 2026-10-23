import 'package:drift/drift.dart';

@DataClassName('Contact')
class Contacts extends Table {
  TextColumn get id => text().clientDefault(() => '')();
  TextColumn get name => text().nullable()();
  TextColumn get qrToken => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Message')
class Messages extends Table {
  TextColumn get id => text().clientDefault(() => '')();
  TextColumn get chatId => text()();
  TextColumn get senderKey => text()();
  TextColumn get encryptedPayload => text()();
  TextColumn get mediaPath => text().nullable()();
  DateTimeColumn get timestamp => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Group')
class Groups extends Table {
  TextColumn get id => text().clientDefault(() => '')();
  TextColumn get title => text()();
  TextColumn get groupQrToken => text()();
  TextColumn get membersList => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}
