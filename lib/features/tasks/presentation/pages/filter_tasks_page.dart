import 'package:flutter/material.dart';

import '../../../common/presentation/page_layout.dart';
import '../widgets/tasks_list.dart';

class FilterTasksPage extends StatelessWidget {
  static const pathName = '/filter';

  const FilterTasksPage({Key? key}) : super(key: key);

  @override
  build(context) {
    return PageLayout(
      isAppBarHidden: false,
      isDrawerHidden: true,
      isNumbersAnimationSuspended: false,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  TasksList(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
