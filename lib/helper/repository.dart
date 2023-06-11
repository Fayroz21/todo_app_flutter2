

import 'package:sqflite/sqflite.dart';
import 'package:todo_pp/helper/database_connection.dart';

class Repository{
  DatabaseConnection? _databaseConnection;

  Repository(){
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  //get my database
  Future<Database> get database async{
    if(_database != null) return _database!;

    _database = await _databaseConnection!.setDataBase();
    return _database!;
  }

  Future insertData(table, dataModel) async{
    var connection = await database;

    final db =  await connection.insert(table, dataModel, conflictAlgorithm: ConflictAlgorithm.replace);
    print('$db inserted successfully');
    return db;
  }

  Future getData(table) async{
    var connection = await database;
    var result = await connection.query(table);
    return result;
  }
  
  Future deleteData(table, id) async{
    var connection = await database;
    var result = await connection.rawDelete('DELETE FROM $table WHERE id = ?', ['$id']);
    print('Deleted Successfully');
    return result;
  }

  Future updateData(table, dataModel) async{
    var connection = await database;
    var result = await connection.update(table, dataModel, where: 'id = ?', whereArgs: [dataModel['id']]);
    print('Updated Successfully');
    return result;
  }

  //read data from table by column name and value
  readDataByColumnName(table, columnName, columnValue) async{
    var connection = await database;
    var result = await connection.query(table, where: '$columnName = ?', whereArgs: [columnValue]);
    return result;
  }




}