import 'package:flutter/material.dart';
import 'package:rive_animation/utils/responsive.dart';


class DropDownButton extends StatefulWidget {
  const DropDownButton({Key? key}) : super(key: key);

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {

  String? _chosenPlaces;
  String? _chosenYear;
  String? _chosenCenter;
  // String? _;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: Responsive.height(10, context),
                left: Responsive.width(215, context),
                  child: Container(
                    width: Responsive.width(150, context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            Responsive.radiusSize(10, context)),
                        color: Colors.white,
                    ),
                    margin: EdgeInsets.only(
                        left: Responsive.radiusSize(15, context),
                        right: Responsive.radiusSize(50, context)
                    ),
                    child: _dropdownyearexam(),
                  )
              ),

              Positioned(
                top : Responsive.height(10, context),
                  right: Responsive.width(120, context),

                  child: Container(
                      width: Responsive.width(210, context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            Responsive.radiusSize(10, context)),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(
                          left: Responsive.radiusSize(50, context),
                          right: Responsive.radiusSize(50, context)
                      ),
                      child: _dropdownprovince()
                  )
              ),
              // center of exam
              Positioned(
                top: Responsive.height(70, context),
                  child: Container(
                    width: Responsive.width(370, context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          Responsive.radiusSize(10, context)),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(
                        left: Responsive.radiusSize(15, context),
                        right: Responsive.radiusSize(50, context)
                    ),
                    child: _dropdowncenter(),
                  )
              ),
            ],
          ),
      ),
    ),
    );
  }
  Widget _dropdownyearexam(){
    return Container(
      child: Container(
        padding: const EdgeInsets.all(0.0),
        width: Responsive.width(300, context),
        child : Column(
          children: [
            DropdownButton<String>(
              value: _chosenYear,
              //alignment: Alignment.topRight,
              style: TextStyle(color: Colors.black),
              items: <String>[
                '--ឆ្នាំប្រលង--',
                '២០២២',
                '២០២៣',
                '២០២៤',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text(
                "២០២២",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              onChanged: (value){

                _chosenYear = value!;
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _dropdownprovince(){
    return Container(
      child: Container(
        padding: const EdgeInsets.all(0.0),
        width: Responsive.width(300, context),
        margin: EdgeInsets.only(
          left: Responsive.width(20, context),
        ),

        child : Column(
          children: [
            DropdownButton<String>(
              value: _chosenPlaces,
              //alignment: Alignment.topRight,
              style: TextStyle(color: Colors.black),
              items: <String>[
                '--ខេត្ត/ក្រុង--',
                '1- បន្ទាយមានជ័យ',
                '២- បាត់ដំបង',
                '៣- កំពង់ចាម',
                '៤- កំពង់ឆ្នាំង',
                '៥- កំពង់ធំ',
                '៦- កំពត',
                '៧- កណ្តាល',
                '៨- កោះកុង',
                '៩- ក្រចេះ',
                '១០- មណ្ឌលគិរឺ',
                '១១- ភ្នំពេញ',
                '១២- ព្រះវិហារ',
                '១៣- ព្រៃវែង',
                '១៤- ពោធិ៍សាត់',
                '១៥- រតនគិរី',
                '១៦- សៀមរាប',
                '១៧- ព្រះសីហនុ',
                '១៨- ស្ទឹងត្រែង',
                '១៩- ស្វាយរៀង',
                '២០- តាកែវ',
                '២១- កែប',
                '២២- ប៉ៃលិន',
                '២៣- ឧត្តរមានជ័យ',
                '២៤- ត្បូងឃ្មុំ',
                '២៥- កំពង់ស្ពី'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text(
                "--ខេត្ត/ក្រុង--",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              onChanged: (value){
                _chosenPlaces = value!;
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _dropdowncenter(){
    return Container(
      child: Container(
        padding: const EdgeInsets.all(0.0),
        width: Responsive.width(400, context),
        margin: EdgeInsets.only(
          left: Responsive.width(10, context),
        ),
        child : Column(
          children: [
            DropdownButton<String>(
              value: _chosenCenter,
              //alignment: Alignment.topRight,
              style: TextStyle(color: Colors.black),
              items: <String>[
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text(
                "--មណ្ឌលប្រលង--",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              onChanged: (value){
                _chosenCenter = value!;
              },
            ),
          ],
        ),
      ),
    );
  }
}
