import 'package:flutter/material.dart';

class FilterActiveTasks extends StatelessWidget {
  const FilterActiveTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 10,
      ),
      child: TextField(
        decoration: InputDecoration(hintText: 'Filter tasks'),
      ),
    );
  }
}
