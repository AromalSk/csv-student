part of 'attendence_bloc.dart';

@immutable
sealed class AttendenceState {}

final class AttendenceInitial extends AttendenceState {}

final class AttendenceLoading extends AttendenceState {}

class AttendenceSuccess extends AttendenceState {
  final List<Student> students;

  AttendenceSuccess(this.students);
}

class AttendenceFailure extends AttendenceState {
  final String error;

  AttendenceFailure(this.error);
}
