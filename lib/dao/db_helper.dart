import 'dart:async';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.getInstance();
  DatabaseHelper.getInstance();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();

    return _db;
  }

  Future _initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'carros.db');
    print("db $path");


    var db = await openDatabase(path, version: 10, onCreate: _onCreate, onUpgrade: _onUpgrade);
     return db;
  }

  void _onCreate(Database db, int newVersion) async {

     String sqlFile = await rootBundle.loadString('assets/sql/create.sql'); // se houver + de 1 .. damos split por ex: ;
     List<String> sqls = sqlFile.split(';');

     for(String sql in sqls){
       if(sql.trim().isNotEmpty)
         print ('query ? $sql');
         await db.execute(sql);
     }
    //  await db.execute(
    //      'CREATE TABLE carro(id INTEGER PRIMARY KEY, tipo TEXT, nome TEXT'
    //      ', descricao TEXT, urlFoto TEXT, urlVideo TEXT, latitude TEXT, longitude TEXT)');
  }

  Future<FutureOr<void>> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("_onUpgrade: oldVersion: $oldVersion > newVersion: $newVersion");

    // String sqlFile = await rootBundle.loadString('assets/sql/create.sql'); // se houver + de 1 .. damos split por ex: ;
    //  List<String> sqls = sqlFile.split(';');

    //  for(String sql in sqls){
    //    if(sql.trim().isNotEmpty)
    //      print ('query ? $sql');
    //      await db.execute(sql);
    //  }

    // if(oldVersion == 1 && newVersion == 2) {
    //   await db.execute("alter table carro add column NOVA TEXT");
    // }
    //   print('drop ');
    // await db.execute('DROP TABLE Carro');
    // await db.execute('DROP TABLE favorito');
    // print('drop ok');

  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
