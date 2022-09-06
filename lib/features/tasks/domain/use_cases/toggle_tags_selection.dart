import 'package:flow_todo_flutter_2022/core/services/use_case_exception_handler.dart';
import 'package:injectable/injectable.dart';

import '../../presentation/cubit/tags_cubit.dart';

@injectable
class ToggleTagsSelection {
  final TagsCubit tagsCubit;
  final UseCaseExceptionHandler useCaseExceptionHandler;
  const ToggleTagsSelection({
    required this.tagsCubit,
    required this.useCaseExceptionHandler,
  });

  Future<void> call(String tag) async {
    try {
      final tagsState = tagsCubit.state;

      tagsState.tags.contains(tag)
          ? tagsState.tags.remove(tag)
          : tagsState.tags.add(tag);

      tagsCubit.update(tagsState.tags);
    } catch (error, stack) {
      useCaseExceptionHandler(error, stack);
    }
  }
}
