import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  const Pagination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
