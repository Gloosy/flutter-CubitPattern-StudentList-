import 'package:flutter/material.dart';
import 'package:rive_animation/utils/responsive.dart';

class HomepageTest extends StatefulWidget {
  static String routeName = "/home_page";

  const HomepageTest({Key? key}) : super(key: key);

  @override
  State<HomepageTest> createState() => _HomepageState();
}

class _HomepageState extends State<HomepageTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF17203A) ,
      ),
      body: ListView(
        children: [
          SizedBox(height: Responsive.height(70, context)),
          Padding(
            padding: EdgeInsets.only(left: Responsive.width(35, context)),
            child: Text(
              "កម្មវិធីកែប្រែវិញ្ញាបនបត្រ",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
