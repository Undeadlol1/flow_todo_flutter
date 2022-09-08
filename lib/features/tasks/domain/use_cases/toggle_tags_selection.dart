import 'package:flow_todo_flutter_2022/core/services/use_case_exception_handler.dart';
import 'package:injectable/injectable.dart';

import '../../presentation/cubit/filter_by_tags_cubit.dart';

@injectable
class ToggleTagsSelection {
  final FilterByTagsCubit tagsCubit;
  final UseCaseExceptionHandler useCaseExceptionHandler;
  const ToggleTagsSelection({
    required this.tagsCubit,
    required this.useCaseExceptionHandler,
  });

  Future<void> call(String tag) async {
    try {
      final updatedTags = <String>{...tagsCubit.state.tags};

      updatedTags.contains(tag)
          ? updatedTags.remove(tag)
          : updatedTags.add(tag);

      tagsCubit.update(updatedTags);
    } catch (error, stack) {
      useCaseExceptionHandler(error, stack);
    }
  }
}
