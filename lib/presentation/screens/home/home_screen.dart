import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive_animation/api_service/student_service.dart';
import 'package:rive_animation/cubit/get/cubit_cubit.dart';
import 'package:rive_animation/cubit/post/cubit_post_cubit.dart';
import 'package:rive_animation/data/model/course.dart';
import 'package:rive_animation/data/model/studentmodel.dart';
import 'package:rive_animation/data/service/networkservice.dart';
import 'package:rive_animation/utils/databasehelper.dart';
import 'package:rive_animation/utils/responsive.dart';
import '../entryPoint/components/drobdownbutton.dart';
import 'package:rive_animation/data/repository/repository.dart';
import 'components/course_card.dart';
import 'components/secondary_course_card.dart';
import 'package:rive_animation/presentation/screens/entryPoint/components/toggle_btn.dart';
import 'package:rive_animation/presentation/screens/entryPoint/components/imagepicker.dart';
import 'package:rive_animation/presentation/screens/entryPoint/components/dobandexamdate.dart';
import 'package:rive_animation/presentation/screens/entryPoint/components/btnclicked.dart';

enum DATE { DOB, EXAMDATE }

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var dob = "";
  var examDate = "";

  static ValueNotifier<String> enteredValue = ValueNotifier('');

  DataBaseHelper dbHelper = DataBaseHelper.instance;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _fatherName = TextEditingController();
  TextEditingController _motherName = TextEditingController();
  bool? isValid;

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    // Create BlocProvider to create state and event listener here
    BlocProvider.of<StudentCubit>(context).fetchStudent();

    return Scaffold(
      body: BlocBuilder<StudentCubit, StudentListModel>(
        builder: (context, state) {
          // Print Data in HomeScreen
          /*
          print("==================== Response =======================");
          print("Name response from API : ${state.data?[0].name}");
          print("Father name            : ${state.data?[0].fatherName}");
          print("Mother name            : ${state.data?[0].motherName}");
          print("ExamDate               : ${state.data?[0].examDate}");
          print("DateOfBirth            : ${state.data?[0].DOB}");
          */
          if ((state.data != null)) {
            print("studentLoaded state");
            final students = state.data;
            print("this is data in StudentLoaded : ${students}");
            //========== ???. send data to student Widget .??? ==========//
            return _student(state.data![0]);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _student(StudentData studentListModel) {
    print("this is data DOB : ${studentListModel.DOB}");

    _nameController.text = "${studentListModel.name}";
    _fatherName.text = "${studentListModel.fatherName}";
    _motherName.text = "${studentListModel.motherName}";

    String _value = '';
    bool _isValidInput = true;
    /*
    void _onTextChanged() {
      RegExp regex = RegExp(r'^[a-zA-Z0-9\s\u1780-\u17FF]+$');

      setState(() {
        _value = _nameController.text;
        //_isValidInput = regex.hasMatch(newValue);
      });
    }
    */
    @override
    void dispose() {
      _nameController.dispose();
      
      super.dispose();
    }

    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.only(
                  left: Responsive.width(95, context),
                  top: Responsive.width(20, context)),
              child: Text(
                "ផ្លាស់ប្តូរពត៌មាន",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: courses
                    .map(
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
            // input ImagePicker
            Container(
              margin: EdgeInsets.only(
                  top: Responsive.height(4, context),
                  left: Responsive.width(70, context)),
              height: Responsive.height(200, context),
              width: Responsive.height(200, context),
              //child: _imagepicked(),
            ),
            // input name
            Container(
              height: Responsive.height(60, context),
              width: Responsive.width(380, context),
              padding: EdgeInsets.only(
                  left: Responsive.width(10, context),
                  top: Responsive.width(15, context)),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "គោត្តនាម នាម",
                    hintStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                      final Color color = states.contains(MaterialState.error)
                          ? Theme.of(context).colorScheme.error
                          : Colors.blue;
                      return TextStyle(color: color, letterSpacing: 1.3);
                    }),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            Responsive.radiusSize(10, context)),
                        borderSide: BorderSide(width: 1.0, color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          Responsive.radiusSize(10, context)),
                      borderSide: BorderSide(width: 1.0, color: Colors.white),
                    ),
                  ),
                  validator: (value) {
                    if (!value!.isEmpty ||
                        !RegExp(r'^[a-zA-Z0-9\s\u1780-\u17FF]+$')
                            .hasMatch(value)) {
                      isValid = false;
                      return "";
                    }
                    //valid input
                    else if (value.isEmpty ||
                        RegExp(r'^[a-zA-Z0-9\s\u1780-\u17FF]+$')
                            .hasMatch(value)) {
                      isValid = true;
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
            ),
            // edit father name
            Container(
              height: Responsive.height(60, context),
              width: Responsive.width(380, context),
              padding: EdgeInsets.only(
                  left: Responsive.width(10, context),
                  top: Responsive.width(15, context)),
              child: TextFormField(
                /////// --------------- get value from user in this place /////// ---------------
                controller: _fatherName,
                decoration: InputDecoration(
                  labelText: "ឈ្មោះឪពុក",
                  hintStyle: MaterialStateTextStyle.resolveWith(
                      (Set<MaterialState> states) {
                    final Color color = states.contains(MaterialState.error)
                        ? Theme.of(context).colorScheme.error
                        : Colors.blue;
                    return TextStyle(color: color, letterSpacing: 1.3);
                  }),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          Responsive.radiusSize(10, context)),
                      borderSide: BorderSide(width: 1.0, color: Colors.blue)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          Responsive.radiusSize(10, context)),
                      borderSide: BorderSide(width: 1.0, color: Colors.white)),
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]').hasMatch(value)) {
                    isValid = true;
                    return "";
                  } else {
                    isValid = false;
                    return null;
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            // edit mother name
            Container(
              height: Responsive.height(60, context),
              width: Responsive.width(380, context),
              padding: EdgeInsets.only(
                  left: Responsive.width(10, context),
                  top: Responsive.width(15, context)),
              child: TextFormField(
                /////// --------------- get value from user in this place /////// ---------------
                controller: _motherName,
                decoration: InputDecoration(
                  labelText: "ឈ្មោះម្តាយ",
                  hintStyle: MaterialStateTextStyle.resolveWith(
                      (Set<MaterialState> states) {
                    final Color color = states.contains(MaterialState.error)
                        ? Theme.of(context).colorScheme.error
                        : Colors.blue;
                    return TextStyle(color: color, letterSpacing: 1.3);
                  }),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          Responsive.radiusSize(10, context)),
                      borderSide: BorderSide(width: 1.0, color: Colors.blue)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          Responsive.radiusSize(10, context)),
                      borderSide: BorderSide(width: 1.0, color: Colors.white)),
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]').hasMatch(value)) {
                    isValid = false;
                    return "";
                  } else {
                    return null;
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            // input DOB
            Container(
              padding: EdgeInsets.only(
                top: Responsive.height(10, context),
              ),
              height: Responsive.height(120, context),
              width: Responsive.width(400, context),
              //child: DOBAndExamDate(studentDOB: "${studentListModel.DOB}"),
            ),

            /*
              // input number of certificate
              Container(
                height : Responsive.height(60, context),
                width  : Responsive.width(380, context),
                padding: EdgeInsets.only(
                    left : Responsive.width(10, context),
                    top  : Responsive.width(15, context)
                ),
                child: TextField(
                  /////// --------------- get value number of certificate from user in this place /////// ---------------

                  controller: numberOfCertificate,

                  decoration: InputDecoration(
                    labelText        : 'លេខចុះបញ្ជី',
                    focusedBorder    : OutlineInputBorder(
                        borderRadius : BorderRadius.circular(
                            Responsive.radiusSize(10, context)),
                        borderSide   : BorderSide(width: 1.0, color: Colors.white)),
                    enabledBorder    : OutlineInputBorder(
                        borderRadius : BorderRadius.circular(
                            Responsive.radiusSize(10, context)),
                        borderSide   :
                        BorderSide(width: 1.0, color: Colors.white)),
                  ),
                ),
              ),
              // select gender
              Container(
                // Stack for Position of Gender
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: Responsive.width(50, context),
                            top : Responsive.height(15, context)
                        ),
                        child: Text(
                          '*ភេទ', style: TextStyle(
                          fontSize: 20,
                          fontFamily: '',
                        ),
                        ),
                      ),
                    ),
                    Positioned(
                        child: Container(
                          width: Responsive.width(300, context),
                          margin: EdgeInsets.only(
                              left: Responsive.width(80, context)
                          ),
                          padding: EdgeInsets.only(
                              left: Responsive.width(70, context),
                              top: Responsive.height(10, context),
                              right: Responsive.width(3, context)
                          ),

                          // this toggle button
                          child: ToggleButton(
                            width: Responsive.width(200, context),
                            height: Responsive.height(50.0, context),
                            toggleBackgroundColor: Colors.white,
                            toggleBorderColor: (Colors.grey[350])!,
                            toggleColor: Color(0x021F65),
                            activeTextColor: Colors.white,
                            inactiveTextColor: Colors.black,
                            leftDescription: 'MALE',
                            rightDescription: 'FEMALE',
                            onLeftToggleActive: () {
                              print('left toggle activated');
                            },
                            onRightToggleActive: () {
                              print('right toggle activated');
                            },
                          ),
                        )),
                  ],
                ),
              ),
              // input Room
              Container(
                height : Responsive.height(60, context),
                width  : Responsive.width(380, context),
                padding: EdgeInsets.only(
                    left : Responsive.width(10, context),
                    top  : Responsive.width(15, context)
                ),
                child: TextField(
                  /////// --------------- get value from user in this place /////// ---------------

                  controller: numberOfRoom,

                  decoration: InputDecoration(
                    labelText: 'លេខបន្ទប់',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            Responsive.radiusSize(10, context)),
                        borderSide: BorderSide(width: 1.0, color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            Responsive.radiusSize(10, context)),
                        borderSide:
                        BorderSide(width: 1.0, color: Colors.white)),
                  ),
                ),
              ),

              // input table
              Container(
                height : Responsive.height(60, context),
                width  : Responsive.width(380, context),
                padding: EdgeInsets.only(
                    left : Responsive.width(10, context),
                    top  : Responsive.width(15, context)
                ),
                child: TextField(
                  ///////// --------------- get value number of table from user in this place /////// ---------------

                  controller: numberOfTable,

                  decoration          : InputDecoration(
                    labelText         : 'លេខតុ',
                    focusedBorder     : OutlineInputBorder(
                        borderRadius  : BorderRadius.circular(
                            Responsive.radiusSize(10, context)),
                        borderSide    : BorderSide(width: 1.0, color: Colors.white)),
                    enabledBorder     : OutlineInputBorder(
                        borderRadius  : BorderRadius.circular(
                            Responsive.radiusSize(10, context)),
                        borderSide:
                        BorderSide(width: 1.0, color: Colors.white)),
                  ),
                ),
              ),
              Container(
                width  : Responsive.width(500, context),
                height : Responsive.height(120, context),
                child  : DropDownButton(),
              ),

               */

            Container(
              margin: EdgeInsets.only(
                  top: Responsive.height(5, context),
                  left: Responsive.width(45, context)),
              height: Responsive.height(50, context),
              width: Responsive.width(300, context),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final value = _nameController.text;
                    setState(() {
                      // last value to api
                    });
                  }
                  //print("Hello heelo");
                  /*
                  switch isValid {
                    case: true 
                     break;
                    case: break;
                  }
                  */
                },
                child: Text('កែប្រែ'),
              ),
            ),
            // ...recentCourses
            //     .map((course) => Padding(
            //           padding: const EdgeInsets.only(
            //               left: 20, right: 20, bottom: 20),
            //           child: SecondaryCourseCard(
            //             title: course.title,
            //             iconsSrc: course.iconSrc,
            //             colorl: course.color,
            //           ),
            //         ))
            //     .toList(),
          ],
        ),
      ),
    );
  }

  // Widget _imagepicked() {
  //   return BlocProvider(
  //     create: (BuildContext context) => CubitPostImage(
  //         apiRepository: ApiRepository(apiService: DioService())),
  //     child: ImagePickerView(),
  //   );
  // }
}
