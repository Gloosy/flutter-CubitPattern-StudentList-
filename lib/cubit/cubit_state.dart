part of 'cubit_cubit.dart';

@immutable
abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentLoaded extends StudentState {
  List<StudentListModel>? students;

  StudentLoaded({this.students});
}

class StudentError extends StudentState {
  final String errors;
  StudentError(this.errors);
}
