part of 'attendence_bloc.dart';

@immutable
sealed class AttendenceEvent {}

final class LoadCsv extends AttendenceEvent {}
