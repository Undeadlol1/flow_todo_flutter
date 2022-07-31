// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:build_context_provider/build_context_provider.dart' as _i18;
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i43;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/authentification/domain/entities/use_cases/logout.dart'
    as _i42;
import '../../features/authentification/domain/entities/use_cases/sign_in_with_google.dart'
    as _i49;
import '../../features/authentification/presentation/cubit/authentification_cubit.dart'
    as _i3;
import '../../features/common/domain/use_cases/go_to_main_page.dart' as _i46;
import '../../features/common/services/get_todays_date.dart' as _i16;
import '../../features/common/services/snackbar_service.dart' as _i21;
import '../../features/common/services/unique_id_generator.dart' as _i25;
import '../../features/goals/data/create_goal_repository.dart' as _i4;
import '../../features/goals/data/get_goals_repository.dart' as _i12;
import '../../features/goals/data/update_goal_repository.dart' as _i26;
import '../../features/goals/domain/use_cases/create_goal.dart' as _i34;
import '../../features/goals/domain/use_cases/get_goals.dart' as _i36;
import '../../features/goals/domain/use_cases/make_step_forward_on_a_goal.dart'
    as _i44;
import '../../features/goals/presentation/cubit/goals_cubit.dart' as _i19;
import '../../features/leveling/domain/services/experience_to_reach_next_level_calculator.dart'
    as _i32;
import '../../features/leveling/domain/services/level_progress_percentage_calculator.dart'
    as _i41;
import '../../features/leveling/domain/services/user_level_calculator.dart'
    as _i31;
import '../../features/quests/data/create_quest_repository.dart' as _i6;
import '../../features/quests/data/delete_quest_repository.dart' as _i8;
import '../../features/quests/data/get_active_quests_repository.dart' as _i11;
import '../../features/quests/data/update_quest_repository.dart' as _i27;
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart'
    as _i47;
import '../../features/streaks/domain/services/streak_days_in_a_row_calculator.dart'
    as _i22;
import '../../features/streaks/domain/use_cases/increment_daily_streak.dart'
    as _i40;
import '../../features/tasks/data/create_task_repository.dart' as _i7;
import '../../features/tasks/data/delete_task_repository.dart' as _i9;
import '../../features/tasks/data/get_task_done_today_repository.dart' as _i14;
import '../../features/tasks/data/get_tasks_to_do_repository.dart' as _i15;
import '../../features/tasks/data/update_task_repository.dart' as _i28;
import '../../features/tasks/domain/use_cases/create_task.dart' as _i35;
import '../../features/tasks/domain/use_cases/get_tasks_done_today.dart'
    as _i38;
import '../../features/tasks/domain/use_cases/get_tasks_to_do.dart' as _i39;
import '../../features/tasks/domain/use_cases/go_to_task_page.dart' as _i17;
import '../../features/tasks/domain/use_cases/make_step_forward_on_the_task.dart'
    as _i45;
import '../../features/tasks/domain/use_cases/reject_task.dart' as _i48;
import '../../features/tasks/domain/use_cases/update_task.dart' as _i50;
import '../../features/tasks/domain/use_cases/update_task_note.dart' as _i51;
import '../../features/tasks/presentation/cubit/filtered_tasks_cubit.dart'
    as _i10;
import '../../features/tasks/presentation/cubit/tasks_cubit.dart' as _i23;
import '../../features/tasks/presentation/cubit/tasks_done_today_cubit.dart'
    as _i24;
import '../../features/users/data/get_profile_repository.dart' as _i13;
import '../../features/users/data/upsert_profile_repository.dart' as _i29;
import '../../features/users/domain/use_cases/add_points_to_viewer.dart'
    as _i33;
import '../../features/users/domain/use_cases/get_profile.dart' as _i37;
import '../../features/users/presentation/cubit/profile_cubit.dart' as _i20;
import '../services/use_case_exception_handler.dart'
    as _i30; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.AuthentificationCubit>(_i3.AuthentificationCubit());
  gh.lazySingleton<_i4.CreateGoalRepository>(
      () => _i4.CreateGoalRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i6.CreateQuestRepository>(
      () => _i6.CreateQuestRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i7.CreateTaskRepository>(
      () => _i7.CreateTaskRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i8.DeleteQuestRepository>(
      () => _i8.DeleteQuestRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i9.DeleteTaskRepository>(
      () => _i9.DeleteTaskRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i10.FilteredTasksCubit>(() => _i10.FilteredTasksCubit());
  gh.factory<_i11.GetActiveQuestsRepository>(() =>
      _i11.GetActiveQuestsRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i12.GetGoalsRepository>(
      () => _i12.GetGoalsRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i13.GetProfileRepository>(
      _i13.GetProfileRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i14.GetTasksDoneTodayRepository>(
      _i14.GetTasksDoneTodayRepository(
          firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i15.GetTasksToDoRepository>(() =>
      _i15.GetTasksToDoRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i16.GetTodaysDate>(_i16.GetTodaysDate());
  gh.factory<_i17.GoToTaskPage>(() =>
      _i17.GoToTaskPage(provideContext: get<_i18.BuildContextProvider>()));
  gh.singleton<_i19.GoalsCubit>(_i19.GoalsCubit());
  gh.singleton<_i20.ProfileCubit>(_i20.ProfileCubit());
  gh.factory<_i21.SnackbarService>(() => _i21.SnackbarService(
      buildContextProvider: get<_i18.BuildContextProvider>()));
  gh.lazySingleton<_i22.StreakDaysInARowCalculator>(
      () => _i22.StreakDaysInARowCalculator());
  gh.singleton<_i23.TasksCubit>(_i23.TasksCubit());
  gh.singleton<_i24.TasksDoneTodayCubit>(_i24.TasksDoneTodayCubit());
  gh.singleton<_i25.UniqueIdGenerator>(_i25.UniqueIdGenerator());
  gh.lazySingleton<_i26.UpdateGoalRepository>(
      () => _i26.UpdateGoalRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i27.UpdateQuestRepository>(() =>
      _i27.UpdateQuestRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i28.UpdateTaskRepository>(
      () => _i28.UpdateTaskRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i29.UpsertProfileRepository>(() =>
      _i29.UpsertProfileRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i30.UseCaseExceptionHandler>(_i30.UseCaseExceptionHandler(
      snackbarService: get<_i21.SnackbarService>()));
  gh.factory<_i31.UserLevelCalculator>(() => _i31.UserLevelCalculator(
      experienceToReachALevelCalculator:
          get<_i32.ExperienceToReachNextLevelCalculator>()));
  gh.singleton<_i33.AddPointsToViewer>(_i33.AddPointsToViewer(
      profileCubit: get<_i20.ProfileCubit>(),
      updateProfileRepository: get<_i29.UpsertProfileRepository>()));
  gh.singleton<_i34.CreateGoal>(_i34.CreateGoal(
      goalsCubit: get<_i19.GoalsCubit>(),
      profileCubit: get<_i20.ProfileCubit>(),
      getTodaysDate: get<_i16.GetTodaysDate>(),
      createGoalRepo: get<_i4.CreateGoalRepository>(),
      addPointsToUser: get<_i33.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i25.UniqueIdGenerator>(),
      useCaseExceptionHandler: get<_i30.UseCaseExceptionHandler>()));
  gh.lazySingleton<_i35.CreateTask>(() => _i35.CreateTask(
      tasksCubit: get<_i23.TasksCubit>(),
      profileCubit: get<_i20.ProfileCubit>(),
      getTodaysDate: get<_i16.GetTodaysDate>(),
      addPointsToUser: get<_i33.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i25.UniqueIdGenerator>(),
      createTaskRepository: get<_i7.CreateTaskRepository>()));
  gh.singleton<_i36.GetGoals>(_i36.GetGoals(
      goalsCubit: get<_i19.GoalsCubit>(),
      getGoalsRepo: get<_i12.GetGoalsRepository>(),
      useCaseExceptionHandler: get<_i30.UseCaseExceptionHandler>()));
  gh.singleton<_i37.GetProfile>(_i37.GetProfile(
      profileCubit: get<_i20.ProfileCubit>(),
      getProfileRepository: get<_i13.GetProfileRepository>()));
  gh.singleton<_i38.GetTasksDoneToday>(_i38.GetTasksDoneToday(
      tasksDoneTodayCubit: get<_i24.TasksDoneTodayCubit>(),
      exceptionHandler: get<_i30.UseCaseExceptionHandler>(),
      getTasksDoneTodayRepository: get<_i14.GetTasksDoneTodayRepository>()));
  gh.singleton<_i39.GetTasksToDo>(_i39.GetTasksToDo(
      getTasks: get<_i15.GetTasksToDoRepository>(),
      tasksCubit: get<_i23.TasksCubit>()));
  gh.lazySingleton<_i40.IncrementDailyStreak>(() => _i40.IncrementDailyStreak(
      profileCubit: get<_i20.ProfileCubit>(),
      getTodaysDate: get<_i16.GetTodaysDate>(),
      tasksDoneTodayCubit: get<_i24.TasksDoneTodayCubit>(),
      updateProfile: get<_i29.UpsertProfileRepository>()));
  gh.singleton<_i41.LevelProgressPercentageCalculator>(
      _i41.LevelProgressPercentageCalculator(
          userLevelCalculator: get<_i31.UserLevelCalculator>(),
          experienceToReachALevelCalculator:
              get<_i32.ExperienceToReachNextLevelCalculator>()));
  gh.singleton<_i42.Logout>(_i42.Logout(
      tasksCubit: get<_i23.TasksCubit>(),
      profileCubit: get<_i20.ProfileCubit>(),
      firebaseAuth: get<_i43.FirebaseAuth>(),
      tasksDoneTodayCubit: get<_i24.TasksDoneTodayCubit>(),
      authentificationCubit: get<_i3.AuthentificationCubit>()));
  gh.lazySingleton<_i44.MakeStepForwardOnAGoal>(() =>
      _i44.MakeStepForwardOnAGoal(
          goalsCubit: get<_i19.GoalsCubit>(),
          profileCubit: get<_i20.ProfileCubit>(),
          updateGoalRepo: get<_i26.UpdateGoalRepository>(),
          updateProfileRepository: get<_i29.UpsertProfileRepository>()));
  gh.singleton<_i45.MakeStepForwardOnTheTask>(_i45.MakeStepForwardOnTheTask(
      tasksCubit: get<_i23.TasksCubit>(),
      updateTask: get<_i28.UpdateTaskRepository>(),
      profileCubit: get<_i20.ProfileCubit>(),
      goToMainPage: get<_i46.GoToMainPage>(),
      goToTaskPage: get<_i17.GoToTaskPage>(),
      getTodaysDate: get<_i16.GetTodaysDate>(),
      updateProfile: get<_i29.UpsertProfileRepository>(),
      snackbarService: get<_i21.SnackbarService>(),
      addPointsToViewer: get<_i33.AddPointsToViewer>(),
      tasksDoneTodayCubit: get<_i24.TasksDoneTodayCubit>(),
      incrementDailyStreak: get<_i40.IncrementDailyStreak>(),
      nextRepetitionCalculator: get<_i47.NextRepetitionCalculator>()));
  gh.singleton<_i48.RejectTask>(_i48.RejectTask(
      tasksCubit: get<_i23.TasksCubit>(),
      goToMainPage: get<_i46.GoToMainPage>(),
      goToTaskPage: get<_i17.GoToTaskPage>(),
      snackbarService: get<_i21.SnackbarService>(),
      addPointsToUser: get<_i33.AddPointsToViewer>(),
      deleteTaskRepository: get<_i9.DeleteTaskRepository>()));
  gh.factory<_i49.SignInWithGoogle>(() => _i49.SignInWithGoogle(
      profileCubit: get<_i20.ProfileCubit>(),
      firebaseAuth: get<_i43.FirebaseAuth>(),
      uniqueIdGenerator: get<_i25.UniqueIdGenerator>(),
      getProfileRepository: get<_i13.GetProfileRepository>(),
      upsertProfileRepository: get<_i29.UpsertProfileRepository>(),
      useCaseExceptionHandler: get<_i30.UseCaseExceptionHandler>()));
  gh.singleton<_i50.UpdateTask>(_i50.UpdateTask(
      tasksCubit: get<_i23.TasksCubit>(),
      updateTaskRepository: get<_i28.UpdateTaskRepository>()));
  gh.singleton<_i51.UpdateTaskNote>(_i51.UpdateTaskNote(
      tasksCubit: get<_i23.TasksCubit>(),
      updateTaskRepository: get<_i28.UpdateTaskRepository>()));
  return get;
}
