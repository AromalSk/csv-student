import 'package:excel_converter/features/attendence/domain/model/student_model.dart';
import 'package:sqflite/sqflite.dart';

late Database _db;

List<Student> studentsList = [];

Future<void> initializeDatabase() async {
  _db = await openDatabase(
    'student.db',
    version: 1,
    onConfigure: (db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    },
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE students (id INTEGER PRIMARY KEY, studentName TEXT, rollNumber INTEGER, courseName TEXT, isAbsent INTEGER)');
      await db.execute(
          'CREATE TABLE absence (id INTEGER PRIMARY KEY, dateTime TEXT, studentId INTEGER, FOREIGN KEY(studentId) REFERENCES students(id))');
    },
  );
}

Future<List<Student>> getAllStudents() async {
  final _value = await _db.rawQuery('SELECT * FROM students');

  studentsList.clear();

  _value.forEach(
    (element) {
      final studentdata = Student.fromMap(element);
      studentsList.add(studentdata);
    },
  );

  return studentsList;
}

Future<void> addStudent(Student value) async {
  await _db.rawInsert(
      'INSERT INTO students (studentName,rollNumber,courseName,isAbsent) VALUES (?,?,?,?)',
      [value.name, value.rollNumber, value.courseName, value.isAbsent]);
  getAllStudents();
}

Future<void> clearDatabase() async {
  await _db.delete('absence');
  await _db.delete('students');
  print('Database cleared');
}

Future<void> markAbsentInDatabase(int studentId) async {
  String dateTime = DateTime.now().toIso8601String();
  await _db.rawInsert('INSERT INTO absence (dateTime, studentId) VALUES (?,?)',
      [dateTime, studentId]);
}

Future<List<Student>> getAbsentStudents() async {
  final List<Map<String, dynamic>> results = await _db.rawQuery('''
    SELECT s.id, s.studentName, s.rollNumber, s.courseName, a.dateTime
    FROM students s
    INNER JOIN absence a ON s.id = a.studentId
  ''');
  List<Student> absentStudentsList = [];

  absentStudentsList = results.map((map) {
    return Student.fromAbsenceMap(map);
  }).toList();

  return absentStudentsList;
}

void printAbsentStudentsList() async {
  List<Student> absentStudents = await getAbsentStudents();
  for (var student in absentStudents) {
    print(
        'ID: ${student.id}, Name: ${student.name}, Roll Number: ${student.rollNumber}, Course: ${student.courseName}, Absent: ${student.isAbsent}');
  }
}

Future<void> removeAbsentFromDatabase(int studentId) async {
  await _db.delete(
    'absence',
    where: 'studentId = ?',
    whereArgs: [studentId],
  );
}
