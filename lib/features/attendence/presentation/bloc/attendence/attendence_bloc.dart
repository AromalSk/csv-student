import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:excel_converter/features/attendence/data/datasource/sqflite_datasource.dart';
import 'package:excel_converter/features/attendence/domain/model/student_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'attendence_event.dart';
part 'attendence_state.dart';

class AttendenceBloc extends Bloc<AttendenceEvent, AttendenceState> {
  AttendenceBloc() : super(AttendenceInitial()) {
    on<LoadCsv>((event, emit) async {
      emit(AttendenceLoading());
      try {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['csv'],
        );

        if (result != null && result.files.isNotEmpty) {
          String? filePath = result.files.single.path;

          if (filePath != null) {
            final input = File(filePath).openRead();
            final fields = await input
                .transform(utf8.decoder)
                .transform(const CsvToListConverter())
                .toList();

            print('CSV Fields: $fields');

            List<Student> students = [];

            for (var row in fields) {
              if (row.isNotEmpty) {
                Student student = Student.fromCsv(row);
                await addStudent(student);

                print('Adding student: $student');

                students = await getAllStudents();
              }
            }
            emit(AttendenceSuccess(students));
          } else {
            emit(AttendenceFailure('File path is null'));
          }
        } else {
          emit(AttendenceFailure('No file selected'));
        }
      } catch (e) {
        emit(AttendenceFailure(e.toString()));
      }
    });
  }
}
