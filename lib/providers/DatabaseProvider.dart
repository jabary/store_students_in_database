import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/student.dart';



class DatabaseProvider extends ChangeNotifier{

  DatabaseProvider._privateConstructor();

  static final DatabaseProvider instance = DatabaseProvider._privateConstructor();
  static Database? _database;
  static const int version = 2;

  Future<Database> get database async{
    if (_database != null){
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }


  Future<Database> initDB() async{
    String path = join(await getDatabasesPath(), 'uniDB.db');
    return openDatabase(
      path,
      version: version,
      onCreate: (Database db, int version) async{
        await db.execute(
          '''
          CREATE TABLE student (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          major TEXT,
          avg REAL
          )
          '''
        );
      },
      onUpgrade: (Database db, int oldversion, int newversion){

      }
    );
  }

  add(Student student) async{
    final db = await database;
    // db.rawInsert("INSERT INTO student (name, major, avg) VALUES('ahmed', 'IT', 90)");
    db.insert('student', student.toMap());
    notifyListeners();
  }

  delete(int id) async {
    final db = await database;

    db.delete('student', where: 'id=?', whereArgs: [id]);
    // DELETE FROM student WHERE id=id
    notifyListeners();
  }

  Future<List<Student>> getAllStudents() async {
    final db = await database;
    List<Map<String, dynamic>> records = await db.query('student');

    List<Student> students = [];
    for(var record in records){
      Student student = Student.fromMap(record);
      students.add(student);
    }

    return students;
  }
}