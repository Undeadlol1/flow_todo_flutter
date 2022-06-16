class LevelingConfig {
  final Map<int, int> experienceToLevelMapper;
  final int Function(int level) fallbackExperienceToLevelCalculator;
  const LevelingConfig({
    required this.experienceToLevelMapper,
    required this.fallbackExperienceToLevelCalculator,
  });
}
