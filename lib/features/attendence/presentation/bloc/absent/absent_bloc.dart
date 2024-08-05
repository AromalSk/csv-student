import 'package:excel_converter/features/attendence/data/datasource/sqflite_datasource.dart';
import 'package:excel_converter/features/attendence/domain/model/student_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'absent_event.dart';
part 'absent_state.dart';

class AbsentBloc extends Bloc<AbsentEvent, AbsentState> {
  AbsentBloc() : super(AbsentInitial()) {
    on<AbsentStudents>((event, emit) async {
      emit(AbsentLoading());
      try {
        List<Student> absentStudents = [];
        absentStudents = await getAbsentStudents();
        emit(AbsentSuccess(absentStudents));
      } catch (e) {
        emit(AbsentFailure(e.toString()));
      }
    });
  }
}
