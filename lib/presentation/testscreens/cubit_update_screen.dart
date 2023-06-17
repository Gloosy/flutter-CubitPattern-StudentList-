import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rive_animation/cubit/update/update_cubit.dart';
import 'package:rive_animation/data/model/course.dart';
import 'package:rive_animation/data/model/postStuInfo.dart';
import 'package:rive_animation/presentation/screens/entryPoint/components/dobandexamdate.dart';
import 'package:rive_animation/presentation/screens/home/components/course_card.dart';
import 'package:rive_animation/utils/responsive.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<PostScreen> {

  String? _textValue;
  bool? _isKeyboardVisible = false;

  // apply textFormField controller
  TextEditingController _nameController       = TextEditingController();
  TextEditingController _fatherNameController = TextEditingController();
  TextEditingController _motherNameController = TextEditingController();
  TextEditingController _dobController        = TextEditingController();
  TextEditingController _examController       = TextEditingController();

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      body: BlocBuilder<UpdateCubit, PostStuInfo>(builder: (context, state) {
        return _updateForm(state, _nameController, _fatherNameController,
            _motherNameController, _dobController, _examController);
      }),
    );
  }

  Widget _updateForm(
      PostStuInfo updateInfo,
      TextEditingController _nameController,
      TextEditingController _fatherNameController,
      TextEditingController _motherNameController,
      TextEditingController _dobController,
      TextEditingController _examController){

    var inputFormat = DateFormat('MM-dd-yyyy'); 

    // this method update in Student
    final updateMethod = BlocProvider.of<UpdateCubit>(context);

    final _formKeyName       = GlobalKey<FormState>();
    final _formKeyFatherName = GlobalKey<FormState>();
    final _formKeyMotherName = GlobalKey<FormState>();

    // method to update
    void submitUpdate() {
      // method to update
      updateMethod.update();
      _nameController.text       = "";
      _fatherNameController.text = "";
      _motherNameController.text = "";
    }

    return ListView(
      children: [
        SizedBox(height: Responsive.height(20, context)),
        Padding(
          padding: EdgeInsets.only(
              left : Responsive.width(95, context),
              top  : Responsive.width(20, context)),
          child: Text(
            "បញ្ចូលពត៌មានថ្មី",
            style  : Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: courses.map(
                  (course) => Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CourseCard(
                      title: course.title,
                      iconSrc: course.iconSrc,
                      color: course.color,
                    ),
                  ),
                )
            .toList(),
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
          studentDOB: "${updateInfo.data?.dOB}",
          studentExam: "${updateInfo.data?.examDate}",
          onValueChanged: (DateTime value, DateTime valueExam) {
            _dobController.text = inputFormat.format(value);
            _examController.text = inputFormat.format(valueExam);
          },
        ),
        SizedBox(height: Responsive.height(100, context)),
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


  Widget _textFormFieldName( TextEditingController _nameController,
    GlobalKey _formKeyName) {
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
            floatingLabelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
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
        width: Responsive.width(365, context),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: "ឈ្មោះឪពុក",
            hintStyle:
                MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? Theme.of(context).colorScheme.error
                  : Colors.blue;
              return TextStyle(color: color, letterSpacing: 1.3);
            }),
            floatingLabelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
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
          autofocus: false,
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
            floatingLabelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
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
