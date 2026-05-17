// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_database.dart';

// ignore_for_file: type=lint
class $WishlistItemsTable extends WishlistItems
    with TableInfo<$WishlistItemsTable, WishlistItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WishlistItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _coverUrlMeta =
      const VerificationMeta('coverUrl');
  @override
  late final GeneratedColumn<String> coverUrl = GeneratedColumn<String>(
      'cover_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
      'genre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
      'rating', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _ageCategoryMeta =
      const VerificationMeta('ageCategory');
  @override
  late final GeneratedColumn<String> ageCategory = GeneratedColumn<String>(
      'age_category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        author,
        description,
        coverUrl,
        genre,
        price,
        rating,
        ageCategory
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wishlist_items';
  @override
  VerificationContext validateIntegrity(Insertable<WishlistItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('cover_url')) {
      context.handle(_coverUrlMeta,
          coverUrl.isAcceptableOrUnknown(data['cover_url']!, _coverUrlMeta));
    } else if (isInserting) {
      context.missing(_coverUrlMeta);
    }
    if (data.containsKey('genre')) {
      context.handle(
          _genreMeta, genre.isAcceptableOrUnknown(data['genre']!, _genreMeta));
    } else if (isInserting) {
      context.missing(_genreMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('age_category')) {
      context.handle(
          _ageCategoryMeta,
          ageCategory.isAcceptableOrUnknown(
              data['age_category']!, _ageCategoryMeta));
    } else if (isInserting) {
      context.missing(_ageCategoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WishlistItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WishlistItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      coverUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover_url'])!,
      genre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genre'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rating'])!,
      ageCategory: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}age_category'])!,
    );
  }

  @override
  $WishlistItemsTable createAlias(String alias) {
    return $WishlistItemsTable(attachedDatabase, alias);
  }
}

class WishlistItem extends DataClass implements Insertable<WishlistItem> {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverUrl;
  final String genre;
  final double price;
  final double rating;
  final String ageCategory;
  const WishlistItem(
      {required this.id,
      required this.title,
      required this.author,
      required this.description,
      required this.coverUrl,
      required this.genre,
      required this.price,
      required this.rating,
      required this.ageCategory});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['author'] = Variable<String>(author);
    map['description'] = Variable<String>(description);
    map['cover_url'] = Variable<String>(coverUrl);
    map['genre'] = Variable<String>(genre);
    map['price'] = Variable<double>(price);
    map['rating'] = Variable<double>(rating);
    map['age_category'] = Variable<String>(ageCategory);
    return map;
  }

  WishlistItemsCompanion toCompanion(bool nullToAbsent) {
    return WishlistItemsCompanion(
      id: Value(id),
      title: Value(title),
      author: Value(author),
      description: Value(description),
      coverUrl: Value(coverUrl),
      genre: Value(genre),
      price: Value(price),
      rating: Value(rating),
      ageCategory: Value(ageCategory),
    );
  }

  factory WishlistItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WishlistItem(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String>(json['author']),
      description: serializer.fromJson<String>(json['description']),
      coverUrl: serializer.fromJson<String>(json['coverUrl']),
      genre: serializer.fromJson<String>(json['genre']),
      price: serializer.fromJson<double>(json['price']),
      rating: serializer.fromJson<double>(json['rating']),
      ageCategory: serializer.fromJson<String>(json['ageCategory']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String>(author),
      'description': serializer.toJson<String>(description),
      'coverUrl': serializer.toJson<String>(coverUrl),
      'genre': serializer.toJson<String>(genre),
      'price': serializer.toJson<double>(price),
      'rating': serializer.toJson<double>(rating),
      'ageCategory': serializer.toJson<String>(ageCategory),
    };
  }

  WishlistItem copyWith(
          {String? id,
          String? title,
          String? author,
          String? description,
          String? coverUrl,
          String? genre,
          double? price,
          double? rating,
          String? ageCategory}) =>
      WishlistItem(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        description: description ?? this.description,
        coverUrl: coverUrl ?? this.coverUrl,
        genre: genre ?? this.genre,
        price: price ?? this.price,
        rating: rating ?? this.rating,
        ageCategory: ageCategory ?? this.ageCategory,
      );
  WishlistItem copyWithCompanion(WishlistItemsCompanion data) {
    return WishlistItem(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      description:
          data.description.present ? data.description.value : this.description,
      coverUrl: data.coverUrl.present ? data.coverUrl.value : this.coverUrl,
      genre: data.genre.present ? data.genre.value : this.genre,
      price: data.price.present ? data.price.value : this.price,
      rating: data.rating.present ? data.rating.value : this.rating,
      ageCategory:
          data.ageCategory.present ? data.ageCategory.value : this.ageCategory,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WishlistItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('genre: $genre, ')
          ..write('price: $price, ')
          ..write('rating: $rating, ')
          ..write('ageCategory: $ageCategory')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, author, description, coverUrl,
      genre, price, rating, ageCategory);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WishlistItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.author == this.author &&
          other.description == this.description &&
          other.coverUrl == this.coverUrl &&
          other.genre == this.genre &&
          other.price == this.price &&
          other.rating == this.rating &&
          other.ageCategory == this.ageCategory);
}

class WishlistItemsCompanion extends UpdateCompanion<WishlistItem> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> author;
  final Value<String> description;
  final Value<String> coverUrl;
  final Value<String> genre;
  final Value<double> price;
  final Value<double> rating;
  final Value<String> ageCategory;
  final Value<int> rowid;
  const WishlistItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.genre = const Value.absent(),
    this.price = const Value.absent(),
    this.rating = const Value.absent(),
    this.ageCategory = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WishlistItemsCompanion.insert({
    required String id,
    required String title,
    required String author,
    required String description,
    required String coverUrl,
    required String genre,
    required double price,
    required double rating,
    required String ageCategory,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        author = Value(author),
        description = Value(description),
        coverUrl = Value(coverUrl),
        genre = Value(genre),
        price = Value(price),
        rating = Value(rating),
        ageCategory = Value(ageCategory);
  static Insertable<WishlistItem> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? description,
    Expression<String>? coverUrl,
    Expression<String>? genre,
    Expression<double>? price,
    Expression<double>? rating,
    Expression<String>? ageCategory,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (description != null) 'description': description,
      if (coverUrl != null) 'cover_url': coverUrl,
      if (genre != null) 'genre': genre,
      if (price != null) 'price': price,
      if (rating != null) 'rating': rating,
      if (ageCategory != null) 'age_category': ageCategory,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WishlistItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? author,
      Value<String>? description,
      Value<String>? coverUrl,
      Value<String>? genre,
      Value<double>? price,
      Value<double>? rating,
      Value<String>? ageCategory,
      Value<int>? rowid}) {
    return WishlistItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      coverUrl: coverUrl ?? this.coverUrl,
      genre: genre ?? this.genre,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      ageCategory: ageCategory ?? this.ageCategory,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (coverUrl.present) {
      map['cover_url'] = Variable<String>(coverUrl.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (ageCategory.present) {
      map['age_category'] = Variable<String>(ageCategory.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WishlistItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('genre: $genre, ')
          ..write('price: $price, ')
          ..write('rating: $rating, ')
          ..write('ageCategory: $ageCategory, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$WishlistDatabase extends GeneratedDatabase {
  _$WishlistDatabase(QueryExecutor e) : super(e);
  $WishlistDatabaseManager get managers => $WishlistDatabaseManager(this);
  late final $WishlistItemsTable wishlistItems = $WishlistItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [wishlistItems];
}

typedef $$WishlistItemsTableCreateCompanionBuilder = WishlistItemsCompanion
    Function({
  required String id,
  required String title,
  required String author,
  required String description,
  required String coverUrl,
  required String genre,
  required double price,
  required double rating,
  required String ageCategory,
  Value<int> rowid,
});
typedef $$WishlistItemsTableUpdateCompanionBuilder = WishlistItemsCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String> author,
  Value<String> description,
  Value<String> coverUrl,
  Value<String> genre,
  Value<double> price,
  Value<double> rating,
  Value<String> ageCategory,
  Value<int> rowid,
});

class $$WishlistItemsTableFilterComposer
    extends Composer<_$WishlistDatabase, $WishlistItemsTable> {
  $$WishlistItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get coverUrl => $composableBuilder(
      column: $table.coverUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get genre => $composableBuilder(
      column: $table.genre, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ageCategory => $composableBuilder(
      column: $table.ageCategory, builder: (column) => ColumnFilters(column));
}

class $$WishlistItemsTableOrderingComposer
    extends Composer<_$WishlistDatabase, $WishlistItemsTable> {
  $$WishlistItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coverUrl => $composableBuilder(
      column: $table.coverUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get genre => $composableBuilder(
      column: $table.genre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ageCategory => $composableBuilder(
      column: $table.ageCategory, builder: (column) => ColumnOrderings(column));
}

class $$WishlistItemsTableAnnotationComposer
    extends Composer<_$WishlistDatabase, $WishlistItemsTable> {
  $$WishlistItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get coverUrl =>
      $composableBuilder(column: $table.coverUrl, builder: (column) => column);

  GeneratedColumn<String> get genre =>
      $composableBuilder(column: $table.genre, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get ageCategory => $composableBuilder(
      column: $table.ageCategory, builder: (column) => column);
}

class $$WishlistItemsTableTableManager extends RootTableManager<
    _$WishlistDatabase,
    $WishlistItemsTable,
    WishlistItem,
    $$WishlistItemsTableFilterComposer,
    $$WishlistItemsTableOrderingComposer,
    $$WishlistItemsTableAnnotationComposer,
    $$WishlistItemsTableCreateCompanionBuilder,
    $$WishlistItemsTableUpdateCompanionBuilder,
    (
      WishlistItem,
      BaseReferences<_$WishlistDatabase, $WishlistItemsTable, WishlistItem>
    ),
    WishlistItem,
    PrefetchHooks Function()> {
  $$WishlistItemsTableTableManager(
      _$WishlistDatabase db, $WishlistItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WishlistItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WishlistItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WishlistItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> author = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> coverUrl = const Value.absent(),
            Value<String> genre = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<double> rating = const Value.absent(),
            Value<String> ageCategory = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WishlistItemsCompanion(
            id: id,
            title: title,
            author: author,
            description: description,
            coverUrl: coverUrl,
            genre: genre,
            price: price,
            rating: rating,
            ageCategory: ageCategory,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String author,
            required String description,
            required String coverUrl,
            required String genre,
            required double price,
            required double rating,
            required String ageCategory,
            Value<int> rowid = const Value.absent(),
          }) =>
              WishlistItemsCompanion.insert(
            id: id,
            title: title,
            author: author,
            description: description,
            coverUrl: coverUrl,
            genre: genre,
            price: price,
            rating: rating,
            ageCategory: ageCategory,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WishlistItemsTableProcessedTableManager = ProcessedTableManager<
    _$WishlistDatabase,
    $WishlistItemsTable,
    WishlistItem,
    $$WishlistItemsTableFilterComposer,
    $$WishlistItemsTableOrderingComposer,
    $$WishlistItemsTableAnnotationComposer,
    $$WishlistItemsTableCreateCompanionBuilder,
    $$WishlistItemsTableUpdateCompanionBuilder,
    (
      WishlistItem,
      BaseReferences<_$WishlistDatabase, $WishlistItemsTable, WishlistItem>
    ),
    WishlistItem,
    PrefetchHooks Function()>;

class $WishlistDatabaseManager {
  final _$WishlistDatabase _db;
  $WishlistDatabaseManager(this._db);
  $$WishlistItemsTableTableManager get wishlistItems =>
      $$WishlistItemsTableTableManager(_db, _db.wishlistItems);
}
