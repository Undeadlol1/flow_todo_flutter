import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  final void Function(int newPageNumber) onPageChange;
  const Pagination({Key? key, required this.onPageChange}) : super(key: key);

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            --_currentPage;

            if (_currentPage.isNegative) {
              _currentPage = 0;
            }

            widget.onPageChange(_currentPage);
            setState(() => _currentPage = _currentPage);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        IconButton(
          onPressed: () {
            ++_currentPage;
            widget.onPageChange(_currentPage);
            setState(() => _currentPage = _currentPage);
          },
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
