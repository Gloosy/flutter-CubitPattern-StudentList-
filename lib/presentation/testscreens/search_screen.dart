import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/cubit/get/cubit_cubit.dart';
import 'package:rive_animation/data/model/studentmodel.dart';
import 'package:rive_animation/presentation/testscreens/update_screen.dart';
import 'package:rive_animation/utils/responsive.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = '/search_screen';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKeySearch = GlobalKey<FormState>();

  File? _image;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Perform any custom cleanup operations here
    super
        .dispose(); // Call super.dispose() to release resources used by the widget
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();

    StudentData studentData;

    BlocProvider.of<StudentCubit>(context).fetchStudent(_searchController.text);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
      ),
      body: BlocBuilder<StudentCubit, StudentListModel>(
        builder: (context, state) {
        if ((state.data != null)) {
          //assign value to studentInfo
          studentData = state.data![0];

          return ListView(
            children: [
              SizedBox(
                height: Responsive.height(30, context),
              ),
              Padding(
                padding: EdgeInsets.only(left: Responsive.width(50, context)),
                child: Text(
                  "ស្វែងរកព័ត៌មានសិស្ស",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              SizedBox(
                height: Responsive.height(10, context),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: Responsive.width(7, context),
                  right: Responsive.height(7, context),
                ),
                height: Responsive.height(44, context),
                width: double.infinity,
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            Responsive.radiusSize(10, context)),
                        borderSide: BorderSide(width: 1.0, color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          Responsive.radiusSize(10, context)),
                      borderSide: BorderSide(width: 1.0, color: Colors.white),
                    ),
                    contentPadding:
                        EdgeInsets.only(top: Responsive.height(10, context)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Responsive.radiusSize(10.0, context),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Input Latter Number",
                    hintStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                      final Color color = states.contains(MaterialState.error)
                          ? Theme.of(context).colorScheme.error
                          : Colors.blue;
                      return TextStyle(color: color, letterSpacing: 1.3);
                    }),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    BlocProvider.of<StudentCubit>(context).fetchStudent(value);
                  },
                  validator: (value) {
                    if (value!.isEmpty ||
                        !numberValiatorRegExp.hasMatch(value)) {
                      return "";
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              SizedBox(
                height: Responsive.height(10, context),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: Responsive.height(20, context),
                  left: Responsive.width(7, context),
                  right: Responsive.height(7, context),
                ),
                height: Responsive.height(120, context),
                width: Responsive.width(500, context),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, UpdateScreen.routeName,
                        // this is student search student info
                        arguments: studentData);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(Responsive.width(0, context)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                SizedBox(
                                  height: Responsive.height(100, context),
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        child: Column(
                                          children: [
                                            _image == null
                                                ? Container(
                                                    height: Responsive.height(
                                                        50, context),
                                                    width: Responsive.width(
                                                        50, context),
                                                    child: Image.asset(
                                                        'assets/Images/img.png'))
                                                : Container(
                                                    height: Responsive.height(
                                                        20, context),
                                                    width: Responsive.width(
                                                        20, context),
                                                    child: Image.file(
                                                        _image! as File),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        height: Responsive.height(50, context),
                                        width: Responsive.width(500, context),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left:
                                                  Responsive.width(55, context),
                                              top: Responsive.height(
                                                  1, context)),
                                          child:
                                              Text(state.data![0].name ?? ""),
                                        ),
                                      ),
                                      Positioned(
                                        height: Responsive.height(100, context),
                                        width: Responsive.width(500, context),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left:
                                                  Responsive.width(55, context),
                                              top: Responsive.height(
                                                  25, context)),
                                          child: Text(state.data![0].DOB ?? ""),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          );
        } else {
          return _searchBar(_searchController);
        }
      }),
    );
  }

  Widget _searchBar(TextEditingController searchController) {
    return ListView(
      children: [
        SizedBox(
          height: Responsive.height(30, context),
        ),
        Padding(
          padding: EdgeInsets.only(left: Responsive.width(50, context)),
          child: Text(
            "ស្វែងរកព័ត៌មានសិស្ស",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        SizedBox(
          height: Responsive.height(10, context),
        ),
        Container(
          margin: EdgeInsets.only(
            left: Responsive.width(7, context),
            right: Responsive.height(7, context),
          ),
          height: Responsive.height(44, context),
          width: double.infinity,
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: "បញ្ចូលលេខបញ្ជី",
              hintStyle: MaterialStateTextStyle.resolveWith(
                  (Set<MaterialState> states) {
                final Color color = states.contains(MaterialState.error)
                    ? Theme.of(context).colorScheme.error
                    : Colors.blue;
                return TextStyle(color: color, letterSpacing: 1.3);
              }),
              floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                  (Set<MaterialState> states) {
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
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              BlocProvider.of<StudentCubit>(context).fetchStudent(value);
            },
            validator: (value) {
              if (value!.isEmpty || !numberValiatorRegExp.hasMatch(value)) {
                return "";
              } else {
                return null;
              }
            },
            autovalidateMode: AutovalidateMode.always,
          ),
        ),
      ],
    );
  }
}
