// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_context_provider/build_context_provider.dart' as _i19;
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_analytics/firebase_analytics.dart' as _i50;
import 'package:firebase_auth/firebase_auth.dart' as _i55;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i37;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i45;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/analytics/data/traces/navigation_to_filter_page_trace.dart'
    as _i21;
import '../../features/authentification/domain/entities/use_cases/logout.dart'
    as _i54;
import '../../features/authentification/domain/entities/use_cases/sign_in_with_google.dart'
    as _i58;
import '../../features/authentification/presentation/cubit/authentification_cubit.dart'
    as _i4;
import '../../features/common/domain/use_cases/go_to_main_page.dart' as _i18;
import '../../features/common/services/get_todays_date.dart' as _i17;
import '../../features/common/services/snackbar_service.dart' as _i24;
import '../../features/common/services/unique_id_generator.dart' as _i31;
import '../../features/goals/data/create_goal_repository.dart' as _i5;
import '../../features/goals/data/get_goals_repository.dart' as _i13;
import '../../features/goals/data/update_goal_repository.dart' as _i32;
import '../../features/goals/domain/use_cases/create_goal.dart' as _i63;
import '../../features/goals/domain/use_cases/get_goals.dart' as _i42;
import '../../features/goals/domain/use_cases/make_step_forward_on_a_goal.dart'
    as _i56;
import '../../features/goals/presentation/cubit/goals_cubit.dart' as _i20;
import '../../features/leveling/domain/services/experience_to_reach_next_level_calculator.dart'
    as _i39;
import '../../features/leveling/domain/services/level_progress_percentage_calculator.dart'
    as _i52;
import '../../features/leveling/domain/services/level_up_animation.dart'
    as _i53;
import '../../features/leveling/domain/services/user_level_calculator.dart'
    as _i38;
import '../../features/leveling/domain/use_cases/reset_experience.dart' as _i57;
import '../../features/quests/data/create_quest_repository.dart' as _i7;
import '../../features/quests/data/delete_quest_repository.dart' as _i9;
import '../../features/quests/data/get_active_quests_repository.dart' as _i12;
import '../../features/quests/data/update_quest_repository.dart' as _i33;
import '../../features/quests/domain/use_cases/get_active_quests.dart' as _i41;
import '../../features/quests/presentation/cubits/active_quests_cubit.dart'
    as _i3;
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart'
    as _i66;
import '../../features/streaks/domain/services/streak_days_in_a_row_calculator.dart'
    as _i26;
import '../../features/streaks/domain/use_cases/increment_daily_streak_action.dart'
    as _i51;
import '../../features/tasks/data/create_task_repository.dart' as _i8;
import '../../features/tasks/data/delete_task_repository.dart' as _i10;
import '../../features/tasks/data/get_task_worked_on_today_repository.dart'
    as _i16;
import '../../features/tasks/data/get_tasks_to_do_repository.dart' as _i15;
import '../../features/tasks/data/update_task_repository.dart' as _i34;
import '../../features/tasks/domain/actions/work_on_task_action.dart' as _i40;
import '../../features/tasks/domain/services/stale_task_detector.dart' as _i25;
import '../../features/tasks/domain/services/task_reward_calculator.dart'
    as _i28;
import '../../features/tasks/domain/use_cases/create_task.dart' as _i64;
import '../../features/tasks/domain/use_cases/get_tasks_to_do.dart' as _i46;
import '../../features/tasks/domain/use_cases/get_tasks_worked_on_today.dart'
    as _i47;
import '../../features/tasks/domain/use_cases/go_to_task_creation.dart' as _i48;
import '../../features/tasks/domain/use_cases/go_to_task_page.dart' as _i49;
import '../../features/tasks/domain/use_cases/make_step_forward_on_the_task.dart'
    as _i65;
import '../../features/tasks/domain/use_cases/reject_task.dart' as _i67;
import '../../features/tasks/domain/use_cases/toggle_task_selection.dart'
    as _i59;
import '../../features/tasks/domain/use_cases/update_task.dart' as _i60;
import '../../features/tasks/domain/use_cases/update_task_note.dart' as _i61;
import '../../features/tasks/presentation/cubit/filtered_tasks_cubit.dart'
    as _i11;
import '../../features/tasks/presentation/cubit/tags_cubit.dart' as _i27;
import '../../features/tasks/presentation/cubit/tasks_cubit.dart' as _i29;
import '../../features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart'
    as _i30;
import '../../features/users/data/get_profile_repository.dart' as _i14;
import '../../features/users/data/upsert_profile_repository.dart' as _i35;
import '../../features/users/domain/use_cases/add_points_to_viewer.dart'
    as _i62;
import '../../features/users/domain/use_cases/get_profile.dart' as _i43;
import '../../features/users/presentation/cubit/profile_cubit.dart' as _i22;
import '../remote_config/cubit/remote_config_cubit.dart' as _i23;
import '../remote_config/domain/use_cases/get_remote_config.dart' as _i44;
import '../services/use_case_exception_handler.dart'
    as _i36; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.ActiveQuestsCubit>(_i3.ActiveQuestsCubit());
  gh.singleton<_i4.AuthentificationCubit>(_i4.AuthentificationCubit());
  gh.lazySingleton<_i5.CreateGoalRepository>(
      () => _i5.CreateGoalRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i7.CreateQuestRepository>(
      () => _i7.CreateQuestRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i8.CreateTaskRepository>(
      () => _i8.CreateTaskRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i9.DeleteQuestRepository>(
      () => _i9.DeleteQuestRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i10.DeleteTaskRepository>(
      () => _i10.DeleteTaskRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i11.FilteredTasksCubit>(() => _i11.FilteredTasksCubit());
  gh.factory<_i12.GetActiveQuestsRepository>(() =>
      _i12.GetActiveQuestsRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i13.GetGoalsRepository>(
      () => _i13.GetGoalsRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.singleton<_i14.GetProfileRepository>(
      _i14.GetProfileRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i15.GetTasksToDoRepository>(() =>
      _i15.GetTasksToDoRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.singleton<_i16.GetTasksWorkedOnTodayRepository>(
      _i16.GetTasksWorkedOnTodayRepository(
          firestore: get<_i6.FirebaseFirestore>()));
  gh.singleton<_i17.GetTodaysDate>(_i17.GetTodaysDate());
  gh.factory<_i18.GoToMainPage>(() =>
      _i18.GoToMainPage(contextProvider: get<_i19.BuildContextProvider>()));
  gh.singleton<_i20.GoalsCubit>(_i20.GoalsCubit());
  gh.singleton<_i21.NavigationToFilterPageTrace>(
      _i21.NavigationToFilterPageTrace());
  gh.singleton<_i22.ProfileCubit>(_i22.ProfileCubit());
  gh.singleton<_i23.RemoteConfigCubit>(_i23.RemoteConfigCubit());
  gh.factory<_i24.SnackbarService>(() => _i24.SnackbarService(
      buildContextProvider: get<_i19.BuildContextProvider>()));
  gh.lazySingleton<_i25.StaleTaskDetector>(() => _i25.StaleTaskDetector());
  gh.lazySingleton<_i26.StreakDaysInARowCalculator>(
      () => _i26.StreakDaysInARowCalculator());
  gh.singleton<_i27.TagsCubit>(_i27.TagsCubit());
  gh.factory<_i28.TaskRewardCalculator>(() => _i28.TaskRewardCalculator());
  gh.singleton<_i29.TasksCubit>(_i29.TasksCubit());
  gh.singleton<_i30.TasksWorkedOnTodayCubit>(_i30.TasksWorkedOnTodayCubit());
  gh.singleton<_i31.UniqueIdGenerator>(_i31.UniqueIdGenerator());
  gh.lazySingleton<_i32.UpdateGoalRepository>(
      () => _i32.UpdateGoalRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i33.UpdateQuestRepository>(() =>
      _i33.UpdateQuestRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i34.UpdateTaskRepository>(
      () => _i34.UpdateTaskRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i35.UpsertProfileRepository>(() =>
      _i35.UpsertProfileRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.singleton<_i36.UseCaseExceptionHandler>(_i36.UseCaseExceptionHandler(
      snackbarService: get<_i24.SnackbarService>(),
      firebaseCrashlytics: get<_i37.FirebaseCrashlytics>()));
  gh.factory<_i38.UserLevelCalculator>(() => _i38.UserLevelCalculator(
      experienceToReachALevelCalculator:
          get<_i39.ExperienceToReachNextLevelCalculator>()));
  gh.factory<_i40.WorkOnTaskAction>(() => _i40.WorkOnTaskAction(
      tasksDoneTodayCubit: get<_i30.TasksWorkedOnTodayCubit>()));
  gh.factory<_i41.GetActiveQuests>(() => _i41.GetActiveQuests(
      getQuests: get<_i12.GetActiveQuestsRepository>(),
      uniqueIdGenerator: get<_i31.UniqueIdGenerator>(),
      activeQuestsCubit: get<_i3.ActiveQuestsCubit>(),
      remoteConfigCubit: get<_i23.RemoteConfigCubit>(),
      createQuestRepository: get<_i7.CreateQuestRepository>()));
  gh.singleton<_i42.GetGoals>(_i42.GetGoals(
      goalsCubit: get<_i20.GoalsCubit>(),
      getGoalsRepo: get<_i13.GetGoalsRepository>(),
      useCaseExceptionHandler: get<_i36.UseCaseExceptionHandler>()));
  gh.singleton<_i43.GetProfile>(_i43.GetProfile(
      profileCubit: get<_i22.ProfileCubit>(),
      getProfileRepository: get<_i14.GetProfileRepository>(),
      useCaseExceptionHandler: get<_i36.UseCaseExceptionHandler>()));
  gh.factory<_i44.GetRemoteConfig>(() => _i44.GetRemoteConfig(
      remoteConfigCubit: get<_i23.RemoteConfigCubit>(),
      firebaseRemoteConfig: get<_i45.FirebaseRemoteConfig>(),
      useCaseExceptionHandler: get<_i36.UseCaseExceptionHandler>()));
  gh.singleton<_i46.GetTasksToDo>(_i46.GetTasksToDo(
      getTasks: get<_i15.GetTasksToDoRepository>(),
      tasksCubit: get<_i29.TasksCubit>(),
      exceptionHandler: get<_i36.UseCaseExceptionHandler>()));
  gh.singleton<_i47.GetTasksWorkedOnToday>(_i47.GetTasksWorkedOnToday(
      tasksDoneTodayCubit: get<_i30.TasksWorkedOnTodayCubit>(),
      exceptionHandler: get<_i36.UseCaseExceptionHandler>(),
      getTasksDoneTodayRepository:
          get<_i16.GetTasksWorkedOnTodayRepository>()));
  gh.factory<_i48.GoToTaskCreation>(() => _i48.GoToTaskCreation(
      contextProvider: get<_i19.BuildContextProvider>(),
      remoteConfigCubit: get<_i23.RemoteConfigCubit>()));
  gh.factory<_i49.GoToTaskPage>(() => _i49.GoToTaskPage(
      provideContext: get<_i19.BuildContextProvider>(),
      staleTaskDetector: get<_i25.StaleTaskDetector>(),
      firebaseAnalytics: get<_i50.FirebaseAnalytics>()));
  gh.lazySingleton<_i51.IncrementDailyStreakAction>(() =>
      _i51.IncrementDailyStreakAction(
          profileCubit: get<_i22.ProfileCubit>(),
          getTodaysDate: get<_i17.GetTodaysDate>(),
          tasksDoneTodayCubit: get<_i30.TasksWorkedOnTodayCubit>(),
          updateProfile: get<_i35.UpsertProfileRepository>()));
  gh.singleton<_i52.LevelProgressPercentageCalculator>(
      _i52.LevelProgressPercentageCalculator(
          userLevelCalculator: get<_i38.UserLevelCalculator>(),
          experienceToReachALevelCalculator:
              get<_i39.ExperienceToReachNextLevelCalculator>()));
  gh.factory<_i53.LevelUpAnimation>(() => _i53.LevelUpAnimation(
      userLevelCalculator: get<_i38.UserLevelCalculator>(),
      buildContextProvider: get<_i19.BuildContextProvider>()));
  gh.singleton<_i54.Logout>(_i54.Logout(
      tagsCubit: get<_i27.TagsCubit>(),
      tasksCubit: get<_i29.TasksCubit>(),
      profileCubit: get<_i22.ProfileCubit>(),
      firebaseAuth: get<_i55.FirebaseAuth>(),
      remoteConfigCubit: get<_i23.RemoteConfigCubit>(),
      firebaseFirestore: get<_i6.FirebaseFirestore>(),
      tasksDoneTodayCubit: get<_i30.TasksWorkedOnTodayCubit>(),
      authentificationCubit: get<_i4.AuthentificationCubit>()));
  gh.lazySingleton<_i56.MakeStepForwardOnAGoal>(() =>
      _i56.MakeStepForwardOnAGoal(
          goalsCubit: get<_i20.GoalsCubit>(),
          profileCubit: get<_i22.ProfileCubit>(),
          updateGoalRepo: get<_i32.UpdateGoalRepository>(),
          updateProfileRepository: get<_i35.UpsertProfileRepository>()));
  gh.factory<_i57.ResetExperience>(() => _i57.ResetExperience(
      profileCubit: get<_i22.ProfileCubit>(),
      firebaseAnalytics: get<_i50.FirebaseAnalytics>(),
      useCaseExceptionHandler: get<_i36.UseCaseExceptionHandler>(),
      upsertProfileRepository: get<_i35.UpsertProfileRepository>()));
  gh.factory<_i58.SignInWithGoogle>(() => _i58.SignInWithGoogle(
      profileCubit: get<_i22.ProfileCubit>(),
      firebaseAuth: get<_i55.FirebaseAuth>(),
      firebaseAnalytics: get<_i50.FirebaseAnalytics>(),
      uniqueIdGenerator: get<_i31.UniqueIdGenerator>(),
      firebaseCrashlytics: get<_i37.FirebaseCrashlytics>(),
      getProfileRepository: get<_i14.GetProfileRepository>(),
      upsertProfileRepository: get<_i35.UpsertProfileRepository>(),
      useCaseExceptionHandler: get<_i36.UseCaseExceptionHandler>()));
  gh.factory<_i59.ToggleTaskSelection>(() => _i59.ToggleTaskSelection(
      tasksCubit: get<_i29.TasksCubit>(),
      firebaseAnalytics: get<_i50.FirebaseAnalytics>(),
      remoteConfigCubit: get<_i23.RemoteConfigCubit>(),
      updateTaskRepository: get<_i34.UpdateTaskRepository>()));
  gh.singleton<_i60.UpdateTask>(_i60.UpdateTask(
      tasksCubit: get<_i29.TasksCubit>(),
      updateTaskRepository: get<_i34.UpdateTaskRepository>()));
  gh.singleton<_i61.UpdateTaskNote>(_i61.UpdateTaskNote(
      tasksCubit: get<_i29.TasksCubit>(),
      updateTaskRepository: get<_i34.UpdateTaskRepository>()));
  gh.factory<_i62.AddPointsToViewer>(() => _i62.AddPointsToViewer(
      profileCubit: get<_i22.ProfileCubit>(),
      levelUpAnimation: get<_i53.LevelUpAnimation>(),
      userLevelCalculator: get<_i38.UserLevelCalculator>(),
      updateProfileRepository: get<_i35.UpsertProfileRepository>()));
  gh.singleton<_i63.CreateGoal>(_i63.CreateGoal(
      goalsCubit: get<_i20.GoalsCubit>(),
      profileCubit: get<_i22.ProfileCubit>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      createGoalRepo: get<_i5.CreateGoalRepository>(),
      addPointsToUser: get<_i62.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i31.UniqueIdGenerator>(),
      useCaseExceptionHandler: get<_i36.UseCaseExceptionHandler>()));
  gh.lazySingleton<_i64.CreateTask>(() => _i64.CreateTask(
      tasksCubit: get<_i29.TasksCubit>(),
      profileCubit: get<_i22.ProfileCubit>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      addPointsToUser: get<_i62.AddPointsToViewer>(),
      firebaseAnalytics: get<_i50.FirebaseAnalytics>(),
      uniqueIdGenerator: get<_i31.UniqueIdGenerator>(),
      createTaskRepository: get<_i8.CreateTaskRepository>()));
  gh.singleton<_i65.MakeStepForwardOnTheTask>(_i65.MakeStepForwardOnTheTask(
      tasksCubit: get<_i29.TasksCubit>(),
      updateTask: get<_i34.UpdateTaskRepository>(),
      profileCubit: get<_i22.ProfileCubit>(),
      goToMainPage: get<_i18.GoToMainPage>(),
      goToTaskPage: get<_i49.GoToTaskPage>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      updateProfile: get<_i35.UpsertProfileRepository>(),
      snackbarService: get<_i24.SnackbarService>(),
      rewardCalculator: get<_i28.TaskRewardCalculator>(),
      workOnTaskAction: get<_i40.WorkOnTaskAction>(),
      addPointsToViewer: get<_i62.AddPointsToViewer>(),
      firebaseAnalytics: get<_i50.FirebaseAnalytics>(),
      tasksDoneTodayCubit: get<_i30.TasksWorkedOnTodayCubit>(),
      incrementDailyStreak: get<_i51.IncrementDailyStreakAction>(),
      useCaseExceptionHandler: get<_i36.UseCaseExceptionHandler>(),
      nextRepetitionCalculator: get<_i66.NextRepetitionCalculator>()));
  gh.singleton<_i67.RejectTask>(_i67.RejectTask(
      tasksCubit: get<_i29.TasksCubit>(),
      goToMainPage: get<_i18.GoToMainPage>(),
      goToTaskPage: get<_i49.GoToTaskPage>(),
      snackbarService: get<_i24.SnackbarService>(),
      addPointsToUser: get<_i62.AddPointsToViewer>(),
      firebaseAnalytics: get<_i50.FirebaseAnalytics>(),
      deleteTaskRepository: get<_i10.DeleteTaskRepository>()));
  return get;
}
