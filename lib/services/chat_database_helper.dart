import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/chat_modek.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> _getDatabase() async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'chat_database.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE messages(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId TEXT,
            text TEXT,
            createdAt TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  // Insert a message into the database
  Future<void> insertMessage(ChatMessageModel message) async {
    final db = await _getDatabase();
    await db.insert('messages', message.toMap());
  }

  // Retrieve all messages from the database in reverse order
  Future<List<ChatMessageModel>> getMessages() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'messages',
      orderBy: 'createdAt DESC', // Order by createdAt in descending order
    );

    return List.generate(maps.length, (i) {
      return ChatMessageModel.fromMap(maps[i]);
    });
  }

  // Clear all messages from the database
  Future<void> clearMessages() async {
    final db = await _getDatabase();
    await db.delete('messages');
  }

  // Delete a specific message by createdAt timestamp
  Future<void> deleteMessage(String createdAt) async {
    final db = await _getDatabase();
    await db.delete(
      'messages',
      where: 'createdAt = ?',
      whereArgs: [createdAt],
    );
  }
}
