import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rive_animation/cubit/get/cubit_cubit.dart';
import 'package:rive_animation/cubit/post/cubit_post_cubit.dart';
import 'package:rive_animation/cubit/update/update_cubit.dart';
import 'package:rive_animation/data/model/studentmodel.dart';
import 'package:rive_animation/presentation/screens/entryPoint/components/dobandexamdate.dart';
import 'package:rive_animation/presentation/screens/entryPoint/components/imagepicker.dart';
import 'package:rive_animation/utils/responsive.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  String? _textValue;
  bool? _isKeyboardVisible = false;

  // apply textFormField controller
  TextEditingController _nameController = TextEditingController();
  TextEditingController _fatherNameController = TextEditingController();
  TextEditingController _motherNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _examController = TextEditingController();

  String? name;
  String? fatherName;
  String? motherName;
  String? DOB;
  String? examDate;

  @override
  void initState() {
    super.initState();
    _nameController.text       = "";
    _fatherNameController.text = "";
    _motherNameController.text = "";
    _dobController.text        = "";
    _examController.text       = "";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _fatherNameController.dispose();
    _motherNameController.dispose();
    _dobController.dispose();
    _examController.dispose();
  }

  void _onKeyboardVisibilityChanged() {
    setState(() {
      _isKeyboardVisible = !_isKeyboardVisible!;
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StudentCubit>(context).fetchStudent();
    return Scaffold(
      body: BlocBuilder<StudentCubit, StudentListModel>(
          builder: (context, state) {
        if ((state.data != null)) {
          print("studentLoaded state");
          final students = state.data;
          print("this is data in StudentLoaded : ${students}");
          return _updateForm(
              state.data![0],
              _nameController,
              _fatherNameController,
              _motherNameController,
              _dobController,
              _examController);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  Widget _updateForm(
      StudentData studentData,
      TextEditingController _nameController,
      TextEditingController _fatherNameController,
      TextEditingController _motherNameController,
      TextEditingController _dobController,
      TextEditingController _examController) {
    var inputFormat = DateFormat('MM-dd-yyyy');

    // this method update in Student
    final updateMethod = BlocProvider.of<UpdateCubit>(context);
    final imageUpload = context.read<CubitPostImage>();

    final _formKeyName = GlobalKey<FormState>();
    final _formKeyFatherName = GlobalKey<FormState>();
    final _formKeyMotherName = GlobalKey<FormState>();

    File? imageSelect;

    void submitUpdate() {

      // method to update
      print("this is an image in btn submit ${imageSelect}");
      if (imageSelect != null) {
        imageUpload.postImage(File(imageSelect!.path));
      }
      updateMethod.update();
      _nameController.text       = "";
      _fatherNameController.text = "";
      _motherNameController.text = "";
    }

    // if (studentData.name != "" &&
    //     studentData.motherName != "" &&
    //     studentData.fatherName != "") {
      _nameController.text       = "${studentData.name}";
      //_fatherNameController.text = "${studentData.fatherName}";
      _motherNameController.text = "${studentData.motherName}";
    //}
    return ListView(
      children: [
        SizedBox(height: Responsive.height(20, context)),
        Padding(
          padding: EdgeInsets.only(left: Responsive.width(50, context)),
          child: Text(
            "ផ្លាស់ប្តូរពត៌មានសិស្ស",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: courses
        //         .map(
        //           (course) => Padding(
        //             padding: const EdgeInsets.only(left: 20),
        //             child: CourseCard(
        //               title: course.title,
        //               iconSrc: course.iconSrc,
        //               color: course.color,
        //             ),
        //           ),
        //         )
        //         .toList(),
        //   ),
        // ),
        SizedBox(
          height: Responsive.height(10, context),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: Responsive.width(5, context),
          ),
          child: ImagePickerViewScreen(
            changeImage: (File image) {
              imageSelect = image;
            },
          ),
        ),

        SizedBox(height: Responsive.height(10, context)),
        Container(
          padding: EdgeInsets.only(
              left: Responsive.width(7, context),
              right: Responsive.height(7, context)),
          child: _textFormFieldName(_nameController, _formKeyName),
        ),
        SizedBox(height: Responsive.height(10, context)),
        Container(
          padding: EdgeInsets.only(
              left: Responsive.width(7, context),
              right: Responsive.height(7, context)),
          child: _textFormFieldfatherName(
              _fatherNameController, _formKeyFatherName),
        ),
        SizedBox(height: Responsive.height(10, context)),
        Container(
          padding: EdgeInsets.only(
              left: Responsive.width(7, context),
              right: Responsive.height(7, context)),
          child: _textFormFieldMotherName(
              _motherNameController, _formKeyMotherName),
        ),
        SizedBox(height: Responsive.height(10, context)),
        DOBAndExamDate(
          studentDOB: "${studentData.DOB}",
          studentExam: "${studentData.examDate}",
          onValueChanged: (DateTime value, DateTime valueExam) {
            _dobController.text = inputFormat.format(value);
            _examController.text = inputFormat.format(valueExam);
          },
        ),
        SizedBox(height: Responsive.height(10, context)),
        Container(
          padding: EdgeInsets.only(
              left: Responsive.width(7, context),
              right: Responsive.height(7, context)),
          height: Responsive.height(50, context),
          width: Responsive.width(30, context),
          child: ElevatedButton(
            onPressed: () {
              if (_formKeyMotherName.currentState!.validate() &&
                  _formKeyName.currentState!.validate() &&
                  _formKeyFatherName.currentState!.validate()) {
                // method to change event on User
                updateMethod.onChangedValue(
                    _nameController.text,
                    _fatherNameController.text,
                    _motherNameController.text,
                    _dobController.text,
                    _examController.text);

                // method to update student
                submitUpdate();

                CupertinoAlertDialog(
                  title: Text('Success Updated'),
                  actions: [
                    CupertinoDialogAction(
                      child: Text('Yes'),
                    )
                  ],
                );
                //show Toast for success
                Fluttertoast.showToast(
                    msg: "Updated Success",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                //show Toast for failed
                Fluttertoast.showToast(
                    msg: "Fail to Updated",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: Text('កែប្រែ'),
          ),
        ),
      ],
    );
  }

  Widget _textFormFieldName(
      TextEditingController _nameController, GlobalKey _formKeyName) {
    return Form(
      key: _formKeyName,
      child: SizedBox(
        height: Responsive.height(44, context),
        width: Responsive.width(100, context),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: "គោត្តនាម នាម",
            hintStyle:
                MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? Theme.of(context).colorScheme.error
                  : Colors.blue;
              return TextStyle(color: color, letterSpacing: 1.3);
            }),
            floatingLabelStyle:
                MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? Theme.of(context).colorScheme.error
                  : Colors.orange;
              return TextStyle(color: color, letterSpacing: 1.3);
            }),
            focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(Responsive.radiusSize(10, context)),
                borderSide: BorderSide(width: 1.0, color: Colors.blue)),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(Responsive.radiusSize(10, context)),
              borderSide: BorderSide(width: 1.0, color: Colors.white),
            ),
            contentPadding: EdgeInsets.all(13.0),
          ),
          autofocus: true,
          controller: _nameController,
          validator: (value) {
            if (value!.isEmpty ||
                !RegExp(r'^\s*[a-zA-Z0-9\u1780-\u17FF]+(?:\s+[a-zA-Z0-9\u1780-\u17FF]+)*\s*$')
                    .hasMatch(value)) {
              return "";
            } else {
              return null;
            }
          },
          onSaved: (value) {
            _nameController.text = value!;
          },
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }

  Widget _textFormFieldfatherName(TextEditingController _fatherNameController,
      GlobalKey _formKeyFatherName) {
    return Form(
      key: _formKeyFatherName,
      child: SizedBox(
        height: Responsive.height(44, context),
        width: Responsive.width(100, context),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: "ឈ្មោះ ឪពុក",
            hintStyle:
                MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? Theme.of(context).colorScheme.error
                  : Colors.blue;
              return TextStyle(color: color, letterSpacing: 1.3);
            }),
            floatingLabelStyle:
                MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? Theme.of(context).colorScheme.error
                  : Colors.orange;
              return TextStyle(color: color, letterSpacing: 1.3);
            }),
            focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(Responsive.radiusSize(10, context)),
                borderSide: BorderSide(width: 1.0, color: Colors.blue)),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(Responsive.radiusSize(10, context)),
              borderSide: BorderSide(width: 1.0, color: Colors.white),
            ),
            contentPadding: EdgeInsets.all(13.0),
          ),
          autofocus: false,
          controller: _fatherNameController,
          validator: (value) {
            if (value!.isEmpty ||
                !RegExp(r'^\s*[a-zA-Z0-9\u1780-\u17FF]+(?:\s+[a-zA-Z0-9\u1780-\u17FF]+)*\s*$')
                    .hasMatch(value)) {
              return "";
            } else {
              return null;
            }
          },
          onSaved: (value) {
            _fatherNameController.text = value!;
          },
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }

  Widget _textFormFieldMotherName(TextEditingController _motherNameController,
      GlobalKey _formKeyMotherName) {
    return Form(
      key: _formKeyMotherName,
      child: SizedBox(
        height: Responsive.height(44, context),
        width: Responsive.width(365, context),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: "ឈ្មោះម្តាយ",
            hintStyle:
                MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? Theme.of(context).colorScheme.error
                  : Colors.blue;
              return TextStyle(color: color, letterSpacing: 2.3);
            }),
            floatingLabelStyle:
                MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? Theme.of(context).colorScheme.error
                  : Colors.orange;
              return TextStyle(color: color, letterSpacing: 1.3);
            }),
            focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(Responsive.radiusSize(10, context)),
                borderSide: BorderSide(width: 1.0, color: Colors.blue)),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(Responsive.radiusSize(10, context)),
              borderSide: BorderSide(width: 1.0, color: Colors.white),
            ),
            contentPadding: EdgeInsets.all(16.0),
          ),
          validator: (value) {
            if (value!.isEmpty ||
                !RegExp(r'^\s*[a-zA-Z0-9\u1780-\u17FF]+(?:\s+[a-zA-Z0-9\u1780-\u17FF]+)*\s*$')
                    .hasMatch(value)) {
              return "";
            } else {
              return null;
            }
          },
          controller: _motherNameController,
          onSaved: (value) {
            _motherNameController.text = value!;
          },
          autofocus: false,
          textInputAction: TextInputAction.done,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }
}
