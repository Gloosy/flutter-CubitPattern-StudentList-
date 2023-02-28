import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rive_animation/data/model/studentmodel.dart';
import 'package:rive_animation/data/repository/getrepository.dart';

part 'cubit_state.dart';

class StudentCubit extends Cubit<StudentListModel> {
  final ApiRepository apiRepository;
  StudentCubit({required this.apiRepository}) : super(StudentListModel());

  void fetchStudent() async {
    var data = await apiRepository.getPostList();
    emit(data);
  }
}
