class Student {
  final int? id;
  final String name;
  final int rollNumber;
  final String courseName;
  bool isAbsent;

  Student({
    this.id,
    required this.name,
    required this.rollNumber,
    required this.courseName,
    this.isAbsent = false,
  });

  factory Student.fromCsv(List<dynamic> row) {
    return Student(
      name: row[0],
      rollNumber: int.tryParse(row[1].toString()) ?? 0,
      courseName: row[2],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentName': name,
      'rollNumber': rollNumber,
      'courseName': courseName,
      'isAbsent': isAbsent ? 1 : 0,
    };
  }

  factory Student.fromMap(Map<String, Object?> map) {
    final id = map['id'] as int?;
    final name = map['studentName'] as String;
    final rollNo = map['rollNumber'] is int
        ? map['rollNumber'] as int
        : int.tryParse(map['rollNumber'].toString()) ?? 0;
    final courseName = map['courseName'] as String;
    final isAbsent = (map['isAbsent'] as int) == 1;

    return Student(
      id: id,
      name: name,
      rollNumber: rollNo,
      courseName: courseName,
      isAbsent: isAbsent,
    );
  }

  factory Student.fromAbsenceMap(Map<String, Object?> map) {
    final id = map['id'] as int?;
    final name = map['studentName'] as String;
    final rollNo = map['rollNumber'] as int;
    final courseName = map['courseName'] as String;

    return Student(
      id: id,
      name: name,
      rollNumber: rollNo,
      courseName: courseName,
      isAbsent: true,
    );
  }
}
