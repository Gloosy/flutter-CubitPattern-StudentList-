part of 'cubit_cubit.dart';

@immutable
abstract class StudentState {}

// initial state
class StudentInitial extends StudentState {}

// initial state
class StudentLoading extends StudentState {}

// loaded state
class StudentLoaded extends StudentState {
  StudentListModel? students;
  StudentLoaded({this.students});
}

// error state
class StudentError extends StudentState {
  final String errors;
  StudentError(this.errors);
}
