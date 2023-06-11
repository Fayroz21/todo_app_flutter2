import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_pp/constants/constants.dart';

class DatabaseConnection {

  setDataBase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, Consts.dbName);
    var database = await openDatabase(path,
        version: 1, onCreate: _onCreatingDataBase, onOpen: (db) {
      print('DataBase Opened');
    });

    return database;
  }

  _onCreatingDataBase(Database database, int version) async {
    print('DB is created');
    await database.execute(
        "CREATE TABLE ${Consts.tbCategory} (id INTEGER PRIMARY KEY, ${Consts.colCatName} TEXT, ${Consts.colCatDesc} TEXT)");
    print('Table was Created');

    //create table to do
    await database.execute("CREATE TABLE ${Consts.tbToDo} (${Consts.colID} INTEGER PRIMARY KEY, ${Consts.colDoTitle} TEXT, ${Consts.colDoDesc} TEXT, ${Consts.colDoCat} TEXT, ${Consts.colDoDate} TEXT, ${Consts.colDoFinish} INTEGER)");
  }
}
