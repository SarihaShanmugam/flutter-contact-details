import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static const _databaseName = "ContactDetailsDB.db";
  static const _databaseVersion = 1;


  static const contactDetailsTable = '_contactDetailsTable';


  static const colId = '_id';

  static const colContactName = '_contactName';
  static const colMobNo = '_mobileNo';
  static const colEmailId = '_emailId';
  static const colDOB = '_dob';
  static const colTime = '_time';

  late Database _db;

  Future<void> initialization() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database database, int version) async {

    await database.execute('''
          CREATE TABLE $contactDetailsTable (
            $colId INTEGER PRIMARY KEY,
            $colContactName TEXT,
            $colMobNo TEXT,
            $colEmailId TEXT,
            $colDOB TEXT,
            $colTime TEXT
          )
          ''');
  }

  _onUpgrade(Database database, int oldVersion, int newVersion) async{
    await database.execute('drop table $contactDetailsTable');
    _onCreate(database, newVersion);
  }

  Future<int> insertContactDetails(Map<String, dynamic> row) async {
    return await _db.insert(contactDetailsTable, row);
  }

  Future<List<Map<String, dynamic>>> getAllContactDetails() async {

    return await _db.query(contactDetailsTable);
  }

  Future<int> updateContactDetails(Map<String, dynamic> row) async {
    int id = row[colId];
    return await _db.update(
      contactDetailsTable,
      row,
      where: '$colId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteContactDetails(int id) async {
    return await _db.delete(
      contactDetailsTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
  }
}