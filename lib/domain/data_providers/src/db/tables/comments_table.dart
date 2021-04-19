import 'package:moor/moor.dart';

class Comments extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get postId => integer()();

  TextColumn get name => text()();

  TextColumn get body => text()();

  TextColumn get email => text()();
}
