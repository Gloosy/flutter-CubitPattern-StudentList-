import 'package:flutter/material.dart';
import 'package:rive_animation/utils/responsive.dart';


class ButtonClicked extends StatefulWidget {
  const ButtonClicked({Key? key}) : super(key: key);

  @override
  State<ButtonClicked> createState() => _ButtonClickedState();
}

class _ButtonClickedState extends State<ButtonClicked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            child: _btnsearch(),
          ),
          /*
          Container(
            child: _researchbtn(),
          ),

           */
        ],
      ),
    );
  }
  Widget _btnsearch(){
    return GestureDetector(
      onTap: () {
        //post data
      },
      child: Container(
        width          : Responsive.width(370, context),
        alignment      : Alignment.center,
        padding        : EdgeInsets.only(
            top        : Responsive.height(5, context),
            bottom     : Responsive.height(5, context)),
            margin     : EdgeInsets.only(
            left       : Responsive.width(10, context)),
        decoration     : BoxDecoration(
          color        : Color(0x021F65),
          borderRadius : BorderRadius.circular(
              Responsive.radiusSize(10, context)),
            border: Border.all(color: Colors.blue)
        ),
        child: Text(
          'កែប្រែ',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
    );
  }
  Widget _researchbtn(){
    return GestureDetector(
      onTap: () {
        // re-search
      },
      child: Container(
        alignment: Alignment.center,
        width: Responsive.width(210, context),
        height: Responsive.height(50, context),
        padding: EdgeInsets.only(
            top: Responsive.height(5, context),
            bottom: Responsive.height(5, context)),
        margin: EdgeInsets.only(
            left: Responsive.width(10, context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              Responsive.radiusSize(10, context)),
          color: Color(0x021F65),
            border: Border.all(color: Colors.red)
        ),
        child: Text(
          'កំណត់ឡើងវិញ',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
    );
  }
}

