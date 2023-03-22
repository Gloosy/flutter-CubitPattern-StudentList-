import 'package:path/path.dart';
import 'package:rive_animation/data/model/studentmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
class DataBaseHelper{


  static const String _databaseName    = 'studentinfodb.db';
  static const int _databaseVersion    = 1;
  static const String tableName        = 'student_tb';

  static const String columnId         = 'id';
  static const String columnName       = 'Hello';
  static const String columnFatherName = 'Hlii';
  static const String columnMotherName = 'Hlee';
  static const String columnDOB        = '0-0-0';
  static const String columnExamDate   = '0-0-2';

  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  Future<Database?> get database async{
    return await _initDatabase();
  }

  _initDatabase() async{
      String path = join(await getDatabasesPath(), _databaseName);
      return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async{
    return await db.execute('''
        CREATE TABLE $tableName(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnName TEXT NOT NULL,
          $columnFatherName TEXT NOT NULL, 
          $columnMotherName TEXT NOT NULL,
          $columnDOB TEXT NOT NULL, 
          $columnExamDate TEXT NOT NULL,
        )
        ''');
  }
  
  Future<int> insert(StudentData studentInfo) async{

    Database? db = await instance!.database;
    return await db!.insert(tableName, {
      'name'       : studentInfo.name,
      'fatherName' : studentInfo.fatherName,
      'motherName' : studentInfo.motherName
    });
  }
  
  Future<List<Map<String, dynamic>>?> queryAllRows() async{
    Database? db = await instance!.database;
    return await db?.query(tableName);
  }
}