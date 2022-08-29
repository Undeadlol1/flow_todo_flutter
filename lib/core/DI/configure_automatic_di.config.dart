// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_context_provider/build_context_provider.dart' as _i15;
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_analytics/firebase_analytics.dart' as _i41;
import 'package:firebase_auth/firebase_auth.dart' as _i46;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i32;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i51;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/analytics/data/traces/navigation_to_filter_page_trace.dart'
    as _i18;
import '../../features/authentification/domain/entities/use_cases/logout.dart'
    as _i45;
import '../../features/authentification/domain/entities/use_cases/sign_in_with_google.dart'
    as _i49;
import '../../features/authentification/presentation/cubit/authentification_cubit.dart'
    as _i3;
import '../../features/common/domain/use_cases/go_to_main_page.dart' as _i14;
import '../../features/common/services/get_todays_date.dart' as _i13;
import '../../features/common/services/snackbar_service.dart' as _i21;
import '../../features/common/services/unique_id_generator.dart' as _i27;
import '../../features/goals/data/create_goal_repository.dart' as _i4;
import '../../features/goals/data/get_goals_repository.dart' as _i9;
import '../../features/goals/data/update_goal_repository.dart' as _i28;
import '../../features/goals/domain/use_cases/create_goal.dart' as _i55;
import '../../features/goals/domain/use_cases/get_goals.dart' as _i36;
import '../../features/goals/domain/use_cases/make_step_forward_on_a_goal.dart'
    as _i47;
import '../../features/goals/presentation/cubit/goals_cubit.dart' as _i17;
import '../../features/leveling/domain/services/experience_to_reach_next_level_calculator.dart'
    as _i34;
import '../../features/leveling/domain/services/level_progress_percentage_calculator.dart'
    as _i43;
import '../../features/leveling/domain/services/level_up_animation.dart'
    as _i44;
import '../../features/leveling/domain/services/user_level_calculator.dart'
    as _i33;
import '../../features/leveling/domain/use_cases/reset_experience.dart' as _i48;
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart'
    as _i58;
import '../../features/streaks/domain/services/streak_days_in_a_row_calculator.dart'
    as _i23;
import '../../features/streaks/domain/use_cases/increment_daily_streak_action.dart'
    as _i42;
import '../../features/tasks/data/create_task_repository.dart' as _i6;
import '../../features/tasks/data/delete_task_repository.dart' as _i7;
import '../../features/tasks/data/get_task_worked_on_today_repository.dart'
    as _i12;
import '../../features/tasks/data/get_tasks_to_do_repository.dart' as _i11;
import '../../features/tasks/data/update_task_repository.dart' as _i29;
import '../../features/tasks/domain/actions/work_on_task_action.dart' as _i35;
import '../../features/tasks/domain/services/stale_task_detector.dart' as _i22;
import '../../features/tasks/domain/services/task_reward_calculator.dart'
    as _i24;
import '../../features/tasks/domain/use_cases/create_task.dart' as _i56;
import '../../features/tasks/domain/use_cases/get_tasks_to_do.dart' as _i38;
import '../../features/tasks/domain/use_cases/get_tasks_worked_on_today.dart'
    as _i39;
import '../../features/tasks/domain/use_cases/go_to_task_creation.dart' as _i16;
import '../../features/tasks/domain/use_cases/go_to_task_page.dart' as _i40;
import '../../features/tasks/domain/use_cases/make_step_forward_on_the_task.dart'
    as _i57;
import '../../features/tasks/domain/use_cases/reject_task.dart' as _i59;
import '../../features/tasks/domain/use_cases/toggle_task_selection.dart'
    as _i50;
import '../../features/tasks/domain/use_cases/update_task.dart' as _i52;
import '../../features/tasks/domain/use_cases/update_task_note.dart' as _i53;
import '../../features/tasks/presentation/cubit/filtered_tasks_cubit.dart'
    as _i8;
import '../../features/tasks/presentation/cubit/selected_tasks_cubit.dart'
    as _i20;
import '../../features/tasks/presentation/cubit/tasks_cubit.dart' as _i25;
import '../../features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart'
    as _i26;
import '../../features/users/data/get_profile_repository.dart' as _i10;
import '../../features/users/data/upsert_profile_repository.dart' as _i30;
import '../../features/users/domain/use_cases/add_points_to_viewer.dart'
    as _i54;
import '../../features/users/domain/use_cases/get_profile.dart' as _i37;
import '../../features/users/presentation/cubit/profile_cubit.dart' as _i19;
import '../services/use_case_exception_handler.dart'
    as _i31; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i20.SelectedTasksCubit>(_i20.SelectedTasksCubit());
  gh.factory<_i21.SnackbarService>(() => _i21.SnackbarService(
      buildContextProvider: get<_i15.BuildContextProvider>()));
  gh.lazySingleton<_i22.StaleTaskDetector>(() => _i22.StaleTaskDetector());
  gh.lazySingleton<_i23.StreakDaysInARowCalculator>(
      () => _i23.StreakDaysInARowCalculator());
  gh.factory<_i24.TaskRewardCalculator>(() => _i24.TaskRewardCalculator());
  gh.singleton<_i25.TasksCubit>(_i25.TasksCubit());
  gh.singleton<_i26.TasksWorkedOnTodayCubit>(_i26.TasksWorkedOnTodayCubit());
  gh.singleton<_i27.UniqueIdGenerator>(_i27.UniqueIdGenerator());
  gh.lazySingleton<_i28.UpdateGoalRepository>(
      () => _i28.UpdateGoalRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i29.UpdateTaskRepository>(
      () => _i29.UpdateTaskRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i30.UpsertProfileRepository>(() =>
      _i30.UpsertProfileRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i31.UseCaseExceptionHandler>(_i31.UseCaseExceptionHandler(
      snackbarService: get<_i21.SnackbarService>(),
      firebaseCrashlytics: get<_i32.FirebaseCrashlytics>()));
  gh.factory<_i33.UserLevelCalculator>(() => _i33.UserLevelCalculator(
      experienceToReachALevelCalculator:
          get<_i34.ExperienceToReachNextLevelCalculator>()));
  gh.factory<_i35.WorkOnTaskAction>(() => _i35.WorkOnTaskAction(
      tasksDoneTodayCubit: get<_i26.TasksWorkedOnTodayCubit>()));
  gh.singleton<_i36.GetGoals>(_i36.GetGoals(
      goalsCubit: get<_i17.GoalsCubit>(),
      getGoalsRepo: get<_i9.GetGoalsRepository>(),
      useCaseExceptionHandler: get<_i31.UseCaseExceptionHandler>()));
  gh.singleton<_i37.GetProfile>(_i37.GetProfile(
      profileCubit: get<_i19.ProfileCubit>(),
      getProfileRepository: get<_i10.GetProfileRepository>(),
      useCaseExceptionHandler: get<_i31.UseCaseExceptionHandler>()));
  gh.singleton<_i38.GetTasksToDo>(_i38.GetTasksToDo(
      getTasks: get<_i11.GetTasksToDoRepository>(),
      tasksCubit: get<_i25.TasksCubit>(),
      exceptionHandler: get<_i31.UseCaseExceptionHandler>()));
  gh.singleton<_i39.GetTasksWorkedOnToday>(_i39.GetTasksWorkedOnToday(
      tasksDoneTodayCubit: get<_i26.TasksWorkedOnTodayCubit>(),
      exceptionHandler: get<_i31.UseCaseExceptionHandler>(),
      getTasksDoneTodayRepository:
          get<_i12.GetTasksWorkedOnTodayRepository>()));
  gh.factory<_i40.GoToTaskPage>(() => _i40.GoToTaskPage(
      provideContext: get<_i15.BuildContextProvider>(),
      staleTaskDetector: get<_i22.StaleTaskDetector>(),
      firebaseAnalytics: get<_i41.FirebaseAnalytics>()));
  gh.lazySingleton<_i42.IncrementDailyStreakAction>(() =>
      _i42.IncrementDailyStreakAction(
          profileCubit: get<_i19.ProfileCubit>(),
          getTodaysDate: get<_i13.GetTodaysDate>(),
          tasksDoneTodayCubit: get<_i26.TasksWorkedOnTodayCubit>(),
          updateProfile: get<_i30.UpsertProfileRepository>()));
  gh.singleton<_i43.LevelProgressPercentageCalculator>(
      _i43.LevelProgressPercentageCalculator(
          userLevelCalculator: get<_i33.UserLevelCalculator>(),
          experienceToReachALevelCalculator:
              get<_i34.ExperienceToReachNextLevelCalculator>()));
  gh.factory<_i44.LevelUpAnimation>(() => _i44.LevelUpAnimation(
      userLevelCalculator: get<_i33.UserLevelCalculator>(),
      buildContextProvider: get<_i15.BuildContextProvider>()));
  gh.singleton<_i45.Logout>(_i45.Logout(
      tasksCubit: get<_i25.TasksCubit>(),
      profileCubit: get<_i19.ProfileCubit>(),
      firebaseAuth: get<_i46.FirebaseAuth>(),
      firebaseFirestore: get<_i5.FirebaseFirestore>(),
      tasksDoneTodayCubit: get<_i26.TasksWorkedOnTodayCubit>(),
      authentificationCubit: get<_i3.AuthentificationCubit>()));
  gh.lazySingleton<_i47.MakeStepForwardOnAGoal>(() =>
      _i47.MakeStepForwardOnAGoal(
          goalsCubit: get<_i17.GoalsCubit>(),
          profileCubit: get<_i19.ProfileCubit>(),
          updateGoalRepo: get<_i28.UpdateGoalRepository>(),
          updateProfileRepository: get<_i30.UpsertProfileRepository>()));
  gh.factory<_i48.ResetExperience>(() => _i48.ResetExperience(
      profileCubit: get<_i19.ProfileCubit>(),
      firebaseAnalytics: get<_i41.FirebaseAnalytics>(),
      useCaseExceptionHandler: get<_i31.UseCaseExceptionHandler>(),
      upsertProfileRepository: get<_i30.UpsertProfileRepository>()));
  gh.factory<_i49.SignInWithGoogle>(() => _i49.SignInWithGoogle(
      profileCubit: get<_i19.ProfileCubit>(),
      firebaseAuth: get<_i46.FirebaseAuth>(),
      firebaseAnalytics: get<_i41.FirebaseAnalytics>(),
      uniqueIdGenerator: get<_i27.UniqueIdGenerator>(),
      firebaseCrashlytics: get<_i32.FirebaseCrashlytics>(),
      getProfileRepository: get<_i10.GetProfileRepository>(),
      upsertProfileRepository: get<_i30.UpsertProfileRepository>(),
      useCaseExceptionHandler: get<_i31.UseCaseExceptionHandler>()));
  gh.factory<_i50.ToggleTaskSelection>(() => _i50.ToggleTaskSelection(
      tasksCubit: get<_i25.TasksCubit>(),
      firebaseAnalytics: get<_i41.FirebaseAnalytics>(),
      firebaseRemoteConfig: get<_i51.FirebaseRemoteConfig>(),
      updateTaskRepository: get<_i29.UpdateTaskRepository>()));
  gh.singleton<_i52.UpdateTask>(_i52.UpdateTask(
      tasksCubit: get<_i25.TasksCubit>(),
      updateTaskRepository: get<_i29.UpdateTaskRepository>()));
  gh.singleton<_i53.UpdateTaskNote>(_i53.UpdateTaskNote(
      tasksCubit: get<_i25.TasksCubit>(),
      updateTaskRepository: get<_i29.UpdateTaskRepository>()));
  gh.factory<_i54.AddPointsToViewer>(() => _i54.AddPointsToViewer(
      profileCubit: get<_i19.ProfileCubit>(),
      levelUpAnimation: get<_i44.LevelUpAnimation>(),
      userLevelCalculator: get<_i33.UserLevelCalculator>(),
      updateProfileRepository: get<_i30.UpsertProfileRepository>()));
  gh.singleton<_i55.CreateGoal>(_i55.CreateGoal(
      goalsCubit: get<_i17.GoalsCubit>(),
      profileCubit: get<_i19.ProfileCubit>(),
      getTodaysDate: get<_i13.GetTodaysDate>(),
      createGoalRepo: get<_i4.CreateGoalRepository>(),
      addPointsToUser: get<_i54.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i27.UniqueIdGenerator>(),
      useCaseExceptionHandler: get<_i31.UseCaseExceptionHandler>()));
  gh.lazySingleton<_i56.CreateTask>(() => _i56.CreateTask(
      tasksCubit: get<_i25.TasksCubit>(),
      profileCubit: get<_i19.ProfileCubit>(),
      getTodaysDate: get<_i13.GetTodaysDate>(),
      addPointsToUser: get<_i54.AddPointsToViewer>(),
      firebaseAnalytics: get<_i41.FirebaseAnalytics>(),
      uniqueIdGenerator: get<_i27.UniqueIdGenerator>(),
      createTaskRepository: get<_i6.CreateTaskRepository>()));
  gh.singleton<_i57.MakeStepForwardOnTheTask>(_i57.MakeStepForwardOnTheTask(
      tasksCubit: get<_i25.TasksCubit>(),
      updateTask: get<_i29.UpdateTaskRepository>(),
      profileCubit: get<_i19.ProfileCubit>(),
      goToMainPage: get<_i14.GoToMainPage>(),
      goToTaskPage: get<_i40.GoToTaskPage>(),
      getTodaysDate: get<_i13.GetTodaysDate>(),
      updateProfile: get<_i30.UpsertProfileRepository>(),
      snackbarService: get<_i21.SnackbarService>(),
      rewardCalculator: get<_i24.TaskRewardCalculator>(),
      workOnTaskAction: get<_i35.WorkOnTaskAction>(),
      addPointsToViewer: get<_i54.AddPointsToViewer>(),
      firebaseAnalytics: get<_i41.FirebaseAnalytics>(),
      tasksDoneTodayCubit: get<_i26.TasksWorkedOnTodayCubit>(),
      incrementDailyStreak: get<_i42.IncrementDailyStreakAction>(),
      useCaseExceptionHandler: get<_i31.UseCaseExceptionHandler>(),
      nextRepetitionCalculator: get<_i58.NextRepetitionCalculator>()));
  gh.singleton<_i59.RejectTask>(_i59.RejectTask(
      tasksCubit: get<_i25.TasksCubit>(),
      goToMainPage: get<_i14.GoToMainPage>(),
      goToTaskPage: get<_i40.GoToTaskPage>(),
      snackbarService: get<_i21.SnackbarService>(),
      addPointsToUser: get<_i54.AddPointsToViewer>(),
      firebaseAnalytics: get<_i41.FirebaseAnalytics>(),
      deleteTaskRepository: get<_i7.DeleteTaskRepository>()));
  return get;
}
