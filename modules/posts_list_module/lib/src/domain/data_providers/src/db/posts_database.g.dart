// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Post extends DataClass implements Insertable<Post> {
  final int id;
  final int id1;
  final int userId;
  final String title;
  final String body;
  Post(
      {@required this.id,
      @required this.id1,
      @required this.userId,
      @required this.title,
      @required this.body});
  factory Post.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Post(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      id1: intType.mapFromDatabaseResponse(data['${effectivePrefix}id1']),
      userId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      body: stringType.mapFromDatabaseResponse(data['${effectivePrefix}body']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || id1 != null) {
      map['id1'] = Variable<int>(id1);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || body != null) {
      map['body'] = Variable<String>(body);
    }
    return map;
  }

  PostsCompanion toCompanion(bool nullToAbsent) {
    return PostsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      id1: id1 == null && nullToAbsent ? const Value.absent() : Value(id1),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
    );
  }

  factory Post.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Post(
      id: serializer.fromJson<int>(json['id']),
      id1: serializer.fromJson<int>(json['id1']),
      userId: serializer.fromJson<int>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'id1': serializer.toJson<int>(id1),
      'userId': serializer.toJson<int>(userId),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
    };
  }

  Post copyWith({int id, int id1, int userId, String title, String body}) =>
      Post(
        id: id ?? this.id,
        id1: id1 ?? this.id1,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        body: body ?? this.body,
      );
  @override
  String toString() {
    return (StringBuffer('Post(')
          ..write('id: $id, ')
          ..write('id1: $id1, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(id1.hashCode,
          $mrjc(userId.hashCode, $mrjc(title.hashCode, body.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Post &&
          other.id == this.id &&
          other.id1 == this.id1 &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.body == this.body);
}

class PostsCompanion extends UpdateCompanion<Post> {
  final Value<int> id;
  final Value<int> id1;
  final Value<int> userId;
  final Value<String> title;
  final Value<String> body;
  const PostsCompanion({
    this.id = const Value.absent(),
    this.id1 = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
  });
  PostsCompanion.insert({
    this.id = const Value.absent(),
    this.id1 = const Value.absent(),
    @required int userId,
    @required String title,
    @required String body,
  })  : userId = Value(userId),
        title = Value(title),
        body = Value(body);
  static Insertable<Post> custom({
    Expression<int> id,
    Expression<int> id1,
    Expression<int> userId,
    Expression<String> title,
    Expression<String> body,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (id1 != null) 'id1': id1,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
    });
  }

  PostsCompanion copyWith(
      {Value<int> id,
      Value<int> id1,
      Value<int> userId,
      Value<String> title,
      Value<String> body}) {
    return PostsCompanion(
      id: id ?? this.id,
      id1: id1 ?? this.id1,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (id1.present) {
      map['id1'] = Variable<int>(id1.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostsCompanion(')
          ..write('id: $id, ')
          ..write('id1: $id1, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }
}

class $PostsTable extends Posts with TableInfo<$PostsTable, Post> {
  final GeneratedDatabase _db;
  final String _alias;
  $PostsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _id1Meta = const VerificationMeta('id1');
  GeneratedIntColumn _id1;
  @override
  GeneratedIntColumn get id1 => _id1 ??= _constructId1();
  GeneratedIntColumn _constructId1() {
    return GeneratedIntColumn('id1', $tableName, false,
        defaultValue: Constant(-1));
  }

  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  GeneratedIntColumn _userId;
  @override
  GeneratedIntColumn get userId => _userId ??= _constructUserId();
  GeneratedIntColumn _constructUserId() {
    return GeneratedIntColumn(
      'user_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _bodyMeta = const VerificationMeta('body');
  GeneratedTextColumn _body;
  @override
  GeneratedTextColumn get body => _body ??= _constructBody();
  GeneratedTextColumn _constructBody() {
    return GeneratedTextColumn(
      'body',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, id1, userId, title, body];
  @override
  $PostsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'posts';
  @override
  final String actualTableName = 'posts';
  @override
  VerificationContext validateIntegrity(Insertable<Post> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('id1')) {
      context.handle(
          _id1Meta, id1.isAcceptableOrUnknown(data['id1'], _id1Meta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id'], _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body'], _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Post map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Post.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PostsTable createAlias(String alias) {
    return $PostsTable(_db, alias);
  }
}

class Comment extends DataClass implements Insertable<Comment> {
  final int id;
  final int postId;
  final String name;
  final String body;
  final String email;
  Comment(
      {@required this.id,
      @required this.postId,
      @required this.name,
      @required this.body,
      @required this.email});
  factory Comment.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Comment(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      postId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}post_id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      body: stringType.mapFromDatabaseResponse(data['${effectivePrefix}body']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || postId != null) {
      map['post_id'] = Variable<int>(postId);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || body != null) {
      map['body'] = Variable<String>(body);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    return map;
  }

  CommentsCompanion toCompanion(bool nullToAbsent) {
    return CommentsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      postId:
          postId == null && nullToAbsent ? const Value.absent() : Value(postId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
    );
  }

  factory Comment.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Comment(
      id: serializer.fromJson<int>(json['id']),
      postId: serializer.fromJson<int>(json['postId']),
      name: serializer.fromJson<String>(json['name']),
      body: serializer.fromJson<String>(json['body']),
      email: serializer.fromJson<String>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'postId': serializer.toJson<int>(postId),
      'name': serializer.toJson<String>(name),
      'body': serializer.toJson<String>(body),
      'email': serializer.toJson<String>(email),
    };
  }

  Comment copyWith(
          {int id, int postId, String name, String body, String email}) =>
      Comment(
        id: id ?? this.id,
        postId: postId ?? this.postId,
        name: name ?? this.name,
        body: body ?? this.body,
        email: email ?? this.email,
      );
  @override
  String toString() {
    return (StringBuffer('Comment(')
          ..write('id: $id, ')
          ..write('postId: $postId, ')
          ..write('name: $name, ')
          ..write('body: $body, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(postId.hashCode,
          $mrjc(name.hashCode, $mrjc(body.hashCode, email.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Comment &&
          other.id == this.id &&
          other.postId == this.postId &&
          other.name == this.name &&
          other.body == this.body &&
          other.email == this.email);
}

class CommentsCompanion extends UpdateCompanion<Comment> {
  final Value<int> id;
  final Value<int> postId;
  final Value<String> name;
  final Value<String> body;
  final Value<String> email;
  const CommentsCompanion({
    this.id = const Value.absent(),
    this.postId = const Value.absent(),
    this.name = const Value.absent(),
    this.body = const Value.absent(),
    this.email = const Value.absent(),
  });
  CommentsCompanion.insert({
    this.id = const Value.absent(),
    @required int postId,
    @required String name,
    @required String body,
    @required String email,
  })  : postId = Value(postId),
        name = Value(name),
        body = Value(body),
        email = Value(email);
  static Insertable<Comment> custom({
    Expression<int> id,
    Expression<int> postId,
    Expression<String> name,
    Expression<String> body,
    Expression<String> email,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (postId != null) 'post_id': postId,
      if (name != null) 'name': name,
      if (body != null) 'body': body,
      if (email != null) 'email': email,
    });
  }

  CommentsCompanion copyWith(
      {Value<int> id,
      Value<int> postId,
      Value<String> name,
      Value<String> body,
      Value<String> email}) {
    return CommentsCompanion(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      name: name ?? this.name,
      body: body ?? this.body,
      email: email ?? this.email,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (postId.present) {
      map['post_id'] = Variable<int>(postId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommentsCompanion(')
          ..write('id: $id, ')
          ..write('postId: $postId, ')
          ..write('name: $name, ')
          ..write('body: $body, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }
}

class $CommentsTable extends Comments with TableInfo<$CommentsTable, Comment> {
  final GeneratedDatabase _db;
  final String _alias;
  $CommentsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _postIdMeta = const VerificationMeta('postId');
  GeneratedIntColumn _postId;
  @override
  GeneratedIntColumn get postId => _postId ??= _constructPostId();
  GeneratedIntColumn _constructPostId() {
    return GeneratedIntColumn(
      'post_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _bodyMeta = const VerificationMeta('body');
  GeneratedTextColumn _body;
  @override
  GeneratedTextColumn get body => _body ??= _constructBody();
  GeneratedTextColumn _constructBody() {
    return GeneratedTextColumn(
      'body',
      $tableName,
      false,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, postId, name, body, email];
  @override
  $CommentsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'comments';
  @override
  final String actualTableName = 'comments';
  @override
  VerificationContext validateIntegrity(Insertable<Comment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('post_id')) {
      context.handle(_postIdMeta,
          postId.isAcceptableOrUnknown(data['post_id'], _postIdMeta));
    } else if (isInserting) {
      context.missing(_postIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body'], _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Comment map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Comment.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CommentsTable createAlias(String alias) {
    return $CommentsTable(_db, alias);
  }
}

abstract class _$PostsDatabase extends GeneratedDatabase {
  _$PostsDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $PostsTable _posts;
  $PostsTable get posts => _posts ??= $PostsTable(this);
  $CommentsTable _comments;
  $CommentsTable get comments => _comments ??= $CommentsTable(this);
  Future<int> migrateFrom1to2() {
    return customUpdate(
      'update posts set id1 = id',
      variables: [],
      updates: {},
      updateKind: UpdateKind.delete,
    );
  }

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [posts, comments];
}
