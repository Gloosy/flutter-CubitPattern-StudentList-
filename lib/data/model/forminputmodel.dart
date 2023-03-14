import 'package:equatable/equatable.dart';

class FormInputEventModel extends Equatable{
  String? name;
  String? fatherName;
  String? motherName;
  String? dob;
  String? exam;
  FormInputEventModel(
      {this.name, this.fatherName, this.motherName, this.dob, this.exam});
      
        @override
        // TODO: implement props
        List<Object?> get props => [name, fatherName, motherName, dob, exam];
}
