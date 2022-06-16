import 'package:flow_todo_flutter_2022/features/leveling/domain/entities/user_level.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/user_level_calculator.dart';
import 'package:mocktail/mocktail.dart';

class FakeUserLevelCalculator extends Fake implements UserLevelCalculator {
  @override
  call(int value) {
    return UserLevel(
      value: value,
      totalExperienceToNextLevel: value,
      totalExperienceForCurrentLevel: value,
    );
  }
}
