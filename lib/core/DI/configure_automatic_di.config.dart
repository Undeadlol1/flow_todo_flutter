// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:build_context_provider/build_context_provider.dart' as _i15;
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i39;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/authentification/domain/entities/use_cases/logout.dart'
    as _i38;
import '../../features/authentification/presentation/cubit/authentification_cubit.dart'
    as _i3;
import '../../features/common/domain/use_cases/go_to_main_page.dart' as _i42;
import '../../features/common/services/get_todays_date.dart' as _i13;
import '../../features/common/services/snackbar_service.dart' as _i18;
import '../../features/common/services/unique_id_generator.dart' as _i22;
import '../../features/goals/data/create_goal_repository.dart' as _i4;
import '../../features/goals/data/get_goals_repository.dart' as _i9;
import '../../features/goals/data/update_goal_repository.dart' as _i23;
import '../../features/goals/domain/use_cases/create_goal.dart' as _i30;
import '../../features/goals/domain/use_cases/get_goals.dart' as _i32;
import '../../features/goals/domain/use_cases/make_step_forward_on_a_goal.dart'
    as _i40;
import '../../features/goals/presentation/cubit/goals_cubit.dart' as _i16;
import '../../features/leveling/domain/services/experience_to_reach_next_level_calculator.dart'
    as _i28;
import '../../features/leveling/domain/services/level_progress_percentage_calculator.dart'
    as _i37;
import '../../features/leveling/domain/services/user_level_calculator.dart'
    as _i27;
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart'
    as _i43;
import '../../features/streaks/domain/services/streak_days_in_a_row_calculator.dart'
    as _i19;
import '../../features/streaks/domain/use_cases/increment_daily_streak.dart'
    as _i36;
import '../../features/tasks/data/create_task_repository.dart' as _i6;
import '../../features/tasks/data/delete_task_repository.dart' as _i7;
import '../../features/tasks/data/get_task_done_today_repository.dart' as _i11;
import '../../features/tasks/data/get_tasks_to_do_repository.dart' as _i12;
import '../../features/tasks/data/update_task_repository.dart' as _i25;
import '../../features/tasks/domain/use_cases/create_task.dart' as _i31;
import '../../features/tasks/domain/use_cases/get_tasks_done_today.dart'
    as _i34;
import '../../features/tasks/domain/use_cases/get_tasks_to_do.dart' as _i35;
import '../../features/tasks/domain/use_cases/go_to_task_page.dart' as _i14;
import '../../features/tasks/domain/use_cases/make_step_forward_on_the_task.dart'
    as _i41;
import '../../features/tasks/domain/use_cases/reject_task.dart' as _i44;
import '../../features/tasks/domain/use_cases/update_task.dart' as _i45;
import '../../features/tasks/domain/use_cases/update_task_note.dart' as _i46;
import '../../features/tasks/presentation/cubit/filtered_tasks_cubit.dart'
    as _i8;
import '../../features/tasks/presentation/cubit/tasks_cubit.dart' as _i20;
import '../../features/tasks/presentation/cubit/tasks_done_today_cubit.dart'
    as _i21;
import '../../features/users/data/get_profile_repository.dart' as _i10;
import '../../features/users/data/update_profile_repository.dart' as _i24;
import '../../features/users/domain/use_cases/add_points_to_viewer.dart'
    as _i29;
import '../../features/users/domain/use_cases/get_profile.dart' as _i33;
import '../../features/users/presentation/cubit/profile_cubit.dart' as _i17;
import '../services/use_case_exception_handler.dart'
    as _i26; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i11.GetTasksDoneTodayRepository>(
      _i11.GetTasksDoneTodayRepository(
          firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i12.GetTasksToDoRepository>(() =>
      _i12.GetTasksToDoRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i13.GetTodaysDate>(_i13.GetTodaysDate());
  gh.factory<_i14.GoToTaskPage>(() =>
      _i14.GoToTaskPage(provideContext: get<_i15.BuildContextProvider>()));
  gh.singleton<_i16.GoalsCubit>(_i16.GoalsCubit());
  gh.singleton<_i17.ProfileCubit>(_i17.ProfileCubit());
  gh.factory<_i18.SnackbarService>(() => _i18.SnackbarService(
      buildContextProvider: get<_i15.BuildContextProvider>()));
  gh.lazySingleton<_i19.StreakDaysInARowCalculator>(
      () => _i19.StreakDaysInARowCalculator());
  gh.singleton<_i20.TasksCubit>(_i20.TasksCubit());
  gh.singleton<_i21.TasksDoneTodayCubit>(_i21.TasksDoneTodayCubit());
  gh.singleton<_i22.UniqueIdGenerator>(_i22.UniqueIdGenerator());
  gh.lazySingleton<_i23.UpdateGoalRepository>(
      () => _i23.UpdateGoalRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i24.UpdateProfileRepository>(() =>
      _i24.UpdateProfileRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i25.UpdateTaskRepository>(
      () => _i25.UpdateTaskRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i26.UseCaseExceptionHandler>(_i26.UseCaseExceptionHandler(
      snackbarService: get<_i18.SnackbarService>()));
  gh.factory<_i27.UserLevelCalculator>(() => _i27.UserLevelCalculator(
      experienceToReachALevelCalculator:
          get<_i28.ExperienceToReachNextLevelCalculator>()));
  gh.singleton<_i29.AddPointsToViewer>(_i29.AddPointsToViewer(
      profileCubit: get<_i17.ProfileCubit>(),
      updateProfileRepository: get<_i24.UpdateProfileRepository>()));
  gh.singleton<_i30.CreateGoal>(_i30.CreateGoal(
      goalsCubit: get<_i16.GoalsCubit>(),
      profileCubit: get<_i17.ProfileCubit>(),
      getTodaysDate: get<_i13.GetTodaysDate>(),
      createGoalRepo: get<_i4.CreateGoalRepository>(),
      addPointsToUser: get<_i29.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i22.UniqueIdGenerator>(),
      useCaseExceptionHandler: get<_i26.UseCaseExceptionHandler>()));
  gh.lazySingleton<_i31.CreateTask>(() => _i31.CreateTask(
      tasksCubit: get<_i20.TasksCubit>(),
      profileCubit: get<_i17.ProfileCubit>(),
      getTodaysDate: get<_i13.GetTodaysDate>(),
      addPointsToUser: get<_i29.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i22.UniqueIdGenerator>(),
      createTaskRepository: get<_i6.CreateTaskRepository>()));
  gh.singleton<_i32.GetGoals>(_i32.GetGoals(
      goalsCubit: get<_i16.GoalsCubit>(),
      getGoalsRepo: get<_i9.GetGoalsRepository>(),
      useCaseExceptionHandler: get<_i26.UseCaseExceptionHandler>()));
  gh.singleton<_i33.GetProfile>(_i33.GetProfile(
      profileCubit: get<_i17.ProfileCubit>(),
      getProfileRepository: get<_i10.GetProfileRepository>()));
  gh.singleton<_i34.GetTasksDoneToday>(_i34.GetTasksDoneToday(
      tasksDoneTodayCubit: get<_i21.TasksDoneTodayCubit>(),
      exceptionHandler: get<_i26.UseCaseExceptionHandler>(),
      getTasksDoneTodayRepository: get<_i11.GetTasksDoneTodayRepository>()));
  gh.singleton<_i35.GetTasksToDo>(_i35.GetTasksToDo(
      getTasks: get<_i12.GetTasksToDoRepository>(),
      tasksCubit: get<_i20.TasksCubit>()));
  gh.lazySingleton<_i36.IncrementDailyStreak>(() => _i36.IncrementDailyStreak(
      profileCubit: get<_i17.ProfileCubit>(),
      getTodaysDate: get<_i13.GetTodaysDate>(),
      tasksDoneTodayCubit: get<_i21.TasksDoneTodayCubit>(),
      updateProfile: get<_i24.UpdateProfileRepository>()));
  gh.singleton<_i37.LevelProgressPercentageCalculator>(
      _i37.LevelProgressPercentageCalculator(
          userLevelCalculator: get<_i27.UserLevelCalculator>(),
          experienceToReachALevelCalculator:
              get<_i28.ExperienceToReachNextLevelCalculator>()));
  gh.singleton<_i38.Logout>(_i38.Logout(
      tasksCubit: get<_i20.TasksCubit>(),
      profileCubit: get<_i17.ProfileCubit>(),
      firebaseAuth: get<_i39.FirebaseAuth>(),
      tasksDoneTodayCubit: get<_i21.TasksDoneTodayCubit>(),
      authentificationCubit: get<_i3.AuthentificationCubit>()));
  gh.lazySingleton<_i40.MakeStepForwardOnAGoal>(() =>
      _i40.MakeStepForwardOnAGoal(
          goalsCubit: get<_i16.GoalsCubit>(),
          profileCubit: get<_i17.ProfileCubit>(),
          updateGoalRepo: get<_i23.UpdateGoalRepository>(),
          updateProfileRepository: get<_i24.UpdateProfileRepository>()));
  gh.singleton<_i41.MakeStepForwardOnTheTask>(_i41.MakeStepForwardOnTheTask(
      tasksCubit: get<_i20.TasksCubit>(),
      updateTask: get<_i25.UpdateTaskRepository>(),
      profileCubit: get<_i17.ProfileCubit>(),
      goToMainPage: get<_i42.GoToMainPage>(),
      goToTaskPage: get<_i14.GoToTaskPage>(),
      getTodaysDate: get<_i13.GetTodaysDate>(),
      updateProfile: get<_i24.UpdateProfileRepository>(),
      snackbarService: get<_i18.SnackbarService>(),
      addPointsToViewer: get<_i29.AddPointsToViewer>(),
      tasksDoneTodayCubit: get<_i21.TasksDoneTodayCubit>(),
      incrementDailyStreak: get<_i36.IncrementDailyStreak>(),
      nextRepetitionCalculator: get<_i43.NextRepetitionCalculator>()));
  gh.singleton<_i44.RejectTask>(_i44.RejectTask(
      tasksCubit: get<_i20.TasksCubit>(),
      goToMainPage: get<_i42.GoToMainPage>(),
      goToTaskPage: get<_i14.GoToTaskPage>(),
      snackbarService: get<_i18.SnackbarService>(),
      addPointsToUser: get<_i29.AddPointsToViewer>(),
      deleteTaskRepository: get<_i7.DeleteTaskRepository>()));
  gh.singleton<_i45.UpdateTask>(_i45.UpdateTask(
      tasksCubit: get<_i20.TasksCubit>(),
      updateTaskRepository: get<_i25.UpdateTaskRepository>()));
  gh.singleton<_i46.UpdateTaskNote>(_i46.UpdateTaskNote(
      tasksCubit: get<_i20.TasksCubit>(),
      updateTaskRepository: get<_i25.UpdateTaskRepository>()));
  return get;
}
