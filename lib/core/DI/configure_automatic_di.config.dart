// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_context_provider/build_context_provider.dart' as _i15;
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i41;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/authentification/domain/entities/use_cases/logout.dart'
    as _i40;
import '../../features/authentification/domain/entities/use_cases/sign_in_with_google.dart'
    as _i47;
import '../../features/authentification/presentation/cubit/authentification_cubit.dart'
    as _i3;
import '../../features/common/domain/use_cases/go_to_main_page.dart' as _i44;
import '../../features/common/services/get_todays_date.dart' as _i13;
import '../../features/common/services/snackbar_service.dart' as _i19;
import '../../features/common/services/unique_id_generator.dart' as _i23;
import '../../features/goals/data/create_goal_repository.dart' as _i4;
import '../../features/goals/data/get_goals_repository.dart' as _i9;
import '../../features/goals/data/update_goal_repository.dart' as _i24;
import '../../features/goals/domain/use_cases/create_goal.dart' as _i32;
import '../../features/goals/domain/use_cases/get_goals.dart' as _i34;
import '../../features/goals/domain/use_cases/make_step_forward_on_a_goal.dart'
    as _i42;
import '../../features/goals/presentation/cubit/goals_cubit.dart' as _i16;
import '../../features/leveling/domain/services/experience_to_reach_next_level_calculator.dart'
    as _i29;
import '../../features/leveling/domain/services/level_progress_percentage_calculator.dart'
    as _i39;
import '../../features/leveling/domain/services/user_level_calculator.dart'
    as _i28;
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart'
    as _i45;
import '../../features/streaks/domain/services/streak_days_in_a_row_calculator.dart'
    as _i20;
import '../../features/streaks/domain/use_cases/increment_daily_streak_action.dart'
    as _i38;
import '../../features/tasks/data/create_task_repository.dart' as _i6;
import '../../features/tasks/data/delete_task_repository.dart' as _i7;
import '../../features/tasks/data/get_task_worked_on_today_repository.dart'
    as _i12;
import '../../features/tasks/data/get_tasks_to_do_repository.dart' as _i11;
import '../../features/tasks/data/update_task_repository.dart' as _i25;
import '../../features/tasks/domain/actions/work_on_task_action.dart' as _i30;
import '../../features/tasks/domain/use_cases/create_task.dart' as _i33;
import '../../features/tasks/domain/use_cases/get_tasks_to_do.dart' as _i36;
import '../../features/tasks/domain/use_cases/get_tasks_worked_on_today.dart'
    as _i37;
import '../../features/tasks/domain/use_cases/go_to_task_page.dart' as _i14;
import '../../features/tasks/domain/use_cases/make_step_forward_on_the_task.dart'
    as _i43;
import '../../features/tasks/domain/use_cases/reject_task.dart' as _i46;
import '../../features/tasks/domain/use_cases/toggle_task_selection.dart'
    as _i48;
import '../../features/tasks/domain/use_cases/update_task.dart' as _i49;
import '../../features/tasks/domain/use_cases/update_task_note.dart' as _i50;
import '../../features/tasks/presentation/cubit/filtered_tasks_cubit.dart'
    as _i8;
import '../../features/tasks/presentation/cubit/selected_tasks_cubit.dart'
    as _i18;
import '../../features/tasks/presentation/cubit/tasks_cubit.dart' as _i21;
import '../../features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart'
    as _i22;
import '../../features/users/data/get_profile_repository.dart' as _i10;
import '../../features/users/data/upsert_profile_repository.dart' as _i26;
import '../../features/users/domain/use_cases/add_points_to_viewer.dart'
    as _i31;
import '../../features/users/domain/use_cases/get_profile.dart' as _i35;
import '../../features/users/presentation/cubit/profile_cubit.dart' as _i17;
import '../services/use_case_exception_handler.dart'
    as _i27; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i14.GoToTaskPage>(() =>
      _i14.GoToTaskPage(provideContext: get<_i15.BuildContextProvider>()));
  gh.singleton<_i16.GoalsCubit>(_i16.GoalsCubit());
  gh.singleton<_i17.ProfileCubit>(_i17.ProfileCubit());
  gh.singleton<_i18.SelectedTasksCubit>(_i18.SelectedTasksCubit());
  gh.factory<_i19.SnackbarService>(() => _i19.SnackbarService(
      buildContextProvider: get<_i15.BuildContextProvider>()));
  gh.lazySingleton<_i20.StreakDaysInARowCalculator>(
      () => _i20.StreakDaysInARowCalculator());
  gh.singleton<_i21.TasksCubit>(_i21.TasksCubit());
  gh.singleton<_i22.TasksWorkedOnTodayCubit>(_i22.TasksWorkedOnTodayCubit());
  gh.singleton<_i23.UniqueIdGenerator>(_i23.UniqueIdGenerator());
  gh.lazySingleton<_i24.UpdateGoalRepository>(
      () => _i24.UpdateGoalRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i25.UpdateTaskRepository>(
      () => _i25.UpdateTaskRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i26.UpsertProfileRepository>(() =>
      _i26.UpsertProfileRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i27.UseCaseExceptionHandler>(_i27.UseCaseExceptionHandler(
      snackbarService: get<_i19.SnackbarService>()));
  gh.factory<_i28.UserLevelCalculator>(() => _i28.UserLevelCalculator(
      experienceToReachALevelCalculator:
          get<_i29.ExperienceToReachNextLevelCalculator>()));
  gh.factory<_i30.WorkOnTaskAction>(() => _i30.WorkOnTaskAction(
      tasksDoneTodayCubit: get<_i22.TasksWorkedOnTodayCubit>()));
  gh.singleton<_i31.AddPointsToViewer>(_i31.AddPointsToViewer(
      profileCubit: get<_i17.ProfileCubit>(),
      updateProfileRepository: get<_i26.UpsertProfileRepository>()));
  gh.singleton<_i32.CreateGoal>(_i32.CreateGoal(
      goalsCubit: get<_i16.GoalsCubit>(),
      profileCubit: get<_i17.ProfileCubit>(),
      getTodaysDate: get<_i13.GetTodaysDate>(),
      createGoalRepo: get<_i4.CreateGoalRepository>(),
      addPointsToUser: get<_i31.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i23.UniqueIdGenerator>(),
      useCaseExceptionHandler: get<_i27.UseCaseExceptionHandler>()));
  gh.lazySingleton<_i33.CreateTask>(() => _i33.CreateTask(
      tasksCubit: get<_i21.TasksCubit>(),
      profileCubit: get<_i17.ProfileCubit>(),
      getTodaysDate: get<_i13.GetTodaysDate>(),
      addPointsToUser: get<_i31.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i23.UniqueIdGenerator>(),
      createTaskRepository: get<_i6.CreateTaskRepository>()));
  gh.singleton<_i34.GetGoals>(_i34.GetGoals(
      goalsCubit: get<_i16.GoalsCubit>(),
      getGoalsRepo: get<_i9.GetGoalsRepository>(),
      useCaseExceptionHandler: get<_i27.UseCaseExceptionHandler>()));
  gh.singleton<_i35.GetProfile>(_i35.GetProfile(
      profileCubit: get<_i17.ProfileCubit>(),
      getProfileRepository: get<_i10.GetProfileRepository>(),
      useCaseExceptionHandler: get<_i27.UseCaseExceptionHandler>()));
  gh.singleton<_i36.GetTasksToDo>(_i36.GetTasksToDo(
      getTasks: get<_i11.GetTasksToDoRepository>(),
      tasksCubit: get<_i21.TasksCubit>(),
      exceptionHandler: get<_i27.UseCaseExceptionHandler>()));
  gh.singleton<_i37.GetTasksWorkedOnToday>(_i37.GetTasksWorkedOnToday(
      tasksDoneTodayCubit: get<_i22.TasksWorkedOnTodayCubit>(),
      exceptionHandler: get<_i27.UseCaseExceptionHandler>(),
      getTasksDoneTodayRepository:
          get<_i12.GetTasksWorkedOnTodayRepository>()));
  gh.lazySingleton<_i38.IncrementDailyStreakAction>(() =>
      _i38.IncrementDailyStreakAction(
          profileCubit: get<_i17.ProfileCubit>(),
          getTodaysDate: get<_i13.GetTodaysDate>(),
          tasksDoneTodayCubit: get<_i22.TasksWorkedOnTodayCubit>(),
          updateProfile: get<_i26.UpsertProfileRepository>()));
  gh.singleton<_i39.LevelProgressPercentageCalculator>(
      _i39.LevelProgressPercentageCalculator(
          userLevelCalculator: get<_i28.UserLevelCalculator>(),
          experienceToReachALevelCalculator:
              get<_i29.ExperienceToReachNextLevelCalculator>()));
  gh.singleton<_i40.Logout>(_i40.Logout(
      tasksCubit: get<_i21.TasksCubit>(),
      profileCubit: get<_i17.ProfileCubit>(),
      firebaseAuth: get<_i41.FirebaseAuth>(),
      firebaseFirestore: get<_i5.FirebaseFirestore>(),
      tasksDoneTodayCubit: get<_i22.TasksWorkedOnTodayCubit>(),
      authentificationCubit: get<_i3.AuthentificationCubit>()));
  gh.lazySingleton<_i42.MakeStepForwardOnAGoal>(() =>
      _i42.MakeStepForwardOnAGoal(
          goalsCubit: get<_i16.GoalsCubit>(),
          profileCubit: get<_i17.ProfileCubit>(),
          updateGoalRepo: get<_i24.UpdateGoalRepository>(),
          updateProfileRepository: get<_i26.UpsertProfileRepository>()));
  gh.singleton<_i43.MakeStepForwardOnTheTask>(_i43.MakeStepForwardOnTheTask(
      tasksCubit: get<_i21.TasksCubit>(),
      updateTask: get<_i25.UpdateTaskRepository>(),
      profileCubit: get<_i17.ProfileCubit>(),
      goToMainPage: get<_i44.GoToMainPage>(),
      goToTaskPage: get<_i14.GoToTaskPage>(),
      getTodaysDate: get<_i13.GetTodaysDate>(),
      updateProfile: get<_i26.UpsertProfileRepository>(),
      snackbarService: get<_i19.SnackbarService>(),
      workOnTaskAction: get<_i30.WorkOnTaskAction>(),
      addPointsToViewer: get<_i31.AddPointsToViewer>(),
      tasksDoneTodayCubit: get<_i22.TasksWorkedOnTodayCubit>(),
      incrementDailyStreak: get<_i38.IncrementDailyStreakAction>(),
      nextRepetitionCalculator: get<_i45.NextRepetitionCalculator>()));
  gh.singleton<_i46.RejectTask>(_i46.RejectTask(
      tasksCubit: get<_i21.TasksCubit>(),
      goToMainPage: get<_i44.GoToMainPage>(),
      goToTaskPage: get<_i14.GoToTaskPage>(),
      snackbarService: get<_i19.SnackbarService>(),
      addPointsToUser: get<_i31.AddPointsToViewer>(),
      deleteTaskRepository: get<_i7.DeleteTaskRepository>()));
  gh.factory<_i47.SignInWithGoogle>(() => _i47.SignInWithGoogle(
      profileCubit: get<_i17.ProfileCubit>(),
      firebaseAuth: get<_i41.FirebaseAuth>(),
      uniqueIdGenerator: get<_i23.UniqueIdGenerator>(),
      getProfileRepository: get<_i10.GetProfileRepository>(),
      upsertProfileRepository: get<_i26.UpsertProfileRepository>(),
      useCaseExceptionHandler: get<_i27.UseCaseExceptionHandler>()));
  gh.factory<_i48.ToggleTaskSelection>(() => _i48.ToggleTaskSelection(
      tasksCubit: get<_i21.TasksCubit>(),
      updateTaskRepository: get<_i25.UpdateTaskRepository>()));
  gh.singleton<_i49.UpdateTask>(_i49.UpdateTask(
      tasksCubit: get<_i21.TasksCubit>(),
      updateTaskRepository: get<_i25.UpdateTaskRepository>()));
  gh.singleton<_i50.UpdateTaskNote>(_i50.UpdateTaskNote(
      tasksCubit: get<_i21.TasksCubit>(),
      updateTaskRepository: get<_i25.UpdateTaskRepository>()));
  return get;
}
