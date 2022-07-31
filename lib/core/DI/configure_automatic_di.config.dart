// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:build_context_provider/build_context_provider.dart' as _i19;
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i45;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/authentification/domain/entities/use_cases/logout.dart'
    as _i44;
import '../../features/authentification/domain/entities/use_cases/sign_in_with_google.dart'
    as _i51;
import '../../features/authentification/presentation/cubit/authentification_cubit.dart'
    as _i4;
import '../../features/common/domain/use_cases/go_to_main_page.dart' as _i48;
import '../../features/common/services/get_todays_date.dart' as _i17;
import '../../features/common/services/snackbar_service.dart' as _i22;
import '../../features/common/services/unique_id_generator.dart' as _i26;
import '../../features/goals/data/create_goal_repository.dart' as _i5;
import '../../features/goals/data/get_goals_repository.dart' as _i13;
import '../../features/goals/data/update_goal_repository.dart' as _i27;
import '../../features/goals/domain/use_cases/create_goal.dart' as _i35;
import '../../features/goals/domain/use_cases/get_goals.dart' as _i38;
import '../../features/goals/domain/use_cases/make_step_forward_on_a_goal.dart'
    as _i46;
import '../../features/goals/presentation/cubit/goals_cubit.dart' as _i20;
import '../../features/leveling/domain/services/experience_to_reach_next_level_calculator.dart'
    as _i33;
import '../../features/leveling/domain/services/level_progress_percentage_calculator.dart'
    as _i43;
import '../../features/leveling/domain/services/user_level_calculator.dart'
    as _i32;
import '../../features/quests/data/create_quest_repository.dart' as _i7;
import '../../features/quests/data/delete_quest_repository.dart' as _i9;
import '../../features/quests/data/get_active_quests_repository.dart' as _i12;
import '../../features/quests/data/update_quest_repository.dart' as _i28;
import '../../features/quests/domain/use_cases/get_active_quests.dart' as _i37;
import '../../features/quests/presentation/cubits/active_quests_cubit.dart'
    as _i3;
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart'
    as _i49;
import '../../features/streaks/domain/services/streak_days_in_a_row_calculator.dart'
    as _i23;
import '../../features/streaks/domain/use_cases/increment_daily_streak.dart'
    as _i42;
import '../../features/tasks/data/create_task_repository.dart' as _i8;
import '../../features/tasks/data/delete_task_repository.dart' as _i10;
import '../../features/tasks/data/get_task_done_today_repository.dart' as _i15;
import '../../features/tasks/data/get_tasks_to_do_repository.dart' as _i16;
import '../../features/tasks/data/update_task_repository.dart' as _i29;
import '../../features/tasks/domain/use_cases/create_task.dart' as _i36;
import '../../features/tasks/domain/use_cases/get_tasks_done_today.dart'
    as _i40;
import '../../features/tasks/domain/use_cases/get_tasks_to_do.dart' as _i41;
import '../../features/tasks/domain/use_cases/go_to_task_page.dart' as _i18;
import '../../features/tasks/domain/use_cases/make_step_forward_on_the_task.dart'
    as _i47;
import '../../features/tasks/domain/use_cases/reject_task.dart' as _i50;
import '../../features/tasks/domain/use_cases/update_task.dart' as _i52;
import '../../features/tasks/domain/use_cases/update_task_note.dart' as _i53;
import '../../features/tasks/presentation/cubit/filtered_tasks_cubit.dart'
    as _i11;
import '../../features/tasks/presentation/cubit/tasks_cubit.dart' as _i24;
import '../../features/tasks/presentation/cubit/tasks_done_today_cubit.dart'
    as _i25;
import '../../features/users/data/get_profile_repository.dart' as _i14;
import '../../features/users/data/upsert_profile_repository.dart' as _i30;
import '../../features/users/domain/use_cases/add_points_to_viewer.dart'
    as _i34;
import '../../features/users/domain/use_cases/get_profile.dart' as _i39;
import '../../features/users/presentation/cubit/profile_cubit.dart' as _i21;
import '../services/use_case_exception_handler.dart'
    as _i31; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i15.GetTasksDoneTodayRepository>(
      _i15.GetTasksDoneTodayRepository(
          firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i16.GetTasksToDoRepository>(() =>
      _i16.GetTasksToDoRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.singleton<_i17.GetTodaysDate>(_i17.GetTodaysDate());
  gh.factory<_i18.GoToTaskPage>(() =>
      _i18.GoToTaskPage(provideContext: get<_i19.BuildContextProvider>()));
  gh.singleton<_i20.GoalsCubit>(_i20.GoalsCubit());
  gh.singleton<_i21.ProfileCubit>(_i21.ProfileCubit());
  gh.factory<_i22.SnackbarService>(() => _i22.SnackbarService(
      buildContextProvider: get<_i19.BuildContextProvider>()));
  gh.lazySingleton<_i23.StreakDaysInARowCalculator>(
      () => _i23.StreakDaysInARowCalculator());
  gh.singleton<_i24.TasksCubit>(_i24.TasksCubit());
  gh.singleton<_i25.TasksDoneTodayCubit>(_i25.TasksDoneTodayCubit());
  gh.singleton<_i26.UniqueIdGenerator>(_i26.UniqueIdGenerator());
  gh.lazySingleton<_i27.UpdateGoalRepository>(
      () => _i27.UpdateGoalRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i28.UpdateQuestRepository>(() =>
      _i28.UpdateQuestRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i29.UpdateTaskRepository>(
      () => _i29.UpdateTaskRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i30.UpsertProfileRepository>(() =>
      _i30.UpsertProfileRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.singleton<_i31.UseCaseExceptionHandler>(_i31.UseCaseExceptionHandler(
      snackbarService: get<_i22.SnackbarService>()));
  gh.factory<_i32.UserLevelCalculator>(() => _i32.UserLevelCalculator(
      experienceToReachALevelCalculator:
          get<_i33.ExperienceToReachNextLevelCalculator>()));
  gh.singleton<_i34.AddPointsToViewer>(_i34.AddPointsToViewer(
      profileCubit: get<_i21.ProfileCubit>(),
      updateProfileRepository: get<_i30.UpsertProfileRepository>()));
  gh.singleton<_i35.CreateGoal>(_i35.CreateGoal(
      goalsCubit: get<_i20.GoalsCubit>(),
      profileCubit: get<_i21.ProfileCubit>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      createGoalRepo: get<_i5.CreateGoalRepository>(),
      addPointsToUser: get<_i34.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i26.UniqueIdGenerator>(),
      useCaseExceptionHandler: get<_i31.UseCaseExceptionHandler>()));
  gh.lazySingleton<_i36.CreateTask>(() => _i36.CreateTask(
      tasksCubit: get<_i24.TasksCubit>(),
      profileCubit: get<_i21.ProfileCubit>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      addPointsToUser: get<_i34.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i26.UniqueIdGenerator>(),
      createTaskRepository: get<_i8.CreateTaskRepository>()));
  gh.factory<_i37.GetActiveQuests>(() => _i37.GetActiveQuests(
      getQuests: get<_i12.GetActiveQuestsRepository>(),
      uniqueIdGenerator: get<_i26.UniqueIdGenerator>(),
      activeQuestsCubit: get<_i3.ActiveQuestsCubit>()));
  gh.singleton<_i38.GetGoals>(_i38.GetGoals(
      goalsCubit: get<_i20.GoalsCubit>(),
      getGoalsRepo: get<_i13.GetGoalsRepository>(),
      useCaseExceptionHandler: get<_i31.UseCaseExceptionHandler>()));
  gh.singleton<_i39.GetProfile>(_i39.GetProfile(
      profileCubit: get<_i21.ProfileCubit>(),
      getProfileRepository: get<_i14.GetProfileRepository>()));
  gh.singleton<_i40.GetTasksDoneToday>(_i40.GetTasksDoneToday(
      tasksDoneTodayCubit: get<_i25.TasksDoneTodayCubit>(),
      exceptionHandler: get<_i31.UseCaseExceptionHandler>(),
      getTasksDoneTodayRepository: get<_i15.GetTasksDoneTodayRepository>()));
  gh.singleton<_i41.GetTasksToDo>(_i41.GetTasksToDo(
      getTasks: get<_i16.GetTasksToDoRepository>(),
      tasksCubit: get<_i24.TasksCubit>()));
  gh.lazySingleton<_i42.IncrementDailyStreak>(() => _i42.IncrementDailyStreak(
      profileCubit: get<_i21.ProfileCubit>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      tasksDoneTodayCubit: get<_i25.TasksDoneTodayCubit>(),
      updateProfile: get<_i30.UpsertProfileRepository>()));
  gh.singleton<_i43.LevelProgressPercentageCalculator>(
      _i43.LevelProgressPercentageCalculator(
          userLevelCalculator: get<_i32.UserLevelCalculator>(),
          experienceToReachALevelCalculator:
              get<_i33.ExperienceToReachNextLevelCalculator>()));
  gh.singleton<_i44.Logout>(_i44.Logout(
      tasksCubit: get<_i24.TasksCubit>(),
      profileCubit: get<_i21.ProfileCubit>(),
      firebaseAuth: get<_i45.FirebaseAuth>(),
      tasksDoneTodayCubit: get<_i25.TasksDoneTodayCubit>(),
      authentificationCubit: get<_i4.AuthentificationCubit>()));
  gh.lazySingleton<_i46.MakeStepForwardOnAGoal>(() =>
      _i46.MakeStepForwardOnAGoal(
          goalsCubit: get<_i20.GoalsCubit>(),
          profileCubit: get<_i21.ProfileCubit>(),
          updateGoalRepo: get<_i27.UpdateGoalRepository>(),
          updateProfileRepository: get<_i30.UpsertProfileRepository>()));
  gh.singleton<_i47.MakeStepForwardOnTheTask>(_i47.MakeStepForwardOnTheTask(
      tasksCubit: get<_i24.TasksCubit>(),
      updateTask: get<_i29.UpdateTaskRepository>(),
      profileCubit: get<_i21.ProfileCubit>(),
      goToMainPage: get<_i48.GoToMainPage>(),
      goToTaskPage: get<_i18.GoToTaskPage>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      updateProfile: get<_i30.UpsertProfileRepository>(),
      snackbarService: get<_i22.SnackbarService>(),
      addPointsToViewer: get<_i34.AddPointsToViewer>(),
      tasksDoneTodayCubit: get<_i25.TasksDoneTodayCubit>(),
      incrementDailyStreak: get<_i42.IncrementDailyStreak>(),
      nextRepetitionCalculator: get<_i49.NextRepetitionCalculator>()));
  gh.singleton<_i50.RejectTask>(_i50.RejectTask(
      tasksCubit: get<_i24.TasksCubit>(),
      goToMainPage: get<_i48.GoToMainPage>(),
      goToTaskPage: get<_i18.GoToTaskPage>(),
      snackbarService: get<_i22.SnackbarService>(),
      addPointsToUser: get<_i34.AddPointsToViewer>(),
      deleteTaskRepository: get<_i10.DeleteTaskRepository>()));
  gh.factory<_i51.SignInWithGoogle>(() => _i51.SignInWithGoogle(
      profileCubit: get<_i21.ProfileCubit>(),
      firebaseAuth: get<_i45.FirebaseAuth>(),
      uniqueIdGenerator: get<_i26.UniqueIdGenerator>(),
      getProfileRepository: get<_i14.GetProfileRepository>(),
      upsertProfileRepository: get<_i30.UpsertProfileRepository>(),
      useCaseExceptionHandler: get<_i31.UseCaseExceptionHandler>()));
  gh.singleton<_i52.UpdateTask>(_i52.UpdateTask(
      tasksCubit: get<_i24.TasksCubit>(),
      updateTaskRepository: get<_i29.UpdateTaskRepository>()));
  gh.singleton<_i53.UpdateTaskNote>(_i53.UpdateTaskNote(
      tasksCubit: get<_i24.TasksCubit>(),
      updateTaskRepository: get<_i29.UpdateTaskRepository>()));
  return get;
}
