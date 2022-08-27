import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../analytics/data/traces/navigation_to_filter_page_trace.dart';
import '../../../common/presentation/page_layout.dart';
import '../widgets/tasks_list.dart';

class FilterTasksPage extends StatefulWidget {
  static const pathName = '/filter';

  const FilterTasksPage({Key? key}) : super(key: key);

  @override
  State<FilterTasksPage> createState() => _FilterTasksPageState();
}

class _FilterTasksPageState extends State<FilterTasksPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await GetIt.I<NavigationToFilterPageTrace>().stop();
    });
  }

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
                  TasksList(
                    shouldIgnoreStaleCondition: true,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
