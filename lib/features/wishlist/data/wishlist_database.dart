import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'wishlist_database.g.dart';

class WishlistItems extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get author => text()();
  TextColumn get description => text()();
  TextColumn get coverUrl => text()();
  TextColumn get genre => text()();
  RealColumn get price => real()();
  RealColumn get rating => real()();
  TextColumn get ageCategory => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [WishlistItems])
class WishlistDatabase extends _$WishlistDatabase {
  WishlistDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<WishlistItem>> watchAllItems() => select(wishlistItems).watch();

  Future<bool> isWishlisted(String id) async {
    final item = await (select(wishlistItems)..where((t) => t.id.equals(id))).getSingleOrNull();
    return item != null;
  }

  Future<void> addItem(WishlistItemsCompanion item) =>
      into(wishlistItems).insertOnConflictUpdate(item);

  Future<void> removeItem(String id) =>
      (delete(wishlistItems)..where((t) => t.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'wishlist.db'));
    return NativeDatabase.createInBackground(file);
  });
}