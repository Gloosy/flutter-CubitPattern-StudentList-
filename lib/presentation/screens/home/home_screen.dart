import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive_animation/api_service/student_service.dart';
import 'package:rive_animation/cubit/cubit_cubit.dart';
import 'package:rive_animation/data/model/course.dart';
import 'package:rive_animation/data/model/studentmodel.dart';
import 'package:rive_animation/utils/databasehelper.dart';
import '../entryPoint/entry_point.dart';
import 'package:rive_animation/utils/responsive.dart';
import '../entryPoint/components/drobdownbutton.dart';
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
  // instance object from databaseHelper

  var dob = "";
  var examDate = "";

  static ValueNotifier<String> enteredValue = ValueNotifier('');

  //List<StudentListModel>? _listStudent;

  DataBaseHelper dbHelper = DataBaseHelper.instance;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _fatherName = TextEditingController();
  TextEditingController _motherName = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Create BlocProvider to create state and event listener here
    BlocProvider.of<StudentCubit>(context).fetchStudent();
    return Scaffold(
      body: BlocBuilder<StudentCubit, StudentListModel>(
        builder: (context, state) {
          print("Data loaded is here by NONG Piseth:");
          print(state);
          if ((state is StudentLoading)) {
            return Center(
              child: Text('THIS IS LOADING STUDENT'),
            );
          } else if ((state is StudentLoaded)) {
            final todos = state.data!;
            child:
            ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final studentData = todos[index];
                  Dismissible(
                    key: Key("${studentData.Id}"),
                    child: SafeArea(
                      bottom: false,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
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
                                        padding:
                                            const EdgeInsets.only(left: 20),
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
                                  top: Responsive.height(20, context),
                                  left: Responsive.width(90, context)),
                              height: Responsive.height(200, context),
                              width: Responsive.height(200, context),
                              child: ImagePickerView(),
                            ),
                            // input name
                            Container(
                              height: Responsive.height(60, context),
                              width: Responsive.width(380, context),
                              padding: EdgeInsets.only(
                                  left: Responsive.width(10, context),
                                  top: Responsive.width(15, context)),
                              child: Form(
                                key: formKey,
                                child: TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    labelText: studentData.name ?? "",
                                    hintStyle:
                                        MaterialStateTextStyle.resolveWith(
                                            (Set<MaterialState> states) {
                                      final Color color = states
                                              .contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.blue;
                                      return TextStyle(
                                          color: color, letterSpacing: 1.3);
                                    }),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            Responsive.radiusSize(10, context)),
                                        borderSide: BorderSide(
                                            width: 1.0, color: Colors.blue)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            Responsive.radiusSize(10, context)),
                                        borderSide: BorderSide(
                                            width: 1.0, color: Colors.white)),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !RegExp(r'^[a-z A-Z]+$')
                                            .hasMatch(value)) {
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                autofocus: false,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  //labelText: studentListModel.fatherName!,
                                  hintStyle: MaterialStateTextStyle.resolveWith(
                                      (Set<MaterialState> states) {
                                    final Color color = states
                                            .contains(MaterialState.error)
                                        ? Theme.of(context).colorScheme.error
                                        : Colors.blue;
                                    return TextStyle(
                                        color: color, letterSpacing: 1.3);
                                  }),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Responsive.radiusSize(10, context)),
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.blue)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Responsive.radiusSize(10, context)),
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.white)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'^[a-z A-Z]+$')
                                          .hasMatch(value)) {
                                    return "";
                                  } else {
                                    return null;
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                autofocus: false,
                                decoration: InputDecoration(
                                  labelText: studentData.motherName ?? "",
                                  hintStyle: MaterialStateTextStyle.resolveWith(
                                      (Set<MaterialState> states) {
                                    final Color color = states
                                            .contains(MaterialState.error)
                                        ? Theme.of(context).colorScheme.error
                                        : Colors.blue;
                                    return TextStyle(
                                        color: color, letterSpacing: 1.3);
                                  }),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Responsive.radiusSize(10, context)),
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.blue)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Responsive.radiusSize(10, context)),
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.white)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'^[a-z A-Z]+$')
                                          .hasMatch(value)) {
                                    return "";
                                  } else {
                                    return null;
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            // input DOB
                            Container(
                              padding: EdgeInsets.only(
                                top: Responsive.height(10, context),
                              ),
                              height: Responsive.height(120, context),
                              width: Responsive.width(400, context),
                              child: DOBAndExamDate(),
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
                                  var name = _nameController;
                                  var fatherName = _fatherName;
                                  var motherName = _motherName;
                                },
                                child: const Text('កែប្រែ'),
                              ),
                            ),
                            ...recentCourses
                                .map((course) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, bottom: 20),
                                      child: SecondaryCourseCard(
                                        title: course.title,
                                        iconsSrc: course.iconSrc,
                                        colorl: course.color,
                                      ),
                                    ))
                                .toList(),
                          ],
                        ),
                      ),
                    ),
                  );
                  return Container();
                });
            // return SingleChildScrollView(
            //   child: Column(children: todos!.map((e) => _student(e)).toList()),
            // );
          } else if ((state is StudentError)) {
            //print(state.errors.toString());
            // return Center(child: Text(state.errors.toString()));
          }
          return Container();
        },
      ),
    );
  }

  Widget _student(StudentListModel studentListModel) {
    return SafeArea(
      child: Container(
          height: Responsive.height(450, context),
          width: double.infinity,
          child: ListView.builder(
              itemCount: studentListModel.data?.length,
              itemBuilder: (context, index) {
                final studentData = studentListModel.data![index];
                Dismissible(
                  key: Key("${studentData.Id}"),
                  child: SafeArea(
                    bottom: false,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          Padding(
                            padding: EdgeInsets.only(
                                left: Responsive.width(95, context),
                                top: Responsive.width(20, context)),
                            child: Text(
                              "ផ្លាស់ប្តូរពត៌មាន",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
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
                                top: Responsive.height(20, context),
                                left: Responsive.width(90, context)),
                            height: Responsive.height(200, context),
                            width: Responsive.height(200, context),
                            child: const ImagePickerView(),
                          ),
                          // input name
                          Container(
                            height: Responsive.height(60, context),
                            width: Responsive.width(380, context),
                            padding: EdgeInsets.only(
                                left: Responsive.width(10, context),
                                top: Responsive.width(15, context)),
                            child: Form(
                              key: formKey,
                              child: TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: studentData.name ?? "",
                                  hintStyle: MaterialStateTextStyle.resolveWith(
                                      (Set<MaterialState> states) {
                                    final Color color = states
                                            .contains(MaterialState.error)
                                        ? Theme.of(context).colorScheme.error
                                        : Colors.blue;
                                    return TextStyle(
                                        color: color, letterSpacing: 1.3);
                                  }),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Responsive.radiusSize(10, context)),
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.blue)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Responsive.radiusSize(10, context)),
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.white)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'^[a-z A-Z]+$')
                                          .hasMatch(value)) {
                                    return "";
                                  } else {
                                    return null;
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                              autofocus: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: studentListModel.fatherName!,
                                hintStyle: MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                                  final Color color =
                                      states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.blue;
                                  return TextStyle(
                                      color: color, letterSpacing: 1.3);
                                }),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Responsive.radiusSize(10, context)),
                                    borderSide: BorderSide(
                                        width: 1.0, color: Colors.blue)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Responsive.radiusSize(10, context)),
                                    borderSide: BorderSide(
                                        width: 1.0, color: Colors.white)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                  return "";
                                } else {
                                  return null;
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                              autofocus: false,
                              decoration: InputDecoration(
                                labelText: studentData.motherName ?? "",
                                hintStyle: MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                                  final Color color =
                                      states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.blue;
                                  return TextStyle(
                                      color: color, letterSpacing: 1.3);
                                }),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Responsive.radiusSize(10, context)),
                                    borderSide: BorderSide(
                                        width: 1.0, color: Colors.blue)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Responsive.radiusSize(10, context)),
                                    borderSide: BorderSide(
                                        width: 1.0, color: Colors.white)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                  return "";
                                } else {
                                  return null;
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                          // input DOB
                          Container(
                            padding: EdgeInsets.only(
                              top: Responsive.height(10, context),
                            ),
                            height: Responsive.height(120, context),
                            width: Responsive.width(400, context),
                            child: DOBAndExamDate(),
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
                                var name = _nameController;
                                var fatherName = _fatherName;
                                var motherName = _motherName;
                              },
                              child: const Text('កែប្រែ'),
                            ),
                          ),
                          ...recentCourses
                              .map((course) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: SecondaryCourseCard(
                                      title: course.title,
                                      iconsSrc: course.iconSrc,
                                      colorl: course.color,
                                    ),
                                  ))
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                );
                return Container();
              })),
    );
  }
}
