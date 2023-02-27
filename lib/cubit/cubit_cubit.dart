import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rive_animation/data/model/studentmodel.dart';
import 'package:rive_animation/data/repository/getrepository.dart';

part 'cubit_state.dart';

class StudentCubit extends Cubit<StudentState> {
  final ApiRepository apiRepository;
  StudentCubit({required this.apiRepository}) : super(StudentInitial());

  void fetchStudent() {
    emit(StudentLoading());

    
    apiRepository.getPostList().then((value) {
      final List<StudentListModel> studentList =
        (value as List).map((e) => StudentListModel.fromJson(e)).toList();
      final studentMap = studentList.map((student) => student.toJson()).toList();
      print("Data Student in Cubit : ${studentMap}");
      emit(StudentLoaded(students: studentList ?? []));
    }).catchError((error) {
      emit(StudentError(error.toString()));
    });
  }
}
