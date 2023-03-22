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

  

  TextEditingController _searchController = TextEditingController();

  void updateList(String value) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Responsive.width(5, context)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Input Latter Number',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: Responsive.height(10, context),
              ),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      Responsive.radiusSize(10.0, context),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Input Latter Number",
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.white10,
                ),
              ),
              SizedBox(
                height: Responsive.height(10, context),
              ),
              Expanded(
                child: ListView(
                  // children: [
                  //   Con
                  // ],
                ),
              ),
            ]),
      ),
    );
  }
}
