import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:rive_animation/utils/responsive.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchPage> {


  /// method to create a dummy list of movies.
  /// you can build your own list. i used the IMDB data so you can
  /// the list 
  

  
  void updateList(String value){


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Responsive.width(5, context)),
        child: Column(
          mainAxisAlignment  : MainAxisAlignment.start,
          crossAxisAlignment : CrossAxisAlignment.start,
          children: [
            Text('Search Student Name', 
              style        : TextStyle(
                color      :  Colors.black,
                fontSize   : 20.0,
                fontWeight : FontWeight.bold,
              ),
            ),
            SizedBox(
              height: Responsive.height(10, context),
            ),
            TextField(
              decoration: InputDecoration(
                filled          : true,
                fillColor       : Colors.white,
                border          : OutlineInputBorder(
                  borderRadius  : BorderRadius.circular(
                    Responsive.radiusSize(10.0, context),
                  ),
                  borderSide: BorderSide.none,
                ),
                hintText        : "Search Studetn",
                prefixIcon      : Icon(Icons.search),
                prefixIconColor : Colors.white10,
              ),
            ),
            SizedBox(height : Responsive.height(10, context),),
            Expanded(child  : ListView(),
            ),
          ]),
        ),
    );
  }
}
