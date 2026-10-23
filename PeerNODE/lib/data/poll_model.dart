import 'package:drift/drift.dart';

@DataClassName('Poll')
class Polls extends Table {
  TextColumn get id => text().clientDefault(() => '')();
  TextColumn get groupId => text()();
  TextColumn get question => text()();
  TextColumn get creatorPublicKey => text()();
  TextColumn get optionsJson => text()(); // JSON array of strings
  IntColumn get createdAt => integer()();
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Vote')
class Votes extends Table {
  TextColumn get id => text().clientDefault(() => '')();
  TextColumn get pollId => text()();
  TextColumn get voterPublicKey => text()();
  IntColumn get selectedOptionIndex => integer()();
  TextColumn get signature => text()(); // encrypted vote payload / cryptographic signature
  IntColumn get timestamp => integer()();
  @override
  Set<Column> get primaryKey => {id};
}
