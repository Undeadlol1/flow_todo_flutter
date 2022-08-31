// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_context_provider/build_context_provider.dart' as _i19;
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_analytics/firebase_analytics.dart' as _i51;
import 'package:firebase_auth/firebase_auth.dart' as _i56;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i39;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i47;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/analytics/data/traces/navigation_to_filter_page_trace.dart'
    as _i22;
import '../../features/authentification/domain/entities/use_cases/logout.dart'
    as _i55;
import '../../features/authentification/domain/entities/use_cases/sign_in_with_google.dart'
    as _i59;
import '../../features/authentification/presentation/cubit/authentification_cubit.dart'
    as _i4;
import '../../features/common/domain/use_cases/go_to_main_page.dart' as _i18;
import '../../features/common/services/get_todays_date.dart' as _i17;
import '../../features/common/services/snackbar_service.dart' as _i26;
import '../../features/common/services/unique_id_generator.dart' as _i33;
import '../../features/goals/data/create_goal_repository.dart' as _i5;
import '../../features/goals/data/get_goals_repository.dart' as _i13;
import '../../features/goals/data/update_goal_repository.dart' as _i34;
import '../../features/goals/domain/use_cases/create_goal.dart' as _i64;
import '../../features/goals/domain/use_cases/get_goals.dart' as _i44;
import '../../features/goals/domain/use_cases/make_step_forward_on_a_goal.dart'
    as _i57;
import '../../features/goals/presentation/cubit/goals_cubit.dart' as _i21;
import '../../features/leveling/domain/services/experience_to_reach_next_level_calculator.dart'
    as _i41;
import '../../features/leveling/domain/services/level_progress_percentage_calculator.dart'
    as _i53;
import '../../features/leveling/domain/services/level_up_animation.dart'
    as _i54;
import '../../features/leveling/domain/services/user_level_calculator.dart'
    as _i40;
import '../../features/leveling/domain/use_cases/reset_experience.dart' as _i58;
import '../../features/quests/data/create_quest_repository.dart' as _i7;
import '../../features/quests/data/delete_quest_repository.dart' as _i9;
import '../../features/quests/data/get_active_quests_repository.dart' as _i12;
import '../../features/quests/data/update_quest_repository.dart' as _i35;
import '../../features/quests/domain/use_cases/get_active_quests.dart' as _i43;
import '../../features/quests/presentation/cubits/active_quests_cubit.dart'
    as _i3;
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart'
    as _i67;
import '../../features/streaks/domain/services/streak_days_in_a_row_calculator.dart'
    as _i28;
import '../../features/streaks/domain/use_cases/increment_daily_streak_action.dart'
    as _i52;
import '../../features/tasks/data/create_task_repository.dart' as _i8;
import '../../features/tasks/data/delete_task_repository.dart' as _i10;
import '../../features/tasks/data/get_task_worked_on_today_repository.dart'
    as _i16;
import '../../features/tasks/data/get_tasks_to_do_repository.dart' as _i15;
import '../../features/tasks/data/update_task_repository.dart' as _i36;
import '../../features/tasks/domain/actions/work_on_task_action.dart' as _i42;
import '../../features/tasks/domain/services/stale_task_detector.dart' as _i27;
import '../../features/tasks/domain/services/task_reward_calculator.dart'
    as _i30;
import '../../features/tasks/domain/use_cases/create_task.dart' as _i65;
import '../../features/tasks/domain/use_cases/get_tasks_to_do.dart' as _i48;
import '../../features/tasks/domain/use_cases/get_tasks_worked_on_today.dart'
    as _i49;
import '../../features/tasks/domain/use_cases/go_to_task_creation.dart' as _i20;
import '../../features/tasks/domain/use_cases/go_to_task_page.dart' as _i50;
import '../../features/tasks/domain/use_cases/make_step_forward_on_the_task.dart'
    as _i66;
import '../../features/tasks/domain/use_cases/reject_task.dart' as _i68;
import '../../features/tasks/domain/use_cases/toggle_task_selection.dart'
    as _i60;
import '../../features/tasks/domain/use_cases/update_task.dart' as _i61;
import '../../features/tasks/domain/use_cases/update_task_note.dart' as _i62;
import '../../features/tasks/presentation/cubit/filtered_tasks_cubit.dart'
    as _i11;
import '../../features/tasks/presentation/cubit/selected_tasks_cubit.dart'
    as _i25;
import '../../features/tasks/presentation/cubit/tags_cubit.dart' as _i29;
import '../../features/tasks/presentation/cubit/tasks_cubit.dart' as _i31;
import '../../features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart'
    as _i32;
import '../../features/users/data/get_profile_repository.dart' as _i14;
import '../../features/users/data/upsert_profile_repository.dart' as _i37;
import '../../features/users/domain/use_cases/add_points_to_viewer.dart'
    as _i63;
import '../../features/users/domain/use_cases/get_profile.dart' as _i45;
import '../../features/users/presentation/cubit/profile_cubit.dart' as _i23;
import '../remote_config/cubit/remote_config_cubit.dart' as _i24;
import '../remote_config/domain/use_cases/get_remote_config.dart' as _i46;
import '../services/use_case_exception_handler.dart'
    as _i38; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i20.GoToTaskCreation>(() =>
      _i20.GoToTaskCreation(contextProvider: get<_i19.BuildContextProvider>()));
  gh.singleton<_i21.GoalsCubit>(_i21.GoalsCubit());
  gh.singleton<_i22.NavigationToFilterPageTrace>(
      _i22.NavigationToFilterPageTrace());
  gh.singleton<_i23.ProfileCubit>(_i23.ProfileCubit());
  gh.singleton<_i24.RemoteConfigCubit>(_i24.RemoteConfigCubit());
  gh.singleton<_i25.SelectedTasksCubit>(_i25.SelectedTasksCubit());
  gh.factory<_i26.SnackbarService>(() => _i26.SnackbarService(
      buildContextProvider: get<_i19.BuildContextProvider>()));
  gh.lazySingleton<_i27.StaleTaskDetector>(() => _i27.StaleTaskDetector());
  gh.lazySingleton<_i28.StreakDaysInARowCalculator>(
      () => _i28.StreakDaysInARowCalculator());
  gh.singleton<_i29.TagsCubit>(_i29.TagsCubit());
  gh.factory<_i30.TaskRewardCalculator>(() => _i30.TaskRewardCalculator());
  gh.singleton<_i31.TasksCubit>(_i31.TasksCubit());
  gh.singleton<_i32.TasksWorkedOnTodayCubit>(_i32.TasksWorkedOnTodayCubit());
  gh.singleton<_i33.UniqueIdGenerator>(_i33.UniqueIdGenerator());
  gh.lazySingleton<_i34.UpdateGoalRepository>(
      () => _i34.UpdateGoalRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i35.UpdateQuestRepository>(() =>
      _i35.UpdateQuestRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i36.UpdateTaskRepository>(
      () => _i36.UpdateTaskRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i37.UpsertProfileRepository>(() =>
      _i37.UpsertProfileRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.singleton<_i38.UseCaseExceptionHandler>(_i38.UseCaseExceptionHandler(
      snackbarService: get<_i26.SnackbarService>(),
      firebaseCrashlytics: get<_i39.FirebaseCrashlytics>()));
  gh.factory<_i40.UserLevelCalculator>(() => _i40.UserLevelCalculator(
      experienceToReachALevelCalculator:
          get<_i41.ExperienceToReachNextLevelCalculator>()));
  gh.factory<_i42.WorkOnTaskAction>(() => _i42.WorkOnTaskAction(
      tasksDoneTodayCubit: get<_i32.TasksWorkedOnTodayCubit>()));
  gh.factory<_i43.GetActiveQuests>(() => _i43.GetActiveQuests(
      getQuests: get<_i12.GetActiveQuestsRepository>(),
      uniqueIdGenerator: get<_i33.UniqueIdGenerator>(),
      activeQuestsCubit: get<_i3.ActiveQuestsCubit>(),
      createQuestRepository: get<_i7.CreateQuestRepository>()));
  gh.singleton<_i44.GetGoals>(_i44.GetGoals(
      goalsCubit: get<_i21.GoalsCubit>(),
      getGoalsRepo: get<_i13.GetGoalsRepository>(),
      useCaseExceptionHandler: get<_i38.UseCaseExceptionHandler>()));
  gh.singleton<_i45.GetProfile>(_i45.GetProfile(
      profileCubit: get<_i23.ProfileCubit>(),
      getProfileRepository: get<_i14.GetProfileRepository>(),
      useCaseExceptionHandler: get<_i38.UseCaseExceptionHandler>()));
  gh.factory<_i46.GetRemoteConfig>(() => _i46.GetRemoteConfig(
      remoteConfigCubit: get<_i24.RemoteConfigCubit>(),
      firebaseRemoteConfig: get<_i47.FirebaseRemoteConfig>()));
  gh.singleton<_i48.GetTasksToDo>(_i48.GetTasksToDo(
      getTasks: get<_i15.GetTasksToDoRepository>(),
      tasksCubit: get<_i31.TasksCubit>(),
      exceptionHandler: get<_i38.UseCaseExceptionHandler>()));
  gh.singleton<_i49.GetTasksWorkedOnToday>(_i49.GetTasksWorkedOnToday(
      tasksDoneTodayCubit: get<_i32.TasksWorkedOnTodayCubit>(),
      exceptionHandler: get<_i38.UseCaseExceptionHandler>(),
      getTasksDoneTodayRepository:
          get<_i16.GetTasksWorkedOnTodayRepository>()));
  gh.factory<_i50.GoToTaskPage>(() => _i50.GoToTaskPage(
      provideContext: get<_i19.BuildContextProvider>(),
      staleTaskDetector: get<_i27.StaleTaskDetector>(),
      firebaseAnalytics: get<_i51.FirebaseAnalytics>()));
  gh.lazySingleton<_i52.IncrementDailyStreakAction>(() =>
      _i52.IncrementDailyStreakAction(
          profileCubit: get<_i23.ProfileCubit>(),
          getTodaysDate: get<_i17.GetTodaysDate>(),
          tasksDoneTodayCubit: get<_i32.TasksWorkedOnTodayCubit>(),
          updateProfile: get<_i37.UpsertProfileRepository>()));
  gh.singleton<_i53.LevelProgressPercentageCalculator>(
      _i53.LevelProgressPercentageCalculator(
          userLevelCalculator: get<_i40.UserLevelCalculator>(),
          experienceToReachALevelCalculator:
              get<_i41.ExperienceToReachNextLevelCalculator>()));
  gh.factory<_i54.LevelUpAnimation>(() => _i54.LevelUpAnimation(
      userLevelCalculator: get<_i40.UserLevelCalculator>(),
      buildContextProvider: get<_i19.BuildContextProvider>()));
  gh.singleton<_i55.Logout>(_i55.Logout(
      tagsCubit: get<_i29.TagsCubit>(),
      tasksCubit: get<_i31.TasksCubit>(),
      profileCubit: get<_i23.ProfileCubit>(),
      firebaseAuth: get<_i56.FirebaseAuth>(),
      remoteConfigCubit: get<_i24.RemoteConfigCubit>(),
      firebaseFirestore: get<_i6.FirebaseFirestore>(),
      tasksDoneTodayCubit: get<_i32.TasksWorkedOnTodayCubit>(),
      authentificationCubit: get<_i4.AuthentificationCubit>()));
  gh.lazySingleton<_i57.MakeStepForwardOnAGoal>(() =>
      _i57.MakeStepForwardOnAGoal(
          goalsCubit: get<_i21.GoalsCubit>(),
          profileCubit: get<_i23.ProfileCubit>(),
          updateGoalRepo: get<_i34.UpdateGoalRepository>(),
          updateProfileRepository: get<_i37.UpsertProfileRepository>()));
  gh.factory<_i58.ResetExperience>(() => _i58.ResetExperience(
      profileCubit: get<_i23.ProfileCubit>(),
      firebaseAnalytics: get<_i51.FirebaseAnalytics>(),
      useCaseExceptionHandler: get<_i38.UseCaseExceptionHandler>(),
      upsertProfileRepository: get<_i37.UpsertProfileRepository>()));
  gh.factory<_i59.SignInWithGoogle>(() => _i59.SignInWithGoogle(
      profileCubit: get<_i23.ProfileCubit>(),
      firebaseAuth: get<_i56.FirebaseAuth>(),
      firebaseAnalytics: get<_i51.FirebaseAnalytics>(),
      uniqueIdGenerator: get<_i33.UniqueIdGenerator>(),
      firebaseCrashlytics: get<_i39.FirebaseCrashlytics>(),
      getProfileRepository: get<_i14.GetProfileRepository>(),
      upsertProfileRepository: get<_i37.UpsertProfileRepository>(),
      useCaseExceptionHandler: get<_i38.UseCaseExceptionHandler>()));
  gh.factory<_i60.ToggleTaskSelection>(() => _i60.ToggleTaskSelection(
      tasksCubit: get<_i31.TasksCubit>(),
      firebaseAnalytics: get<_i51.FirebaseAnalytics>(),
      firebaseRemoteConfig: get<_i47.FirebaseRemoteConfig>(),
      updateTaskRepository: get<_i36.UpdateTaskRepository>()));
  gh.singleton<_i61.UpdateTask>(_i61.UpdateTask(
      tasksCubit: get<_i31.TasksCubit>(),
      updateTaskRepository: get<_i36.UpdateTaskRepository>()));
  gh.singleton<_i62.UpdateTaskNote>(_i62.UpdateTaskNote(
      tasksCubit: get<_i31.TasksCubit>(),
      updateTaskRepository: get<_i36.UpdateTaskRepository>()));
  gh.factory<_i63.AddPointsToViewer>(() => _i63.AddPointsToViewer(
      profileCubit: get<_i23.ProfileCubit>(),
      levelUpAnimation: get<_i54.LevelUpAnimation>(),
      userLevelCalculator: get<_i40.UserLevelCalculator>(),
      updateProfileRepository: get<_i37.UpsertProfileRepository>()));
  gh.singleton<_i64.CreateGoal>(_i64.CreateGoal(
      goalsCubit: get<_i21.GoalsCubit>(),
      profileCubit: get<_i23.ProfileCubit>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      createGoalRepo: get<_i5.CreateGoalRepository>(),
      addPointsToUser: get<_i63.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i33.UniqueIdGenerator>(),
      useCaseExceptionHandler: get<_i38.UseCaseExceptionHandler>()));
  gh.lazySingleton<_i65.CreateTask>(() => _i65.CreateTask(
      tasksCubit: get<_i31.TasksCubit>(),
      profileCubit: get<_i23.ProfileCubit>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      addPointsToUser: get<_i63.AddPointsToViewer>(),
      firebaseAnalytics: get<_i51.FirebaseAnalytics>(),
      uniqueIdGenerator: get<_i33.UniqueIdGenerator>(),
      createTaskRepository: get<_i8.CreateTaskRepository>()));
  gh.singleton<_i66.MakeStepForwardOnTheTask>(_i66.MakeStepForwardOnTheTask(
      tasksCubit: get<_i31.TasksCubit>(),
      updateTask: get<_i36.UpdateTaskRepository>(),
      profileCubit: get<_i23.ProfileCubit>(),
      goToMainPage: get<_i18.GoToMainPage>(),
      goToTaskPage: get<_i50.GoToTaskPage>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      updateProfile: get<_i37.UpsertProfileRepository>(),
      snackbarService: get<_i26.SnackbarService>(),
      rewardCalculator: get<_i30.TaskRewardCalculator>(),
      workOnTaskAction: get<_i42.WorkOnTaskAction>(),
      addPointsToViewer: get<_i63.AddPointsToViewer>(),
      firebaseAnalytics: get<_i51.FirebaseAnalytics>(),
      tasksDoneTodayCubit: get<_i32.TasksWorkedOnTodayCubit>(),
      incrementDailyStreak: get<_i52.IncrementDailyStreakAction>(),
      useCaseExceptionHandler: get<_i38.UseCaseExceptionHandler>(),
      nextRepetitionCalculator: get<_i67.NextRepetitionCalculator>()));
  gh.singleton<_i68.RejectTask>(_i68.RejectTask(
      tasksCubit: get<_i31.TasksCubit>(),
      goToMainPage: get<_i18.GoToMainPage>(),
      goToTaskPage: get<_i50.GoToTaskPage>(),
      snackbarService: get<_i26.SnackbarService>(),
      addPointsToUser: get<_i63.AddPointsToViewer>(),
      firebaseAnalytics: get<_i51.FirebaseAnalytics>(),
      deleteTaskRepository: get<_i10.DeleteTaskRepository>()));
  return get;
}
