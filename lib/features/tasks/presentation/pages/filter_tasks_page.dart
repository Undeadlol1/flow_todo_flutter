import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/card_view.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_to_do_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../analytics/data/traces/navigation_to_filter_page_trace.dart';
import '../../../common/presentation/page_layout.dart';
import '../cubit/filtered_tasks_cubit.dart';
import '../widgets/filter_tasks_to_do.dart';
import '../widgets/tasks_list.dart';

class FilterTasksPage extends StatefulWidget {
  static const pathName = '/filter';
  const FilterTasksPage({Key? key}) : super(key: key);

  @override
  State<FilterTasksPage> createState() => _FilterTasksPageState();
}

class _FilterTasksPageState extends State<FilterTasksPage> {
  static final _filteredTasksCubit = GetIt.I<FilteredTasksCubit>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => GetIt.I<NavigationToFilterPageTrace>().stop(),
    );
  }

  @override
  void dispose() {
    _filteredTasksCubit.update([]);
    super.dispose();
  }

  @override
  build(context) {
    return PageLayout(
      isAppBarHidden: false,
      isNumbersAnimationSuspended: false,
      child: SingleChildScrollView(
        child: CardView(
          child: Column(
            children: [
              BlocBuilder<TasksToDoCubit, TasksToDoState>(
                builder: (context, tasksState) {
                  return Visibility(
                    visible: tasksState.tasks.length > 10,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: FilterTasksToDo(),
                    ),
                  );
                },
              ),
              const TasksList(
                shouldIgnoreTagsFiltering: true,
                shouldIgnoreStaleCondition: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
