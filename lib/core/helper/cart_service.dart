import 'package:event_app/features/cart/domain/entity/cart_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../features/cart/data/model/cart_item_model.dart';

class CartService {
  static final CartService _instance = CartService._internal();

  factory CartService() => _instance;

  CartService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("cart.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            event_id TEXT,
            ticket_id TEXT,
            name TEXT,
            ticket_name TEXT,
            price INTEGER,
            quantity INTEGER
          )
        ''');
      },
    );
  }

  /// Tambahkan item ke cart, update qty kalau ticket_id sudah ada
  Future<int> addToCart(CartItem item) async {
    final db = await database;

    // cek apakah sudah ada item dengan ticket_id ini
    final existing = await db.query('cart', where: 'ticket_id = ?', whereArgs: [item.idTicket]);

    if (existing.isNotEmpty) {
      // update qty
      final currentQty = existing.first['quantity'] as int;
      return await db.update(
        'cart',
        {'quantity': currentQty + item.quantity},
        where: 'ticket_id = ?',
        whereArgs: [item.idTicket],
      );
    } else {
      // insert baru
      return await db.insert('cart', {
        'event_id': item.idEvent,
        'ticket_id': item.idTicket,
        'name': item.name,
        'ticket_name': item.ticketName,
        'price': item.price,
        'quantity': item.quantity,
      });
    }
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final listCart = await db.query('cart');

    print('list cart: $listCart');

    return listCart.map((cart) => CartItemModel.fromJson(cart)).toList();
  }

  Future<int> removeFromCart(String ticketId) async {
    final db = await database;
    return db.delete('cart', where: 'ticket_id = ?', whereArgs: [ticketId]);
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }

  Future close() async => _database?.close();
}
