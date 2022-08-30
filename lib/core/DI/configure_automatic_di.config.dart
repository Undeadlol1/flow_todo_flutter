// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_context_provider/build_context_provider.dart' as _i15;
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_analytics/firebase_analytics.dart' as _i43;
import 'package:firebase_auth/firebase_auth.dart' as _i48;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i34;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i53;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/analytics/data/traces/navigation_to_filter_page_trace.dart'
    as _i18;
import '../../features/authentification/domain/entities/use_cases/logout.dart'
    as _i47;
import '../../features/authentification/domain/entities/use_cases/sign_in_with_google.dart'
    as _i51;
import '../../features/authentification/presentation/cubit/authentification_cubit.dart'
    as _i3;
import '../../features/common/domain/use_cases/go_to_main_page.dart' as _i14;
import '../../features/common/services/get_todays_date.dart' as _i13;
import '../../features/common/services/snackbar_service.dart' as _i22;
import '../../features/common/services/unique_id_generator.dart' as _i29;
import '../../features/goals/data/create_goal_repository.dart' as _i4;
import '../../features/goals/data/get_goals_repository.dart' as _i9;
import '../../features/goals/data/update_goal_repository.dart' as _i30;
import '../../features/goals/domain/use_cases/create_goal.dart' as _i57;
import '../../features/goals/domain/use_cases/get_goals.dart' as _i38;
import '../../features/goals/domain/use_cases/make_step_forward_on_a_goal.dart'
    as _i49;
import '../../features/goals/presentation/cubit/goals_cubit.dart' as _i17;
import '../../features/leveling/domain/services/experience_to_reach_next_level_calculator.dart'
    as _i36;
import '../../features/leveling/domain/services/level_progress_percentage_calculator.dart'
    as _i45;
import '../../features/leveling/domain/services/level_up_animation.dart'
    as _i46;
import '../../features/leveling/domain/services/user_level_calculator.dart'
    as _i35;
import '../../features/leveling/domain/use_cases/reset_experience.dart' as _i50;
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart'
    as _i60;
import '../../features/streaks/domain/services/streak_days_in_a_row_calculator.dart'
    as _i24;
import '../../features/streaks/domain/use_cases/increment_daily_streak_action.dart'
    as _i44;
import '../../features/tasks/data/create_task_repository.dart' as _i6;
import '../../features/tasks/data/delete_task_repository.dart' as _i7;
import '../../features/tasks/data/get_task_worked_on_today_repository.dart'
    as _i12;
import '../../features/tasks/data/get_tasks_to_do_repository.dart' as _i11;
import '../../features/tasks/data/update_task_repository.dart' as _i31;
import '../../features/tasks/domain/actions/work_on_task_action.dart' as _i37;
import '../../features/tasks/domain/services/stale_task_detector.dart' as _i23;
import '../../features/tasks/domain/services/task_reward_calculator.dart'
    as _i26;
import '../../features/tasks/domain/use_cases/create_task.dart' as _i58;
import '../../features/tasks/domain/use_cases/get_tasks_to_do.dart' as _i40;
import '../../features/tasks/domain/use_cases/get_tasks_worked_on_today.dart'
    as _i41;
import '../../features/tasks/domain/use_cases/go_to_task_creation.dart' as _i16;
import '../../features/tasks/domain/use_cases/go_to_task_page.dart' as _i42;
import '../../features/tasks/domain/use_cases/make_step_forward_on_the_task.dart'
    as _i59;
import '../../features/tasks/domain/use_cases/reject_task.dart' as _i61;
import '../../features/tasks/domain/use_cases/toggle_task_selection.dart'
    as _i52;
import '../../features/tasks/domain/use_cases/update_task.dart' as _i54;
import '../../features/tasks/domain/use_cases/update_task_note.dart' as _i55;
import '../../features/tasks/presentation/cubit/filtered_tasks_cubit.dart'
    as _i8;
import '../../features/tasks/presentation/cubit/selected_tasks_cubit.dart'
    as _i21;
import '../../features/tasks/presentation/cubit/tags_cubit.dart' as _i25;
import '../../features/tasks/presentation/cubit/tasks_cubit.dart' as _i27;
import '../../features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart'
    as _i28;
import '../../features/users/data/get_profile_repository.dart' as _i10;
import '../../features/users/data/upsert_profile_repository.dart' as _i32;
import '../../features/users/domain/use_cases/add_points_to_viewer.dart'
    as _i56;
import '../../features/users/domain/use_cases/get_profile.dart' as _i39;
import '../../features/users/presentation/cubit/profile_cubit.dart' as _i19;
import '../remote_config/cubit/remote_config_cubit.dart' as _i20;
import '../services/use_case_exception_handler.dart'
    as _i33; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.AuthentificationCubit>(_i3.AuthentificationCubit());
  gh.lazySingleton<_i4.CreateGoalRepository>(
      () => _i4.CreateGoalRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i6.CreateTaskRepository>(
      () => _i6.CreateTaskRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i7.DeleteTaskRepository>(
      () => _i7.DeleteTaskRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i8.FilteredTasksCubit>(() => _i8.FilteredTasksCubit());
  gh.factory<_i9.GetGoalsRepository>(
      () => _i9.GetGoalsRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i10.GetProfileRepository>(
      _i10.GetProfileRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i11.GetTasksToDoRepository>(() =>
      _i11.GetTasksToDoRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i12.GetTasksWorkedOnTodayRepository>(
      _i12.GetTasksWorkedOnTodayRepository(
          firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i13.GetTodaysDate>(_i13.GetTodaysDate());
  gh.factory<_i14.GoToMainPage>(() =>
      _i14.GoToMainPage(contextProvider: get<_i15.BuildContextProvider>()));
  gh.factory<_i16.GoToTaskCreation>(() =>
      _i16.GoToTaskCreation(contextProvider: get<_i15.BuildContextProvider>()));
  gh.singleton<_i17.GoalsCubit>(_i17.GoalsCubit());
  gh.singleton<_i18.NavigationToFilterPageTrace>(
      _i18.NavigationToFilterPageTrace());
  gh.singleton<_i19.ProfileCubit>(_i19.ProfileCubit());
  gh.factory<_i20.RemoteConfigCubit>(() => _i20.RemoteConfigCubit());
  gh.singleton<_i21.SelectedTasksCubit>(_i21.SelectedTasksCubit());
  gh.factory<_i22.SnackbarService>(() => _i22.SnackbarService(
      buildContextProvider: get<_i15.BuildContextProvider>()));
  gh.lazySingleton<_i23.StaleTaskDetector>(() => _i23.StaleTaskDetector());
  gh.lazySingleton<_i24.StreakDaysInARowCalculator>(
      () => _i24.StreakDaysInARowCalculator());
  gh.singleton<_i25.TagsCubit>(_i25.TagsCubit());
  gh.factory<_i26.TaskRewardCalculator>(() => _i26.TaskRewardCalculator());
  gh.singleton<_i27.TasksCubit>(_i27.TasksCubit());
  gh.singleton<_i28.TasksWorkedOnTodayCubit>(_i28.TasksWorkedOnTodayCubit());
  gh.singleton<_i29.UniqueIdGenerator>(_i29.UniqueIdGenerator());
  gh.lazySingleton<_i30.UpdateGoalRepository>(
      () => _i30.UpdateGoalRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i31.UpdateTaskRepository>(
      () => _i31.UpdateTaskRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i32.UpsertProfileRepository>(() =>
      _i32.UpsertProfileRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i33.UseCaseExceptionHandler>(_i33.UseCaseExceptionHandler(
      snackbarService: get<_i22.SnackbarService>(),
      firebaseCrashlytics: get<_i34.FirebaseCrashlytics>()));
  gh.factory<_i35.UserLevelCalculator>(() => _i35.UserLevelCalculator(
      experienceToReachALevelCalculator:
          get<_i36.ExperienceToReachNextLevelCalculator>()));
  gh.factory<_i37.WorkOnTaskAction>(() => _i37.WorkOnTaskAction(
      tasksDoneTodayCubit: get<_i28.TasksWorkedOnTodayCubit>()));
  gh.singleton<_i38.GetGoals>(_i38.GetGoals(
      goalsCubit: get<_i17.GoalsCubit>(),
      getGoalsRepo: get<_i9.GetGoalsRepository>(),
      useCaseExceptionHandler: get<_i33.UseCaseExceptionHandler>()));
  gh.singleton<_i39.GetProfile>(_i39.GetProfile(
      profileCubit: get<_i19.ProfileCubit>(),
      getProfileRepository: get<_i10.GetProfileRepository>(),
      useCaseExceptionHandler: get<_i33.UseCaseExceptionHandler>()));
  gh.singleton<_i40.GetTasksToDo>(_i40.GetTasksToDo(
      getTasks: get<_i11.GetTasksToDoRepository>(),
      tasksCubit: get<_i27.TasksCubit>(),
      exceptionHandler: get<_i33.UseCaseExceptionHandler>()));
  gh.singleton<_i41.GetTasksWorkedOnToday>(_i41.GetTasksWorkedOnToday(
      tasksDoneTodayCubit: get<_i28.TasksWorkedOnTodayCubit>(),
      exceptionHandler: get<_i33.UseCaseExceptionHandler>(),
      getTasksDoneTodayRepository:
          get<_i12.GetTasksWorkedOnTodayRepository>()));
  gh.factory<_i42.GoToTaskPage>(() => _i42.GoToTaskPage(
      provideContext: get<_i15.BuildContextProvider>(),
      staleTaskDetector: get<_i23.StaleTaskDetector>(),
      firebaseAnalytics: get<_i43.FirebaseAnalytics>()));
  gh.lazySingleton<_i44.IncrementDailyStreakAction>(() =>
      _i44.IncrementDailyStreakAction(
          profileCubit: get<_i19.ProfileCubit>(),
          getTodaysDate: get<_i13.GetTodaysDate>(),
          tasksDoneTodayCubit: get<_i28.TasksWorkedOnTodayCubit>(),
          updateProfile: get<_i32.UpsertProfileRepository>()));
  gh.singleton<_i45.LevelProgressPercentageCalculator>(
      _i45.LevelProgressPercentageCalculator(
          userLevelCalculator: get<_i35.UserLevelCalculator>(),
          experienceToReachALevelCalculator:
              get<_i36.ExperienceToReachNextLevelCalculator>()));
  gh.factory<_i46.LevelUpAnimation>(() => _i46.LevelUpAnimation(
      userLevelCalculator: get<_i35.UserLevelCalculator>(),
      buildContextProvider: get<_i15.BuildContextProvider>()));
  gh.singleton<_i47.Logout>(_i47.Logout(
      tagsCubit: get<_i25.TagsCubit>(),
      tasksCubit: get<_i27.TasksCubit>(),
      profileCubit: get<_i19.ProfileCubit>(),
      firebaseAuth: get<_i48.FirebaseAuth>(),
      firebaseFirestore: get<_i5.FirebaseFirestore>(),
      tasksDoneTodayCubit: get<_i28.TasksWorkedOnTodayCubit>(),
      authentificationCubit: get<_i3.AuthentificationCubit>()));
  gh.lazySingleton<_i49.MakeStepForwardOnAGoal>(() =>
      _i49.MakeStepForwardOnAGoal(
          goalsCubit: get<_i17.GoalsCubit>(),
          profileCubit: get<_i19.ProfileCubit>(),
          updateGoalRepo: get<_i30.UpdateGoalRepository>(),
          updateProfileRepository: get<_i32.UpsertProfileRepository>()));
  gh.factory<_i50.ResetExperience>(() => _i50.ResetExperience(
      profileCubit: get<_i19.ProfileCubit>(),
      firebaseAnalytics: get<_i43.FirebaseAnalytics>(),
      useCaseExceptionHandler: get<_i33.UseCaseExceptionHandler>(),
      upsertProfileRepository: get<_i32.UpsertProfileRepository>()));
  gh.factory<_i51.SignInWithGoogle>(() => _i51.SignInWithGoogle(
      profileCubit: get<_i19.ProfileCubit>(),
      firebaseAuth: get<_i48.FirebaseAuth>(),
      firebaseAnalytics: get<_i43.FirebaseAnalytics>(),
      uniqueIdGenerator: get<_i29.UniqueIdGenerator>(),
      firebaseCrashlytics: get<_i34.FirebaseCrashlytics>(),
      getProfileRepository: get<_i10.GetProfileRepository>(),
      upsertProfileRepository: get<_i32.UpsertProfileRepository>(),
      useCaseExceptionHandler: get<_i33.UseCaseExceptionHandler>()));
  gh.factory<_i52.ToggleTaskSelection>(() => _i52.ToggleTaskSelection(
      tasksCubit: get<_i27.TasksCubit>(),
      firebaseAnalytics: get<_i43.FirebaseAnalytics>(),
      firebaseRemoteConfig: get<_i53.FirebaseRemoteConfig>(),
      updateTaskRepository: get<_i31.UpdateTaskRepository>()));
  gh.singleton<_i54.UpdateTask>(_i54.UpdateTask(
      tasksCubit: get<_i27.TasksCubit>(),
      updateTaskRepository: get<_i31.UpdateTaskRepository>()));
  gh.singleton<_i55.UpdateTaskNote>(_i55.UpdateTaskNote(
      tasksCubit: get<_i27.TasksCubit>(),
      updateTaskRepository: get<_i31.UpdateTaskRepository>()));
  gh.factory<_i56.AddPointsToViewer>(() => _i56.AddPointsToViewer(
      profileCubit: get<_i19.ProfileCubit>(),
      levelUpAnimation: get<_i46.LevelUpAnimation>(),
      userLevelCalculator: get<_i35.UserLevelCalculator>(),
      updateProfileRepository: get<_i32.UpsertProfileRepository>()));
  gh.singleton<_i57.CreateGoal>(_i57.CreateGoal(
      goalsCubit: get<_i17.GoalsCubit>(),
      profileCubit: get<_i19.ProfileCubit>(),
      getTodaysDate: get<_i13.GetTodaysDate>(),
      createGoalRepo: get<_i4.CreateGoalRepository>(),
      addPointsToUser: get<_i56.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i29.UniqueIdGenerator>(),
      useCaseExceptionHandler: get<_i33.UseCaseExceptionHandler>()));
  gh.lazySingleton<_i58.CreateTask>(() => _i58.CreateTask(
      tasksCubit: get<_i27.TasksCubit>(),
      profileCubit: get<_i19.ProfileCubit>(),
      getTodaysDate: get<_i13.GetTodaysDate>(),
      addPointsToUser: get<_i56.AddPointsToViewer>(),
      firebaseAnalytics: get<_i43.FirebaseAnalytics>(),
      uniqueIdGenerator: get<_i29.UniqueIdGenerator>(),
      createTaskRepository: get<_i6.CreateTaskRepository>()));
  gh.singleton<_i59.MakeStepForwardOnTheTask>(_i59.MakeStepForwardOnTheTask(
      tasksCubit: get<_i27.TasksCubit>(),
      updateTask: get<_i31.UpdateTaskRepository>(),
      profileCubit: get<_i19.ProfileCubit>(),
      goToMainPage: get<_i14.GoToMainPage>(),
      goToTaskPage: get<_i42.GoToTaskPage>(),
      getTodaysDate: get<_i13.GetTodaysDate>(),
      updateProfile: get<_i32.UpsertProfileRepository>(),
      snackbarService: get<_i22.SnackbarService>(),
      rewardCalculator: get<_i26.TaskRewardCalculator>(),
      workOnTaskAction: get<_i37.WorkOnTaskAction>(),
      addPointsToViewer: get<_i56.AddPointsToViewer>(),
      firebaseAnalytics: get<_i43.FirebaseAnalytics>(),
      tasksDoneTodayCubit: get<_i28.TasksWorkedOnTodayCubit>(),
      incrementDailyStreak: get<_i44.IncrementDailyStreakAction>(),
      useCaseExceptionHandler: get<_i33.UseCaseExceptionHandler>(),
      nextRepetitionCalculator: get<_i60.NextRepetitionCalculator>()));
  gh.singleton<_i61.RejectTask>(_i61.RejectTask(
      tasksCubit: get<_i27.TasksCubit>(),
      goToMainPage: get<_i14.GoToMainPage>(),
      goToTaskPage: get<_i42.GoToTaskPage>(),
      snackbarService: get<_i22.SnackbarService>(),
      addPointsToUser: get<_i56.AddPointsToViewer>(),
      firebaseAnalytics: get<_i43.FirebaseAnalytics>(),
      deleteTaskRepository: get<_i7.DeleteTaskRepository>()));
  return get;
}
