import 'package:flutter/material.dart';
import 'package:rive_animation/data/model/studentmodel.dart';
import 'package:rive_animation/presentation/screens/home/home_screen.dart';
import 'package:rive_animation/utils/responsive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

enum DATE { DOB, EXAMDATE }

// we have to add the of element tree

class DOBAndExamDate extends StatefulWidget {
  const DOBAndExamDate({Key? key})
      : super(key: key);
  @override
  State<DOBAndExamDate> createState() => _DOBAndExamDateState();
}

class _DOBAndExamDateState extends State<DOBAndExamDate> {
  DateTime _dob = DateTime.now();
  DateTime _examdate = DateTime.now();
  

  final todos = List.generate(
    20,
    (i) => StudentData(
      name: '',
      fatherName: '',
      motherName: '',
      DOB: '',
      examDate: '',
    ),
  );

  void _showDatePicker(DATE date) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        if (date == DATE.DOB) {
          _dob = value!;
        } else {
          _examdate = value!;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildDOBAndExamDate(),
    );
  }

  @override
  Widget _buildDOBAndExamDate() {
    return Padding(
      padding: EdgeInsets.only(
        left: Responsive.width(10, context),
        right: Responsive.width(20, context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: Responsive.width(7, context)),
                child: Text.rich(TextSpan(
                  text: 'ថ្ងៃខែឆ្នាំកំណើត',
                  style: TextStyle(
                    fontFamily: 'assets/Fonts/Inter-Regular.ttf',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ),
              GestureDetector(
                onTap: () {
                  _showDatePicker(DATE.DOB);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: Responsive.width(20, context),
                      right: Responsive.width(37, context),
                      bottom: Responsive.width(10, context),
                      top: Responsive.width(10, context)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        Responsive.radiusSize(10, context)),
                    color: Colors.white,
                  ),
                  child: Container(
                      child: Text(DateFormat.yMMMMd().format(_dob))),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: Responsive.width(5, context)),
                child: Text.rich(TextSpan(
                  text: 'សម័យប្រលង',
                  style: TextStyle(
                    fontFamily: 'Inter-SemiBold.ttf',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ),
              GestureDetector(
                onTap: () {
                  _showDatePicker(DATE.EXAMDATE);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: Responsive.width(42, context),
                      right: Responsive.width(15, context),
                      bottom: Responsive.width(10, context),
                      top: Responsive.width(10, context)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        Responsive.radiusSize(10, context)),
                    color: Colors.white,
                  ),
                  child: Text(DateFormat.yMMMMd().format(_examdate)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
