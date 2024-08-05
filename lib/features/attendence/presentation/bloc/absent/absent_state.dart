part of 'absent_bloc.dart';

@immutable
sealed class AbsentState {}

final class AbsentInitial extends AbsentState {}

final class AbsentLoading extends AbsentState {}

final class AbsentSuccess extends AbsentState {
  List<Student> absentStudents;

  AbsentSuccess(this.absentStudents);
}

final class AbsentFailure extends AbsentState {
  final String error;

  AbsentFailure(this.error);
}
