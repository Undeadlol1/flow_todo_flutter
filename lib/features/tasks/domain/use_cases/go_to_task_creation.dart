import 'package:build_context_provider/build_context_provider.dart';
import 'package:flow_todo_flutter_2022/core/remote_config/cubit/remote_config_cubit.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../presentation/widgets/upsert_task_form.dart';

@injectable
class GoToTaskCreation {
  final RemoteConfigCubit remoteConfigCubit;
  final BuildContextProvider contextProvider;

  GoToTaskCreation({
    required this.contextProvider,
    required this.remoteConfigCubit,
  });

  void call() {
    contextProvider.call((context) {
      showModalBottomSheet(
        context: context,
        builder: (_) => const UpsertTaskForm(),
        isScrollControlled: remoteConfigCubit.state.areTagsEnabled,
      );
    });
  }
}
