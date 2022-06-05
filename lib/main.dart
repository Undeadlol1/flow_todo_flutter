import 'package:flutter/material.dart';

import 'features/pages/presentation/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Navigator(
        pages: const [
          MaterialPage(
            key: ValueKey('MainPage'),
            child: Scaffold(body: MainPage()),
          ),
        ],
        onPopPage: (route, result) => route.didPop(result),
      ),
    );
  }
}
