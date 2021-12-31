import 'package:flutter/cupertino.dart';
import 'package:gstock/DB/order.dart';
import 'package:gstock/addcom.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'components.dart';
import 'componentsType.dart';
import 'user.dart';

class userDatabase {
  static final instance = userDatabase._init();

  static Database? _database;

  userDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('test13.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filePath);
    return (openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
    ));
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT';
    final intType = 'INTEGER';

    await db.execute('''CREATE TABLE $tableUsers ( 
      ${Userfiled.id} $idType,
      ${Userfiled.username} $textType,
      ${Userfiled.password} $textType,
      ${Userfiled.phone} $textType,
      ${Userfiled.phone2} $textType,
      ${Userfiled.firstName} $textType,
      ${Userfiled.lastName} $textType

    )''');
    await db.execute('''
       create table $componentsTypeTable (
        ${componentsTypeField.id} $idType,
        ${componentsTypeField.type} $textType
       )''');

    await db.execute('''CREATE TABLE $componentsTable (
              ${componentsField.id} $idType ,
              ${componentsField.id_com} $intType,
              ${componentsField.name} $textType,
              ${componentsField.date} $textType,
              ${componentsField.quntity} $textType,
              FOREIGN KEY (id_com) REFERENCES componentsType (id)
                ON DELETE NO ACTION ON UPDATE NO ACTION)''');
    await db.execute('''CREATE TABLE $orderTable (
              ${orderField.id} $idType,
              ${orderField.idU} $intType,
              ${orderField.idC} $intType,
              ${orderField.dateR} $textType,
              ${orderField.quntity} $textType,
              FOREIGN KEY (${orderField.idU}) REFERENCES $tableUsers(id)
                ON DELETE NO ACTION ON UPDATE NO ACTION,
              FOREIGN KEY (${orderField.idC}) REFERENCES $componentsTable(id)
                ON DELETE NO ACTION ON UPDATE NO ACTION)''');
  }

  Future<User> getbyUsername(String Username, String pass) async {
    final db = await instance.database;
    final maps = await db.query(tableUsers,
        columns: Userfiled.values,
        where: '  ${Userfiled.username} = ? and ${Userfiled.password} = ?',
        whereArgs: [Username, pass]);
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('user : $Username not found');
    }
  }

  Future<bool> authontif(String Username, String pass) async {
    final db = await instance.database;
    final maps = await db.query(tableUsers,
        columns: Userfiled.values,
        where: '  ${Userfiled.username} = ? and ${Userfiled.password} = ?',
        whereArgs: [Username, pass]);
    if (maps.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<passlogininfo> getauthin(String Username, String pass) async {
    final db = await instance.database;
    final maps = await db.query(tableUsers,
        columns: Userfiled.values,
        where: '  ${Userfiled.username} = ? and ${Userfiled.password} = ?',
        whereArgs: [Username, pass]);

    if (maps.isNotEmpty) {
      User ur = User.fromJson(maps.first);

      return passlogininfo(ur.id);
    }
    throw Exception('user : $Username not found');
  }

  Future<components> getcompbyid(int? id) async {
    final db = await instance.database;
    final maps = await db.query(componentsTable,
        columns: componentsField.values,
        where: '  ${componentsField.id} = ? ',
        whereArgs: [
          id,
        ]);

    if (maps.isNotEmpty) {
      components ur = components.fromJsonct(maps.first);

      return ur;
    }
    throw Exception('user :  not found');
  }

  Future Close() async {
    final db = await instance.database;
    db.close();
  }

  Future<User> create(User User) async {
    final db = await instance.database;

    final id = await db.insert(tableUsers, User.toJson());
    return User.copy(id: id);
  }

  Future<componentsType> createComponentsType(componentsType ct) async {
    final db = await instance.database;
    final id = await db.insert(componentsTypeTable, ct.toJsonct());
    return ct.copyct(id: id);
  }

  Future<components> createComponents(components c) async {
    final db = await instance.database;
    final id = await db.rawInsert(
        'INSERT INTO ${componentsTable} (${componentsField.id_com}, ${componentsField.name}, ${componentsField.date}, ${componentsField.quntity}) VALUES(?, ?, ?, ?)',
        [c.id_com, c.name, c.date, c.quntity]);
    return c.copyc(id: id);
  }

  Future<order> createOrder(order o) async {
    final db = await instance.database;
    final id = await db.insert(orderTable, o.toJson());
    return o.copy(id: id);
  }

  Future<List> getTrashlist() async {
    final db = await instance.database;
    final result = await db.rawQuery(
        '''SELECT ${componentsTypeField.type},${componentsTypeField.id}
      FROM ${componentsTypeTable}
      ''');
    return result;
  }

  Future<List> getAllComponents() async {
    final db = await instance.database;
    final result = await db.rawQuery('''SELECT * FROM ${componentsTable}''');
    return result;
  }

  Future<order> addorder(order order) async {
    final db = await instance.database;

    final id = await db.insert(orderTable, order.toJson());
    return order.copy(id: id);
  }

  Future<int> updatecomp(components comp) async {
    final db = await instance.database;
    return db.update(componentsTable, comp.toJsonc(),
        where: '${componentsField.id} = ?', whereArgs: [comp.id]);
  }
  Future<List> getOwnOrder(int? id) async {
    final db = await instance.database;
    final result = await db.rawQuery('''SELECT * FROM ${componentsTypeField.id} Where _id = (SELECT ${orderField.idC} FROM ${orderTable} where ${orderField.idU} = ${id})''');
    return result;
  }
  Future<int> deleteOrder(int id) async {
    final db = await instance.database;
    return await db.delete(orderTable, where: '_id = ?', whereArgs: [id]);
  }

}

class typeandidcomp {
  int id;
  String type;
  typeandidcomp(this.id, this.type);
}

class userncomp {
  int idU;
  int idC;
  userncomp(this.idU, this.idC);
}

class passlogininfo {
  final int? id;

  passlogininfo(this.id);
}

class orderinfo {
  final int? id_user;
  final int? id_prod;
  orderinfo(this.id_user, this.id_prod);
}
