import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive_animation/data/model/updatemodel.dart';
import 'package:rive_animation/data/repository/getrepository.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateInfo> {
  final ApiRepository apiRepository;

  UpdateCubit({required this.apiRepository}) : super(UpdateInfo());

  UpdateInfo? updateInfo;

  // create method handle userInput
  void onChangedValue(String name, String fatherName, String motherName,
      String DOB, String exam) {
    // do Somthing on event change value
    print("this value motherName  : ${name}");
    print("this value motherName  : ${fatherName}");
    print("this value motherName  : ${motherName}");
    print("this value DOB         : ${DOB}");
    print("this value exam        : ${exam}");
    print("this value fatherName  : ${fatherName}");
    final data = Data(
      name        : name       ?? "Unknown name",
      fatherName  : fatherName ?? "Unknown fatherName",
      motherName  : motherName ?? "Unknown motherName",
      dOB         : DOB        ?? updateInfo?.data?.dOB ?? "Unknown dOB",
      examDate    : exam       ?? updateInfo?.data?.examDate ?? "Unknown examDate",
    );
    if (updateInfo == null) {
      updateInfo = UpdateInfo(data: data);
    }
    else{
      print("data in class Data   : ${data.name}");
      final updateValue = updateInfo!.copyWith(data: data);
      print("this is updatedValue : ${updateValue}");
      emit(updateValue!);
    }
  }

  // method for update information
  Future<void> update() async {
    final submitValue = updateInfo;

    var response = await apiRepository.updateInfo(
        submitValue?.data?.name as String,
        //DOB,
        submitValue?.data?.dOB as String,
        //exa
        submitValue?.data?.examDate as String,
        //fatherName,
        submitValue?.data?.fatherName as String,
        //motherName
        submitValue?.data?.motherName as String
      );
    print("This is repsonse ${response.data}");
    emit(response);
  }
}
