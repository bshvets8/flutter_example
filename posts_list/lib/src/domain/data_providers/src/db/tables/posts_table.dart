import 'package:moor/moor.dart';

class Posts extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get id1 => integer().withDefault(Constant(-1))();

  IntColumn get userId => integer()();

  TextColumn get title => text()();

  TextColumn get body => text()();
}
