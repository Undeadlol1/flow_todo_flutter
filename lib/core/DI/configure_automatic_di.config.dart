// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:build_context_provider/build_context_provider.dart' as _i21;
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i41;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/authentification/domain/entities/use_cases/logout.dart'
    as _i40;
import '../../features/authentification/presentation/cubit/authentification_cubit.dart'
    as _i4;
import '../../features/common/domain/use_cases/go_to_main_page.dart' as _i44;
import '../../features/common/services/get_todays_date.dart' as _i17;
import '../../features/common/services/snackbar_service.dart' as _i20;
import '../../features/common/services/unique_id_generator.dart' as _i25;
import '../../features/goals/data/create_goal_repository.dart' as _i5;
import '../../features/goals/data/get_goals_repository.dart' as _i13;
import '../../features/goals/data/update_goal_repository.dart' as _i26;
import '../../features/goals/domain/use_cases/create_goal.dart' as _i32;
import '../../features/goals/domain/use_cases/get_goals.dart' as _i35;
import '../../features/goals/domain/use_cases/make_step_forward_on_a_goal.dart'
    as _i42;
import '../../features/goals/presentation/cubit/goals_cubit.dart' as _i18;
import '../../features/quests/data/create_quest_repository.dart' as _i7;
import '../../features/quests/data/delete_quest_repository.dart' as _i9;
import '../../features/quests/data/get_active_quests_repository.dart' as _i12;
import '../../features/quests/data/update_quest_repository.dart' as _i28;
import '../../features/quests/domain/use_cases/get_active_quests.dart' as _i34;
import '../../features/quests/presentation/cubits/active_quests_cubit.dart'
    as _i3;
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart'
    as _i46;
import '../../features/streaks/domain/services/streak_days_in_a_row_calculator.dart'
    as _i22;
import '../../features/streaks/domain/use_cases/increment_daily_streak.dart'
    as _i39;
import '../../features/tasks/data/create_task_repository.dart' as _i8;
import '../../features/tasks/data/delete_task_repository.dart' as _i10;
import '../../features/tasks/data/get_task_done_today_repository.dart' as _i15;
import '../../features/tasks/data/get_tasks_to_do_repository.dart' as _i16;
import '../../features/tasks/data/update_task_repository.dart' as _i29;
import '../../features/tasks/domain/use_cases/create_task.dart' as _i33;
import '../../features/tasks/domain/use_cases/get_tasks_done_today.dart'
    as _i37;
import '../../features/tasks/domain/use_cases/get_tasks_to_do.dart' as _i38;
import '../../features/tasks/domain/use_cases/go_to_task_page.dart' as _i45;
import '../../features/tasks/domain/use_cases/make_step_forward_on_the_task.dart'
    as _i43;
import '../../features/tasks/domain/use_cases/reject_task.dart' as _i47;
import '../../features/tasks/domain/use_cases/update_task.dart' as _i48;
import '../../features/tasks/domain/use_cases/update_task_note.dart' as _i49;
import '../../features/tasks/presentation/cubit/filtered_tasks_cubit.dart'
    as _i11;
import '../../features/tasks/presentation/cubit/tasks_cubit.dart' as _i23;
import '../../features/tasks/presentation/cubit/tasks_done_today_cubit.dart'
    as _i24;
import '../../features/users/data/get_profile_repository.dart' as _i14;
import '../../features/users/data/update_profile_repository.dart' as _i27;
import '../../features/users/domain/use_cases/add_points_to_viewer.dart'
    as _i31;
import '../../features/users/domain/use_cases/get_profile.dart' as _i36;
import '../../features/users/presentation/cubit/profile_cubit.dart' as _i19;
import '../services/use_case_exception_handler.dart'
    as _i30; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ActiveQuestsCubit>(() => _i3.ActiveQuestsCubit());
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
  gh.singleton<_i18.GoalsCubit>(_i18.GoalsCubit());
  gh.singleton<_i19.ProfileCubit>(_i19.ProfileCubit());
  gh.factory<_i20.SnackbarService>(() => _i20.SnackbarService(
      buildContextProvider: get<_i21.BuildContextProvider>()));
  gh.lazySingleton<_i22.StreakDaysInARowCalculator>(
      () => _i22.StreakDaysInARowCalculator());
  gh.singleton<_i23.TasksCubit>(_i23.TasksCubit());
  gh.singleton<_i24.TasksDoneTodayCubit>(_i24.TasksDoneTodayCubit());
  gh.singleton<_i25.UniqueIdGenerator>(_i25.UniqueIdGenerator());
  gh.lazySingleton<_i26.UpdateGoalRepository>(
      () => _i26.UpdateGoalRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i27.UpdateProfileRepository>(() =>
      _i27.UpdateProfileRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i28.UpdateQuestRepository>(() =>
      _i28.UpdateQuestRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i29.UpdateTaskRepository>(
      () => _i29.UpdateTaskRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.singleton<_i30.UseCaseExceptionHandler>(_i30.UseCaseExceptionHandler(
      snackbarService: get<_i20.SnackbarService>()));
  gh.singleton<_i31.AddPointsToViewer>(_i31.AddPointsToViewer(
      profileCubit: get<_i19.ProfileCubit>(),
      updateProfileRepository: get<_i27.UpdateProfileRepository>()));
  gh.singleton<_i32.CreateGoal>(_i32.CreateGoal(
      goalsCubit: get<_i18.GoalsCubit>(),
      profileCubit: get<_i19.ProfileCubit>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      createGoalRepo: get<_i5.CreateGoalRepository>(),
      addPointsToUser: get<_i31.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i25.UniqueIdGenerator>(),
      useCaseExceptionHandler: get<_i30.UseCaseExceptionHandler>()));
  gh.lazySingleton<_i33.CreateTask>(() => _i33.CreateTask(
      tasksCubit: get<_i23.TasksCubit>(),
      profileCubit: get<_i19.ProfileCubit>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      addPointsToUser: get<_i31.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i25.UniqueIdGenerator>(),
      createTaskRepository: get<_i8.CreateTaskRepository>()));
  gh.factory<_i34.GetActiveQuests>(() => _i34.GetActiveQuests(
      getQuests: get<_i12.GetActiveQuestsRepository>(),
      activeQuestsCubit: get<_i3.ActiveQuestsCubit>()));
  gh.singleton<_i35.GetGoals>(_i35.GetGoals(
      goalsCubit: get<_i18.GoalsCubit>(),
      getGoalsRepo: get<_i13.GetGoalsRepository>(),
      useCaseExceptionHandler: get<_i30.UseCaseExceptionHandler>()));
  gh.singleton<_i36.GetProfile>(_i36.GetProfile(
      profileCubit: get<_i19.ProfileCubit>(),
      getProfileRepository: get<_i14.GetProfileRepository>()));
  gh.singleton<_i37.GetTasksDoneToday>(_i37.GetTasksDoneToday(
      tasksDoneTodayCubit: get<_i24.TasksDoneTodayCubit>(),
      exceptionHandler: get<_i30.UseCaseExceptionHandler>(),
      getTasksDoneTodayRepository: get<_i15.GetTasksDoneTodayRepository>()));
  gh.singleton<_i38.GetTasksToDo>(_i38.GetTasksToDo(
      getTasks: get<_i16.GetTasksToDoRepository>(),
      tasksCubit: get<_i23.TasksCubit>()));
  gh.lazySingleton<_i39.IncrementDailyStreak>(() => _i39.IncrementDailyStreak(
      profileCubit: get<_i19.ProfileCubit>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      tasksDoneTodayCubit: get<_i24.TasksDoneTodayCubit>(),
      updateProfile: get<_i27.UpdateProfileRepository>()));
  gh.singleton<_i40.Logout>(_i40.Logout(
      tasksCubit: get<_i23.TasksCubit>(),
      profileCubit: get<_i19.ProfileCubit>(),
      firebaseAuth: get<_i41.FirebaseAuth>(),
      tasksDoneTodayCubit: get<_i24.TasksDoneTodayCubit>(),
      authentificationCubit: get<_i4.AuthentificationCubit>()));
  gh.lazySingleton<_i42.MakeStepForwardOnAGoal>(() =>
      _i42.MakeStepForwardOnAGoal(
          goalsCubit: get<_i18.GoalsCubit>(),
          profileCubit: get<_i19.ProfileCubit>(),
          updateGoalRepo: get<_i26.UpdateGoalRepository>(),
          updateProfileRepository: get<_i27.UpdateProfileRepository>()));
  gh.singleton<_i43.MakeStepForwardOnTheTask>(_i43.MakeStepForwardOnTheTask(
      tasksCubit: get<_i23.TasksCubit>(),
      updateTask: get<_i29.UpdateTaskRepository>(),
      profileCubit: get<_i19.ProfileCubit>(),
      goToMainPage: get<_i44.GoToMainPage>(),
      goToTaskPage: get<_i45.GoToTaskPage>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      updateProfile: get<_i27.UpdateProfileRepository>(),
      snackbarService: get<_i20.SnackbarService>(),
      addPointsToViewer: get<_i31.AddPointsToViewer>(),
      tasksDoneTodayCubit: get<_i24.TasksDoneTodayCubit>(),
      incrementDailyStreak: get<_i39.IncrementDailyStreak>(),
      nextRepetitionCalculator: get<_i46.NextRepetitionCalculator>()));
  gh.singleton<_i47.RejectTask>(_i47.RejectTask(
      tasksCubit: get<_i23.TasksCubit>(),
      goToMainPage: get<_i44.GoToMainPage>(),
      goToTaskPage: get<_i45.GoToTaskPage>(),
      snackbarService: get<_i20.SnackbarService>(),
      addPointsToUser: get<_i31.AddPointsToViewer>(),
      deleteTaskRepository: get<_i10.DeleteTaskRepository>()));
  gh.singleton<_i48.UpdateTask>(_i48.UpdateTask(
      tasksCubit: get<_i23.TasksCubit>(),
      updateTaskRepository: get<_i29.UpdateTaskRepository>()));
  gh.singleton<_i49.UpdateTaskNote>(_i49.UpdateTaskNote(
      tasksCubit: get<_i23.TasksCubit>(),
      updateTaskRepository: get<_i29.UpdateTaskRepository>()));
  return get;
}
