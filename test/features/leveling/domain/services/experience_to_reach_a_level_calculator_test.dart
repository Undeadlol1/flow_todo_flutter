import 'package:flow_todo_flutter_2022/features/leveling/domain/entities/leveling_config.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/experience_to_reach_a_level_calculator.dart';
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

        final result = ExperienceToReachALevelCalculator(levelingConfig: config)(5);

        expect(result, 100);
      },
    );
  });
}
