// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:build_context_provider/build_context_provider.dart' as _i18;
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i36;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/authentification/domain/entities/use_cases/logout.dart'
    as _i35;
import '../../features/authentification/presentation/cubit/authentification_cubit.dart'
    as _i4;
import '../../features/common/domain/use_cases/go_to_main_page.dart' as _i39;
import '../../features/common/services/get_todays_date.dart' as _i14;
import '../../features/common/services/snackbar_service.dart' as _i17;
import '../../features/common/services/unique_id_generator.dart' as _i22;
import '../../features/goals/data/create_goal_repository.dart' as _i5;
import '../../features/goals/data/get_goals_repository.dart' as _i10;
import '../../features/goals/data/update_goal_repository.dart' as _i23;
import '../../features/goals/domain/use_cases/create_goal.dart' as _i28;
import '../../features/goals/domain/use_cases/get_goals.dart' as _i30;
import '../../features/goals/domain/use_cases/make_step_forward_on_a_goal.dart'
    as _i37;
import '../../features/goals/presentation/cubit/goals_cubit.dart' as _i15;
import '../../features/quests/presentation/cubits/active_quests_cubit.dart'
    as _i3;
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart'
    as _i41;
import '../../features/streaks/domain/services/streak_days_in_a_row_calculator.dart'
    as _i19;
import '../../features/streaks/domain/use_cases/increment_daily_streak.dart'
    as _i34;
import '../../features/tasks/data/create_task_repository.dart' as _i7;
import '../../features/tasks/data/delete_task_repository.dart' as _i8;
import '../../features/tasks/data/get_task_done_today_repository.dart' as _i12;
import '../../features/tasks/data/get_tasks_to_do_repository.dart' as _i13;
import '../../features/tasks/data/update_task_repository.dart' as _i25;
import '../../features/tasks/domain/use_cases/create_task.dart' as _i29;
import '../../features/tasks/domain/use_cases/get_tasks_done_today.dart'
    as _i32;
import '../../features/tasks/domain/use_cases/get_tasks_to_do.dart' as _i33;
import '../../features/tasks/domain/use_cases/go_to_task_page.dart' as _i40;
import '../../features/tasks/domain/use_cases/make_step_forward_on_the_task.dart'
    as _i38;
import '../../features/tasks/domain/use_cases/reject_task.dart' as _i42;
import '../../features/tasks/domain/use_cases/update_task.dart' as _i43;
import '../../features/tasks/domain/use_cases/update_task_note.dart' as _i44;
import '../../features/tasks/presentation/cubit/filtered_tasks_cubit.dart'
    as _i9;
import '../../features/tasks/presentation/cubit/tasks_cubit.dart' as _i20;
import '../../features/tasks/presentation/cubit/tasks_done_today_cubit.dart'
    as _i21;
import '../../features/users/data/get_profile_repository.dart' as _i11;
import '../../features/users/data/update_profile_repository.dart' as _i24;
import '../../features/users/domain/use_cases/add_points_to_viewer.dart'
    as _i27;
import '../../features/users/domain/use_cases/get_profile.dart' as _i31;
import '../../features/users/presentation/cubit/profile_cubit.dart' as _i16;
import '../services/use_case_exception_handler.dart'
    as _i26; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ActiveQuestsCubit>(() => _i3.ActiveQuestsCubit());
  gh.singleton<_i4.AuthentificationCubit>(_i4.AuthentificationCubit());
  gh.lazySingleton<_i5.CreateGoalRepository>(
      () => _i5.CreateGoalRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i7.CreateTaskRepository>(
      () => _i7.CreateTaskRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i8.DeleteTaskRepository>(
      () => _i8.DeleteTaskRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i9.FilteredTasksCubit>(() => _i9.FilteredTasksCubit());
  gh.factory<_i10.GetGoalsRepository>(
      () => _i10.GetGoalsRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.singleton<_i11.GetProfileRepository>(
      _i11.GetProfileRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.singleton<_i12.GetTasksDoneTodayRepository>(
      _i12.GetTasksDoneTodayRepository(
          firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i13.GetTasksToDoRepository>(() =>
      _i13.GetTasksToDoRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.singleton<_i14.GetTodaysDate>(_i14.GetTodaysDate());
  gh.singleton<_i15.GoalsCubit>(_i15.GoalsCubit());
  gh.singleton<_i16.ProfileCubit>(_i16.ProfileCubit());
  gh.factory<_i17.SnackbarService>(() => _i17.SnackbarService(
      buildContextProvider: get<_i18.BuildContextProvider>()));
  gh.lazySingleton<_i19.StreakDaysInARowCalculator>(
      () => _i19.StreakDaysInARowCalculator());
  gh.singleton<_i20.TasksCubit>(_i20.TasksCubit());
  gh.singleton<_i21.TasksDoneTodayCubit>(_i21.TasksDoneTodayCubit());
  gh.singleton<_i22.UniqueIdGenerator>(_i22.UniqueIdGenerator());
  gh.lazySingleton<_i23.UpdateGoalRepository>(
      () => _i23.UpdateGoalRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i24.UpdateProfileRepository>(() =>
      _i24.UpdateProfileRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i25.UpdateTaskRepository>(
      () => _i25.UpdateTaskRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.singleton<_i26.UseCaseExceptionHandler>(_i26.UseCaseExceptionHandler(
      snackbarService: get<_i17.SnackbarService>()));
  gh.singleton<_i27.AddPointsToViewer>(_i27.AddPointsToViewer(
      profileCubit: get<_i16.ProfileCubit>(),
      updateProfileRepository: get<_i24.UpdateProfileRepository>()));
  gh.singleton<_i28.CreateGoal>(_i28.CreateGoal(
      goalsCubit: get<_i15.GoalsCubit>(),
      profileCubit: get<_i16.ProfileCubit>(),
      getTodaysDate: get<_i14.GetTodaysDate>(),
      createGoalRepo: get<_i5.CreateGoalRepository>(),
      addPointsToUser: get<_i27.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i22.UniqueIdGenerator>(),
      useCaseExceptionHandler: get<_i26.UseCaseExceptionHandler>()));
  gh.lazySingleton<_i29.CreateTask>(() => _i29.CreateTask(
      tasksCubit: get<_i20.TasksCubit>(),
      profileCubit: get<_i16.ProfileCubit>(),
      getTodaysDate: get<_i14.GetTodaysDate>(),
      addPointsToUser: get<_i27.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i22.UniqueIdGenerator>(),
      createTaskRepository: get<_i7.CreateTaskRepository>()));
  gh.singleton<_i30.GetGoals>(_i30.GetGoals(
      goalsCubit: get<_i15.GoalsCubit>(),
      getGoalsRepo: get<_i10.GetGoalsRepository>(),
      useCaseExceptionHandler: get<_i26.UseCaseExceptionHandler>()));
  gh.singleton<_i31.GetProfile>(_i31.GetProfile(
      profileCubit: get<_i16.ProfileCubit>(),
      getProfileRepository: get<_i11.GetProfileRepository>()));
  gh.singleton<_i32.GetTasksDoneToday>(_i32.GetTasksDoneToday(
      tasksDoneTodayCubit: get<_i21.TasksDoneTodayCubit>(),
      exceptionHandler: get<_i26.UseCaseExceptionHandler>(),
      getTasksDoneTodayRepository: get<_i12.GetTasksDoneTodayRepository>()));
  gh.singleton<_i33.GetTasksToDo>(_i33.GetTasksToDo(
      getTasks: get<_i13.GetTasksToDoRepository>(),
      tasksCubit: get<_i20.TasksCubit>()));
  gh.lazySingleton<_i34.IncrementDailyStreak>(() => _i34.IncrementDailyStreak(
      profileCubit: get<_i16.ProfileCubit>(),
      getTodaysDate: get<_i14.GetTodaysDate>(),
      tasksDoneTodayCubit: get<_i21.TasksDoneTodayCubit>(),
      updateProfile: get<_i24.UpdateProfileRepository>()));
  gh.singleton<_i35.Logout>(_i35.Logout(
      tasksCubit: get<_i20.TasksCubit>(),
      profileCubit: get<_i16.ProfileCubit>(),
      firebaseAuth: get<_i36.FirebaseAuth>(),
      tasksDoneTodayCubit: get<_i21.TasksDoneTodayCubit>(),
      authentificationCubit: get<_i4.AuthentificationCubit>()));
  gh.lazySingleton<_i37.MakeStepForwardOnAGoal>(() =>
      _i37.MakeStepForwardOnAGoal(
          goalsCubit: get<_i15.GoalsCubit>(),
          profileCubit: get<_i16.ProfileCubit>(),
          updateGoalRepo: get<_i23.UpdateGoalRepository>(),
          updateProfileRepository: get<_i24.UpdateProfileRepository>()));
  gh.singleton<_i38.MakeStepForwardOnTheTask>(_i38.MakeStepForwardOnTheTask(
      tasksCubit: get<_i20.TasksCubit>(),
      updateTask: get<_i25.UpdateTaskRepository>(),
      profileCubit: get<_i16.ProfileCubit>(),
      goToMainPage: get<_i39.GoToMainPage>(),
      goToTaskPage: get<_i40.GoToTaskPage>(),
      getTodaysDate: get<_i14.GetTodaysDate>(),
      updateProfile: get<_i24.UpdateProfileRepository>(),
      snackbarService: get<_i17.SnackbarService>(),
      addPointsToViewer: get<_i27.AddPointsToViewer>(),
      tasksDoneTodayCubit: get<_i21.TasksDoneTodayCubit>(),
      incrementDailyStreak: get<_i34.IncrementDailyStreak>(),
      nextRepetitionCalculator: get<_i41.NextRepetitionCalculator>()));
  gh.singleton<_i42.RejectTask>(_i42.RejectTask(
      tasksCubit: get<_i20.TasksCubit>(),
      goToMainPage: get<_i39.GoToMainPage>(),
      goToTaskPage: get<_i40.GoToTaskPage>(),
      snackbarService: get<_i17.SnackbarService>(),
      addPointsToUser: get<_i27.AddPointsToViewer>(),
      deleteTaskRepository: get<_i8.DeleteTaskRepository>()));
  gh.singleton<_i43.UpdateTask>(_i43.UpdateTask(
      tasksCubit: get<_i20.TasksCubit>(),
      updateTaskRepository: get<_i25.UpdateTaskRepository>()));
  gh.singleton<_i44.UpdateTaskNote>(_i44.UpdateTaskNote(
      tasksCubit: get<_i20.TasksCubit>(),
      updateTaskRepository: get<_i25.UpdateTaskRepository>()));
  return get;
}
