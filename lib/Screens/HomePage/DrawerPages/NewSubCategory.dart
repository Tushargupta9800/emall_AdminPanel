import 'package:flutter/material.dart';

class NewSubCategory extends StatefulWidget {
  @override
  _NewSubCategoryState createState() => _NewSubCategoryState();
}

class _NewSubCategoryState extends State<NewSubCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 200,
      height: MediaQuery.of(context).size.height,
    );
  }
}
