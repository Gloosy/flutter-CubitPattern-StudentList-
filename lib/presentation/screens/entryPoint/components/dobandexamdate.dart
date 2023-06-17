import 'package:flutter/material.dart';
import 'package:rive_animation/data/model/studentmodel.dart';
import 'package:rive_animation/utils/responsive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

enum DATE { DOB, EXAMDATE }

class DOBAndExamDate extends StatefulWidget {
  final void Function(DateTime value, DateTime valueExam) onValueChanged;

  FocusNode? focusNodeDOB;
  FocusNode? focusNodeExam;
  FocusNode? focusNodeName;
  FocusNode? focusNodefather;
  FocusNode? focusNodemother;

  final String studentExam;

  final String studentDOB;

  DOBAndExamDate({
    Key? key,
    required this.studentDOB,
    required this.studentExam,
    required this.onValueChanged,
    this.focusNodeDOB,
    this.focusNodeExam,
    this.focusNodeName,
    this.focusNodefather,
    this.focusNodemother,
  }) : super(key: key);

  @override
  State<DOBAndExamDate> createState() => _DOBAndExamDateState();
}

class _DOBAndExamDateState extends State<DOBAndExamDate> {
  late DateTime _dob;
  late DateTime _examdate;

  DateTime _selectionDate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  // initState
  @override
  void initState() {
    super.initState();
    // initail Value with API
    _dob = dateFormat.parse(widget.studentDOB);
    _examdate = dateFormat.parse(widget.studentExam);
  }

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

  void _showDatePicker(DATE? date) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100))
        .then((value) {
      if (date == DATE.DOB && value != null) {
        setState(() {
          _dob = value;
        });
      } else if (date == DATE.EXAMDATE && value != null) {
        setState(() {
          _examdate = value;
        });
      }
      widget.onValueChanged(_dob, _examdate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Responsive.width(7, context),
        right: Responsive.width(7, context),
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
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _showDatePicker(DATE.DOB);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: Responsive.width(45, context),
                      right: Responsive.width(45, context),
                      bottom: Responsive.width(8, context),
                      top: Responsive.width(8, context)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        Responsive.radiusSize(10, context)),
                    color: Colors.white,
                  ),
                  child: Text(DateFormat('dd-MM-yyyy').format(_dob),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Responsive.fontSize(16, context),
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Responsive.width(7, context),
                ),
                child: Text.rich(TextSpan(
                  text: 'សម័យប្រលង',
                  style: TextStyle(
                    fontFamily: 'Inter-SemiBold.ttf',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _showDatePicker(DATE.EXAMDATE);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: Responsive.width(45, context),
                      right: Responsive.width(45, context),
                      bottom: Responsive.width(8, context),
                      top: Responsive.width(8, context)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        Responsive.radiusSize(10, context)),
                    color: Colors.white,
                  ),
                  // ignore: unnecessary_string_interpolations
                  child: Text(
                    DateFormat('dd-MM-yyyy').format(_examdate),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Responsive.fontSize(16, context),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
