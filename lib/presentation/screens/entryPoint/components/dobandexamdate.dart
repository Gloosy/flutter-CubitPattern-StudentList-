import 'package:flutter/material.dart';
import 'package:rive_animation/data/model/studentmodel.dart';
import 'package:rive_animation/presentation/screens/home/home_screen.dart';
import 'package:rive_animation/utils/responsive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

enum DATE { DOB, EXAMDATE }

// we have to add the of element tree

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
  DateTime _dob = DateTime.now();
  DateTime _examdate = DateTime.now();
  DateTime _selectionDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.focusNodeDOB != null && widget.focusNodeExam != null) {
      _dob = DateTime.parse(widget.studentDOB);
      _examdate = DateTime.parse(widget.studentExam);
    }
  }

  @override
  void dispose() {
    super.dispose();

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
        .then(
      (value) {
        setState(() {
          if (date == DATE.DOB && value != null) {
            _dob = value;
          } else if (date == DATE.EXAMDATE && value != null) {
            _examdate = value;
          }
        });
        widget.onValueChanged(_dob, _examdate);
      },
    );
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
                  _showDatePicker(DATE.DOB);
                },
                child: Container(
                    padding: EdgeInsets.only(
                        left: Responsive.width(30, context),
                        right: Responsive.width(35, context),
                        bottom: Responsive.width(10, context),
                        top: Responsive.width(10, context)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          Responsive.radiusSize(10, context)),
                      color: Colors.white,
                    ),
                    child: Text(widget.studentDOB ??
                        DateFormat('dd-MM-yyyy').format(_dob) ??
                        '')),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    //left: Responsive.width(7, context),
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
                  _showDatePicker(DATE.EXAMDATE);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: Responsive.width(30, context),
                      right: Responsive.width(35, context),
                      bottom: Responsive.width(10, context),
                      top: Responsive.width(10, context)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        Responsive.radiusSize(10, context)),
                    color: Colors.white,
                  ),
                  // ignore: unnecessary_string_interpolations
                  child: Text(
                    widget.studentExam ??
                        DateFormat('dd-MM-yyyy').format(_examdate),
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
