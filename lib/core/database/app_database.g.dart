// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordHashMeta =
      const VerificationMeta('passwordHash');
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
      'password_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _saltMeta = const VerificationMeta('salt');
  @override
  late final GeneratedColumn<String> salt = GeneratedColumn<String>(
      'salt', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _yearGroupMeta =
      const VerificationMeta('yearGroup');
  @override
  late final GeneratedColumn<String> yearGroup = GeneratedColumn<String>(
      'year_group', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _avatarColorMeta =
      const VerificationMeta('avatarColor');
  @override
  late final GeneratedColumn<String> avatarColor = GeneratedColumn<String>(
      'avatar_color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        email,
        name,
        passwordHash,
        salt,
        role,
        yearGroup,
        createdAt,
        updatedAt,
        avatarColor
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
          _passwordHashMeta,
          passwordHash.isAcceptableOrUnknown(
              data['password_hash']!, _passwordHashMeta));
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('salt')) {
      context.handle(
          _saltMeta, salt.isAcceptableOrUnknown(data['salt']!, _saltMeta));
    } else if (isInserting) {
      context.missing(_saltMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('year_group')) {
      context.handle(_yearGroupMeta,
          yearGroup.isAcceptableOrUnknown(data['year_group']!, _yearGroupMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('avatar_color')) {
      context.handle(
          _avatarColorMeta,
          avatarColor.isAcceptableOrUnknown(
              data['avatar_color']!, _avatarColorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      passwordHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_hash'])!,
      salt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}salt'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      yearGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}year_group']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      avatarColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_color']),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String email;
  final String name;
  final String passwordHash;
  final String salt;
  final String role;
  final String? yearGroup;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? avatarColor;
  const User(
      {required this.id,
      required this.email,
      required this.name,
      required this.passwordHash,
      required this.salt,
      required this.role,
      this.yearGroup,
      required this.createdAt,
      required this.updatedAt,
      this.avatarColor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['email'] = Variable<String>(email);
    map['name'] = Variable<String>(name);
    map['password_hash'] = Variable<String>(passwordHash);
    map['salt'] = Variable<String>(salt);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || yearGroup != null) {
      map['year_group'] = Variable<String>(yearGroup);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || avatarColor != null) {
      map['avatar_color'] = Variable<String>(avatarColor);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      email: Value(email),
      name: Value(name),
      passwordHash: Value(passwordHash),
      salt: Value(salt),
      role: Value(role),
      yearGroup: yearGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(yearGroup),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      avatarColor: avatarColor == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarColor),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      name: serializer.fromJson<String>(json['name']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      salt: serializer.fromJson<String>(json['salt']),
      role: serializer.fromJson<String>(json['role']),
      yearGroup: serializer.fromJson<String?>(json['yearGroup']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      avatarColor: serializer.fromJson<String?>(json['avatarColor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'email': serializer.toJson<String>(email),
      'name': serializer.toJson<String>(name),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'salt': serializer.toJson<String>(salt),
      'role': serializer.toJson<String>(role),
      'yearGroup': serializer.toJson<String?>(yearGroup),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'avatarColor': serializer.toJson<String?>(avatarColor),
    };
  }

  User copyWith(
          {int? id,
          String? email,
          String? name,
          String? passwordHash,
          String? salt,
          String? role,
          Value<String?> yearGroup = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<String?> avatarColor = const Value.absent()}) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        passwordHash: passwordHash ?? this.passwordHash,
        salt: salt ?? this.salt,
        role: role ?? this.role,
        yearGroup: yearGroup.present ? yearGroup.value : this.yearGroup,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        avatarColor: avatarColor.present ? avatarColor.value : this.avatarColor,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('salt: $salt, ')
          ..write('role: $role, ')
          ..write('yearGroup: $yearGroup, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('avatarColor: $avatarColor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, email, name, passwordHash, salt, role,
      yearGroup, createdAt, updatedAt, avatarColor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.email == this.email &&
          other.name == this.name &&
          other.passwordHash == this.passwordHash &&
          other.salt == this.salt &&
          other.role == this.role &&
          other.yearGroup == this.yearGroup &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.avatarColor == this.avatarColor);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> email;
  final Value<String> name;
  final Value<String> passwordHash;
  final Value<String> salt;
  final Value<String> role;
  final Value<String?> yearGroup;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> avatarColor;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.salt = const Value.absent(),
    this.role = const Value.absent(),
    this.yearGroup = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.avatarColor = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String email,
    required String name,
    required String passwordHash,
    required String salt,
    required String role,
    this.yearGroup = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.avatarColor = const Value.absent(),
  })  : email = Value(email),
        name = Value(name),
        passwordHash = Value(passwordHash),
        salt = Value(salt),
        role = Value(role),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? email,
    Expression<String>? name,
    Expression<String>? passwordHash,
    Expression<String>? salt,
    Expression<String>? role,
    Expression<String>? yearGroup,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? avatarColor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (salt != null) 'salt': salt,
      if (role != null) 'role': role,
      if (yearGroup != null) 'year_group': yearGroup,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (avatarColor != null) 'avatar_color': avatarColor,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? email,
      Value<String>? name,
      Value<String>? passwordHash,
      Value<String>? salt,
      Value<String>? role,
      Value<String?>? yearGroup,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String?>? avatarColor}) {
    return UsersCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      passwordHash: passwordHash ?? this.passwordHash,
      salt: salt ?? this.salt,
      role: role ?? this.role,
      yearGroup: yearGroup ?? this.yearGroup,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      avatarColor: avatarColor ?? this.avatarColor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (salt.present) {
      map['salt'] = Variable<String>(salt.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (yearGroup.present) {
      map['year_group'] = Variable<String>(yearGroup.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (avatarColor.present) {
      map['avatar_color'] = Variable<String>(avatarColor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('salt: $salt, ')
          ..write('role: $role, ')
          ..write('yearGroup: $yearGroup, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('avatarColor: $avatarColor')
          ..write(')'))
        .toString();
  }
}

class $MotivationEntriesTable extends MotivationEntries
    with TableInfo<$MotivationEntriesTable, MotivationEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MotivationEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, date, level, note, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'motivation_entries';
  @override
  VerificationContext validateIntegrity(Insertable<MotivationEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MotivationEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MotivationEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MotivationEntriesTable createAlias(String alias) {
    return $MotivationEntriesTable(attachedDatabase, alias);
  }
}

class MotivationEntry extends DataClass implements Insertable<MotivationEntry> {
  final int id;
  final int userId;
  final DateTime date;
  final int level;
  final String? note;
  final DateTime createdAt;
  const MotivationEntry(
      {required this.id,
      required this.userId,
      required this.date,
      required this.level,
      this.note,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['date'] = Variable<DateTime>(date);
    map['level'] = Variable<int>(level);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MotivationEntriesCompanion toCompanion(bool nullToAbsent) {
    return MotivationEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      date: Value(date),
      level: Value(level),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory MotivationEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MotivationEntry(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      date: serializer.fromJson<DateTime>(json['date']),
      level: serializer.fromJson<int>(json['level']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'date': serializer.toJson<DateTime>(date),
      'level': serializer.toJson<int>(level),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MotivationEntry copyWith(
          {int? id,
          int? userId,
          DateTime? date,
          int? level,
          Value<String?> note = const Value.absent(),
          DateTime? createdAt}) =>
      MotivationEntry(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        date: date ?? this.date,
        level: level ?? this.level,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('MotivationEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('level: $level, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, date, level, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MotivationEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.level == this.level &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class MotivationEntriesCompanion extends UpdateCompanion<MotivationEntry> {
  final Value<int> id;
  final Value<int> userId;
  final Value<DateTime> date;
  final Value<int> level;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const MotivationEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.level = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MotivationEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required DateTime date,
    required int level,
    this.note = const Value.absent(),
    required DateTime createdAt,
  })  : userId = Value(userId),
        date = Value(date),
        level = Value(level),
        createdAt = Value(createdAt);
  static Insertable<MotivationEntry> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<DateTime>? date,
    Expression<int>? level,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (level != null) 'level': level,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MotivationEntriesCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<DateTime>? date,
      Value<int>? level,
      Value<String?>? note,
      Value<DateTime>? createdAt}) {
    return MotivationEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      level: level ?? this.level,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MotivationEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('level: $level, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SchoolUpdatesTable extends SchoolUpdates
    with TableInfo<$SchoolUpdatesTable, SchoolUpdate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchoolUpdatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _authorIdMeta =
      const VerificationMeta('authorId');
  @override
  late final GeneratedColumn<int> authorId = GeneratedColumn<int>(
      'author_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _authorNameMeta =
      const VerificationMeta('authorName');
  @override
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
      'author_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isPinnedMeta =
      const VerificationMeta('isPinned');
  @override
  late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>(
      'is_pinned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_pinned" IN (0, 1))'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        authorId,
        authorName,
        title,
        content,
        category,
        isPinned,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'school_updates';
  @override
  VerificationContext validateIntegrity(Insertable<SchoolUpdate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('author_id')) {
      context.handle(_authorIdMeta,
          authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta));
    } else if (isInserting) {
      context.missing(_authorIdMeta);
    }
    if (data.containsKey('author_name')) {
      context.handle(
          _authorNameMeta,
          authorName.isAcceptableOrUnknown(
              data['author_name']!, _authorNameMeta));
    } else if (isInserting) {
      context.missing(_authorNameMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_pinned')) {
      context.handle(_isPinnedMeta,
          isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta));
    } else if (isInserting) {
      context.missing(_isPinnedMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SchoolUpdate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SchoolUpdate(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      authorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}author_id'])!,
      authorName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_name'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      isPinned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pinned'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SchoolUpdatesTable createAlias(String alias) {
    return $SchoolUpdatesTable(attachedDatabase, alias);
  }
}

class SchoolUpdate extends DataClass implements Insertable<SchoolUpdate> {
  final int id;
  final int authorId;
  final String authorName;
  final String title;
  final String content;
  final String category;
  final bool isPinned;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SchoolUpdate(
      {required this.id,
      required this.authorId,
      required this.authorName,
      required this.title,
      required this.content,
      required this.category,
      required this.isPinned,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['author_id'] = Variable<int>(authorId);
    map['author_name'] = Variable<String>(authorName);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['category'] = Variable<String>(category);
    map['is_pinned'] = Variable<bool>(isPinned);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SchoolUpdatesCompanion toCompanion(bool nullToAbsent) {
    return SchoolUpdatesCompanion(
      id: Value(id),
      authorId: Value(authorId),
      authorName: Value(authorName),
      title: Value(title),
      content: Value(content),
      category: Value(category),
      isPinned: Value(isPinned),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SchoolUpdate.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SchoolUpdate(
      id: serializer.fromJson<int>(json['id']),
      authorId: serializer.fromJson<int>(json['authorId']),
      authorName: serializer.fromJson<String>(json['authorName']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      category: serializer.fromJson<String>(json['category']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'authorId': serializer.toJson<int>(authorId),
      'authorName': serializer.toJson<String>(authorName),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'category': serializer.toJson<String>(category),
      'isPinned': serializer.toJson<bool>(isPinned),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SchoolUpdate copyWith(
          {int? id,
          int? authorId,
          String? authorName,
          String? title,
          String? content,
          String? category,
          bool? isPinned,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      SchoolUpdate(
        id: id ?? this.id,
        authorId: authorId ?? this.authorId,
        authorName: authorName ?? this.authorName,
        title: title ?? this.title,
        content: content ?? this.content,
        category: category ?? this.category,
        isPinned: isPinned ?? this.isPinned,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('SchoolUpdate(')
          ..write('id: $id, ')
          ..write('authorId: $authorId, ')
          ..write('authorName: $authorName, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('category: $category, ')
          ..write('isPinned: $isPinned, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, authorId, authorName, title, content,
      category, isPinned, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SchoolUpdate &&
          other.id == this.id &&
          other.authorId == this.authorId &&
          other.authorName == this.authorName &&
          other.title == this.title &&
          other.content == this.content &&
          other.category == this.category &&
          other.isPinned == this.isPinned &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SchoolUpdatesCompanion extends UpdateCompanion<SchoolUpdate> {
  final Value<int> id;
  final Value<int> authorId;
  final Value<String> authorName;
  final Value<String> title;
  final Value<String> content;
  final Value<String> category;
  final Value<bool> isPinned;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SchoolUpdatesCompanion({
    this.id = const Value.absent(),
    this.authorId = const Value.absent(),
    this.authorName = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.category = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SchoolUpdatesCompanion.insert({
    this.id = const Value.absent(),
    required int authorId,
    required String authorName,
    required String title,
    required String content,
    required String category,
    required bool isPinned,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : authorId = Value(authorId),
        authorName = Value(authorName),
        title = Value(title),
        content = Value(content),
        category = Value(category),
        isPinned = Value(isPinned),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<SchoolUpdate> custom({
    Expression<int>? id,
    Expression<int>? authorId,
    Expression<String>? authorName,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? category,
    Expression<bool>? isPinned,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (authorId != null) 'author_id': authorId,
      if (authorName != null) 'author_name': authorName,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (category != null) 'category': category,
      if (isPinned != null) 'is_pinned': isPinned,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SchoolUpdatesCompanion copyWith(
      {Value<int>? id,
      Value<int>? authorId,
      Value<String>? authorName,
      Value<String>? title,
      Value<String>? content,
      Value<String>? category,
      Value<bool>? isPinned,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return SchoolUpdatesCompanion(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      isPinned: isPinned ?? this.isPinned,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<int>(authorId.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchoolUpdatesCompanion(')
          ..write('id: $id, ')
          ..write('authorId: $authorId, ')
          ..write('authorName: $authorName, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('category: $category, ')
          ..write('isPinned: $isPinned, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _hasCompletedOnboardingMeta =
      const VerificationMeta('hasCompletedOnboarding');
  @override
  late final GeneratedColumn<bool> hasCompletedOnboarding =
      GeneratedColumn<bool>('has_completed_onboarding', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("has_completed_onboarding" IN (0, 1))'));
  static const VerificationMeta _currentUserIdMeta =
      const VerificationMeta('currentUserId');
  @override
  late final GeneratedColumn<int> currentUserId = GeneratedColumn<int>(
      'current_user_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isDarkModeMeta =
      const VerificationMeta('isDarkMode');
  @override
  late final GeneratedColumn<bool> isDarkMode = GeneratedColumn<bool>(
      'is_dark_mode', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_dark_mode" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, hasCompletedOnboarding, currentUserId, isDarkMode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(Insertable<AppSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('has_completed_onboarding')) {
      context.handle(
          _hasCompletedOnboardingMeta,
          hasCompletedOnboarding.isAcceptableOrUnknown(
              data['has_completed_onboarding']!, _hasCompletedOnboardingMeta));
    } else if (isInserting) {
      context.missing(_hasCompletedOnboardingMeta);
    }
    if (data.containsKey('current_user_id')) {
      context.handle(
          _currentUserIdMeta,
          currentUserId.isAcceptableOrUnknown(
              data['current_user_id']!, _currentUserIdMeta));
    }
    if (data.containsKey('is_dark_mode')) {
      context.handle(
          _isDarkModeMeta,
          isDarkMode.isAcceptableOrUnknown(
              data['is_dark_mode']!, _isDarkModeMeta));
    } else if (isInserting) {
      context.missing(_isDarkModeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      hasCompletedOnboarding: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}has_completed_onboarding'])!,
      currentUserId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_user_id']),
      isDarkMode: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dark_mode'])!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final bool hasCompletedOnboarding;
  final int? currentUserId;
  final bool isDarkMode;
  const AppSetting(
      {required this.id,
      required this.hasCompletedOnboarding,
      this.currentUserId,
      required this.isDarkMode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['has_completed_onboarding'] = Variable<bool>(hasCompletedOnboarding);
    if (!nullToAbsent || currentUserId != null) {
      map['current_user_id'] = Variable<int>(currentUserId);
    }
    map['is_dark_mode'] = Variable<bool>(isDarkMode);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      hasCompletedOnboarding: Value(hasCompletedOnboarding),
      currentUserId: currentUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentUserId),
      isDarkMode: Value(isDarkMode),
    );
  }

  factory AppSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      hasCompletedOnboarding:
          serializer.fromJson<bool>(json['hasCompletedOnboarding']),
      currentUserId: serializer.fromJson<int?>(json['currentUserId']),
      isDarkMode: serializer.fromJson<bool>(json['isDarkMode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'hasCompletedOnboarding': serializer.toJson<bool>(hasCompletedOnboarding),
      'currentUserId': serializer.toJson<int?>(currentUserId),
      'isDarkMode': serializer.toJson<bool>(isDarkMode),
    };
  }

  AppSetting copyWith(
          {int? id,
          bool? hasCompletedOnboarding,
          Value<int?> currentUserId = const Value.absent(),
          bool? isDarkMode}) =>
      AppSetting(
        id: id ?? this.id,
        hasCompletedOnboarding:
            hasCompletedOnboarding ?? this.hasCompletedOnboarding,
        currentUserId:
            currentUserId.present ? currentUserId.value : this.currentUserId,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('hasCompletedOnboarding: $hasCompletedOnboarding, ')
          ..write('currentUserId: $currentUserId, ')
          ..write('isDarkMode: $isDarkMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, hasCompletedOnboarding, currentUserId, isDarkMode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.hasCompletedOnboarding == this.hasCompletedOnboarding &&
          other.currentUserId == this.currentUserId &&
          other.isDarkMode == this.isDarkMode);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<bool> hasCompletedOnboarding;
  final Value<int?> currentUserId;
  final Value<bool> isDarkMode;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.hasCompletedOnboarding = const Value.absent(),
    this.currentUserId = const Value.absent(),
    this.isDarkMode = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    required bool hasCompletedOnboarding,
    this.currentUserId = const Value.absent(),
    required bool isDarkMode,
  })  : hasCompletedOnboarding = Value(hasCompletedOnboarding),
        isDarkMode = Value(isDarkMode);
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<bool>? hasCompletedOnboarding,
    Expression<int>? currentUserId,
    Expression<bool>? isDarkMode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hasCompletedOnboarding != null)
        'has_completed_onboarding': hasCompletedOnboarding,
      if (currentUserId != null) 'current_user_id': currentUserId,
      if (isDarkMode != null) 'is_dark_mode': isDarkMode,
    });
  }

  AppSettingsCompanion copyWith(
      {Value<int>? id,
      Value<bool>? hasCompletedOnboarding,
      Value<int?>? currentUserId,
      Value<bool>? isDarkMode}) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      currentUserId: currentUserId ?? this.currentUserId,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (hasCompletedOnboarding.present) {
      map['has_completed_onboarding'] =
          Variable<bool>(hasCompletedOnboarding.value);
    }
    if (currentUserId.present) {
      map['current_user_id'] = Variable<int>(currentUserId.value);
    }
    if (isDarkMode.present) {
      map['is_dark_mode'] = Variable<bool>(isDarkMode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('hasCompletedOnboarding: $hasCompletedOnboarding, ')
          ..write('currentUserId: $currentUserId, ')
          ..write('isDarkMode: $isDarkMode')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $MotivationEntriesTable motivationEntries =
      $MotivationEntriesTable(this);
  late final $SchoolUpdatesTable schoolUpdates = $SchoolUpdatesTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, motivationEntries, schoolUpdates, appSettings];
}

typedef $$UsersTableInsertCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String email,
  required String name,
  required String passwordHash,
  required String salt,
  required String role,
  Value<String?> yearGroup,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String?> avatarColor,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> email,
  Value<String> name,
  Value<String> passwordHash,
  Value<String> salt,
  Value<String> role,
  Value<String?> yearGroup,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String?> avatarColor,
});

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableProcessedTableManager,
    $$UsersTableInsertCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UsersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UsersTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$UsersTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> passwordHash = const Value.absent(),
            Value<String> salt = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String?> yearGroup = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String?> avatarColor = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            email: email,
            name: name,
            passwordHash: passwordHash,
            salt: salt,
            role: role,
            yearGroup: yearGroup,
            createdAt: createdAt,
            updatedAt: updatedAt,
            avatarColor: avatarColor,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String email,
            required String name,
            required String passwordHash,
            required String salt,
            required String role,
            Value<String?> yearGroup = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String?> avatarColor = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            email: email,
            name: name,
            passwordHash: passwordHash,
            salt: salt,
            role: role,
            yearGroup: yearGroup,
            createdAt: createdAt,
            updatedAt: updatedAt,
            avatarColor: avatarColor,
          ),
        ));
}

class $$UsersTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableProcessedTableManager,
    $$UsersTableInsertCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder> {
  $$UsersTableProcessedTableManager(super.$state);
}

class $$UsersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get email => $state.composableBuilder(
      column: $state.table.email,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get passwordHash => $state.composableBuilder(
      column: $state.table.passwordHash,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get salt => $state.composableBuilder(
      column: $state.table.salt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get role => $state.composableBuilder(
      column: $state.table.role,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get yearGroup => $state.composableBuilder(
      column: $state.table.yearGroup,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get avatarColor => $state.composableBuilder(
      column: $state.table.avatarColor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UsersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get email => $state.composableBuilder(
      column: $state.table.email,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get passwordHash => $state.composableBuilder(
      column: $state.table.passwordHash,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get salt => $state.composableBuilder(
      column: $state.table.salt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get role => $state.composableBuilder(
      column: $state.table.role,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get yearGroup => $state.composableBuilder(
      column: $state.table.yearGroup,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get avatarColor => $state.composableBuilder(
      column: $state.table.avatarColor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$MotivationEntriesTableInsertCompanionBuilder
    = MotivationEntriesCompanion Function({
  Value<int> id,
  required int userId,
  required DateTime date,
  required int level,
  Value<String?> note,
  required DateTime createdAt,
});
typedef $$MotivationEntriesTableUpdateCompanionBuilder
    = MotivationEntriesCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<DateTime> date,
  Value<int> level,
  Value<String?> note,
  Value<DateTime> createdAt,
});

class $$MotivationEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MotivationEntriesTable,
    MotivationEntry,
    $$MotivationEntriesTableFilterComposer,
    $$MotivationEntriesTableOrderingComposer,
    $$MotivationEntriesTableProcessedTableManager,
    $$MotivationEntriesTableInsertCompanionBuilder,
    $$MotivationEntriesTableUpdateCompanionBuilder> {
  $$MotivationEntriesTableTableManager(
      _$AppDatabase db, $MotivationEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MotivationEntriesTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$MotivationEntriesTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$MotivationEntriesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MotivationEntriesCompanion(
            id: id,
            userId: userId,
            date: date,
            level: level,
            note: note,
            createdAt: createdAt,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required DateTime date,
            required int level,
            Value<String?> note = const Value.absent(),
            required DateTime createdAt,
          }) =>
              MotivationEntriesCompanion.insert(
            id: id,
            userId: userId,
            date: date,
            level: level,
            note: note,
            createdAt: createdAt,
          ),
        ));
}

class $$MotivationEntriesTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $MotivationEntriesTable,
        MotivationEntry,
        $$MotivationEntriesTableFilterComposer,
        $$MotivationEntriesTableOrderingComposer,
        $$MotivationEntriesTableProcessedTableManager,
        $$MotivationEntriesTableInsertCompanionBuilder,
        $$MotivationEntriesTableUpdateCompanionBuilder> {
  $$MotivationEntriesTableProcessedTableManager(super.$state);
}

class $$MotivationEntriesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $MotivationEntriesTable> {
  $$MotivationEntriesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get userId => $state.composableBuilder(
      column: $state.table.userId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get level => $state.composableBuilder(
      column: $state.table.level,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$MotivationEntriesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $MotivationEntriesTable> {
  $$MotivationEntriesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get userId => $state.composableBuilder(
      column: $state.table.userId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get level => $state.composableBuilder(
      column: $state.table.level,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SchoolUpdatesTableInsertCompanionBuilder = SchoolUpdatesCompanion
    Function({
  Value<int> id,
  required int authorId,
  required String authorName,
  required String title,
  required String content,
  required String category,
  required bool isPinned,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$SchoolUpdatesTableUpdateCompanionBuilder = SchoolUpdatesCompanion
    Function({
  Value<int> id,
  Value<int> authorId,
  Value<String> authorName,
  Value<String> title,
  Value<String> content,
  Value<String> category,
  Value<bool> isPinned,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$SchoolUpdatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SchoolUpdatesTable,
    SchoolUpdate,
    $$SchoolUpdatesTableFilterComposer,
    $$SchoolUpdatesTableOrderingComposer,
    $$SchoolUpdatesTableProcessedTableManager,
    $$SchoolUpdatesTableInsertCompanionBuilder,
    $$SchoolUpdatesTableUpdateCompanionBuilder> {
  $$SchoolUpdatesTableTableManager(_$AppDatabase db, $SchoolUpdatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SchoolUpdatesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SchoolUpdatesTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$SchoolUpdatesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> authorId = const Value.absent(),
            Value<String> authorName = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<bool> isPinned = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              SchoolUpdatesCompanion(
            id: id,
            authorId: authorId,
            authorName: authorName,
            title: title,
            content: content,
            category: category,
            isPinned: isPinned,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required int authorId,
            required String authorName,
            required String title,
            required String content,
            required String category,
            required bool isPinned,
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              SchoolUpdatesCompanion.insert(
            id: id,
            authorId: authorId,
            authorName: authorName,
            title: title,
            content: content,
            category: category,
            isPinned: isPinned,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$SchoolUpdatesTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $SchoolUpdatesTable,
    SchoolUpdate,
    $$SchoolUpdatesTableFilterComposer,
    $$SchoolUpdatesTableOrderingComposer,
    $$SchoolUpdatesTableProcessedTableManager,
    $$SchoolUpdatesTableInsertCompanionBuilder,
    $$SchoolUpdatesTableUpdateCompanionBuilder> {
  $$SchoolUpdatesTableProcessedTableManager(super.$state);
}

class $$SchoolUpdatesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SchoolUpdatesTable> {
  $$SchoolUpdatesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get authorId => $state.composableBuilder(
      column: $state.table.authorId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get authorName => $state.composableBuilder(
      column: $state.table.authorName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isPinned => $state.composableBuilder(
      column: $state.table.isPinned,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SchoolUpdatesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SchoolUpdatesTable> {
  $$SchoolUpdatesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get authorId => $state.composableBuilder(
      column: $state.table.authorId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get authorName => $state.composableBuilder(
      column: $state.table.authorName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isPinned => $state.composableBuilder(
      column: $state.table.isPinned,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$AppSettingsTableInsertCompanionBuilder = AppSettingsCompanion
    Function({
  Value<int> id,
  required bool hasCompletedOnboarding,
  Value<int?> currentUserId,
  required bool isDarkMode,
});
typedef $$AppSettingsTableUpdateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<int> id,
  Value<bool> hasCompletedOnboarding,
  Value<int?> currentUserId,
  Value<bool> isDarkMode,
});

class $$AppSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableProcessedTableManager,
    $$AppSettingsTableInsertCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder> {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AppSettingsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AppSettingsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$AppSettingsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<bool> hasCompletedOnboarding = const Value.absent(),
            Value<int?> currentUserId = const Value.absent(),
            Value<bool> isDarkMode = const Value.absent(),
          }) =>
              AppSettingsCompanion(
            id: id,
            hasCompletedOnboarding: hasCompletedOnboarding,
            currentUserId: currentUserId,
            isDarkMode: isDarkMode,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required bool hasCompletedOnboarding,
            Value<int?> currentUserId = const Value.absent(),
            required bool isDarkMode,
          }) =>
              AppSettingsCompanion.insert(
            id: id,
            hasCompletedOnboarding: hasCompletedOnboarding,
            currentUserId: currentUserId,
            isDarkMode: isDarkMode,
          ),
        ));
}

class $$AppSettingsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableProcessedTableManager,
    $$AppSettingsTableInsertCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder> {
  $$AppSettingsTableProcessedTableManager(super.$state);
}

class $$AppSettingsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get hasCompletedOnboarding => $state.composableBuilder(
      column: $state.table.hasCompletedOnboarding,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get currentUserId => $state.composableBuilder(
      column: $state.table.currentUserId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isDarkMode => $state.composableBuilder(
      column: $state.table.isDarkMode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AppSettingsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get hasCompletedOnboarding => $state.composableBuilder(
      column: $state.table.hasCompletedOnboarding,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get currentUserId => $state.composableBuilder(
      column: $state.table.currentUserId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isDarkMode => $state.composableBuilder(
      column: $state.table.isDarkMode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$MotivationEntriesTableTableManager get motivationEntries =>
      $$MotivationEntriesTableTableManager(_db, _db.motivationEntries);
  $$SchoolUpdatesTableTableManager get schoolUpdates =>
      $$SchoolUpdatesTableTableManager(_db, _db.schoolUpdates);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
