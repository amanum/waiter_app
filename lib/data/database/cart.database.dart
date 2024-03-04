import 'package:sqflite/sqflite.dart';
import 'package:waiter_app/data/entity/cart.entity.dart';
import 'package:path/path.dart';

const _tableName = 'Carts';

class CartDatabase {
  Future<Database> _getDb() async {
    return openDatabase(
      join(await getDatabasesPath(), 'cart.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE $_tableName (key TEXT PRIMARY KEY, table_id INTEGER, items TEXT)',
        );
      },
    );
  }

  Future<void> writeCart(Cart cart) async {
    final db = await _getDb();
    final json = cart.toJson();
    await db.transaction((txn) async {
      await txn.insert(
        _tableName,
        json,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<Cart?> getCart({int? tableId}) async {
    final db = await _getDb();
    final maps = await db.query(
      _tableName,
      where: tableId != null ? 'table_id = ?' : null,
      whereArgs: tableId != null ? [tableId] : null,
    );
    if (maps.isNotEmpty) {
      return Cart.fromJson(maps.first);
    }
    return null;
  }
}
