import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/toggle_tags_selection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/mocks/mock_use_case_exception_handler.dart';
import '../../../../test_utilities/mocks/setupers/setup_filter_by_tags_cubit_mock.dart';

void main() {
  final useCaseExceptionHandler = MockUseCaseExceptionHandler();

  setUpAll(() {
    registerFallbackValue(Exception());
    registerFallbackValue(StackTrace.current);

    when(() => useCaseExceptionHandler(any(), any())).thenAnswer((_) async {});
  });

  ToggleTagsSelection getUseCase() => ToggleTagsSelection(
        tagsCubit: setupFilterByTagsCubitMock(),
        useCaseExceptionHandler: useCaseExceptionHandler,
      );

  group('GIVEN ToggleTagsSelection', () {
    test('WHEN called THEN doesn\'t throw an error', () async {
      await getUseCase().call('tag');

      verifyNever(() => useCaseExceptionHandler(any(), any()));
    });
  });
}
