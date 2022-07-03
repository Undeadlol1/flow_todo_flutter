import 'package:flow_todo_flutter_2022/features/leveling/domain/entities/leveling_config.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/experience_to_reach_next_level_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GIVEN ExperienceToReachALevelCalculator', () {
    test(
      'WHEN config has exact number for a requested level '
      'THEN method returns that number',
      () {
        final config = LevelingConfig(
          experienceToLevelMapper: {5: 100},
          fallbackExperienceToLevelCalculator: (level) => level * 100000,
        );

        final result = ExperienceToReachNextLevelCalculator(levelingConfig: config)(5);

        expect(result, 100);
      },
    );

    test(
      'WHEN config doesn\'t have exact number for a requested level '
      'THEN method returns that number',
      () {
        final config = LevelingConfig(
          experienceToLevelMapper: {5: 100},
          fallbackExperienceToLevelCalculator: (level) => level * 1000,
        );

        final result = ExperienceToReachNextLevelCalculator(levelingConfig: config)(10);

        expect(result, 10 * 1000);
      },
    );
  });
}
