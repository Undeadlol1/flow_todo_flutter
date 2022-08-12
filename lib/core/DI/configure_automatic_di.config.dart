// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_context_provider/build_context_provider.dart' as _i19;
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i45;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/authentification/domain/entities/use_cases/logout.dart'
    as _i44;
import '../../features/authentification/domain/entities/use_cases/sign_in_with_google.dart'
    as _i47;
import '../../features/authentification/presentation/cubit/authentification_cubit.dart'
    as _i4;
import '../../features/common/domain/use_cases/go_to_main_page.dart' as _i55;
import '../../features/common/services/get_todays_date.dart' as _i17;
import '../../features/common/services/snackbar_service.dart' as _i23;
import '../../features/common/services/unique_id_generator.dart' as _i27;
import '../../features/goals/data/create_goal_repository.dart' as _i5;
import '../../features/goals/data/get_goals_repository.dart' as _i13;
import '../../features/goals/data/update_goal_repository.dart' as _i28;
import '../../features/goals/domain/use_cases/create_goal.dart' as _i52;
import '../../features/goals/domain/use_cases/get_goals.dart' as _i37;
import '../../features/goals/domain/use_cases/make_step_forward_on_a_goal.dart'
    as _i46;
import '../../features/goals/presentation/cubit/goals_cubit.dart' as _i20;
import '../../features/leveling/domain/services/experience_to_reach_next_level_calculator.dart'
    as _i34;
import '../../features/leveling/domain/services/level_progress_percentage_calculator.dart'
    as _i42;
import '../../features/leveling/domain/services/level_up_animation.dart'
    as _i43;
import '../../features/leveling/domain/services/user_level_calculator.dart'
    as _i33;
import '../../features/quests/data/create_quest_repository.dart' as _i7;
import '../../features/quests/data/delete_quest_repository.dart' as _i9;
import '../../features/quests/data/get_active_quests_repository.dart' as _i12;
import '../../features/quests/data/update_quest_repository.dart' as _i29;
import '../../features/quests/domain/use_cases/get_active_quests.dart' as _i36;
import '../../features/quests/presentation/cubits/active_quests_cubit.dart'
    as _i3;
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart'
    as _i56;
import '../../features/streaks/domain/services/streak_days_in_a_row_calculator.dart'
    as _i24;
import '../../features/streaks/domain/use_cases/increment_daily_streak_action.dart'
    as _i41;
import '../../features/tasks/data/create_task_repository.dart' as _i8;
import '../../features/tasks/data/delete_task_repository.dart' as _i10;
import '../../features/tasks/data/get_task_worked_on_today_repository.dart'
    as _i16;
import '../../features/tasks/data/get_tasks_to_do_repository.dart' as _i15;
import '../../features/tasks/data/update_task_repository.dart' as _i30;
import '../../features/tasks/domain/actions/work_on_task_action.dart' as _i35;
import '../../features/tasks/domain/use_cases/create_task.dart' as _i53;
import '../../features/tasks/domain/use_cases/get_tasks_to_do.dart' as _i39;
import '../../features/tasks/domain/use_cases/get_tasks_worked_on_today.dart'
    as _i40;
import '../../features/tasks/domain/use_cases/go_to_task_page.dart' as _i18;
import '../../features/tasks/domain/use_cases/make_step_forward_on_the_task.dart'
    as _i54;
import '../../features/tasks/domain/use_cases/reject_task.dart' as _i57;
import '../../features/tasks/domain/use_cases/toggle_task_selection.dart'
    as _i48;
import '../../features/tasks/domain/use_cases/update_task.dart' as _i49;
import '../../features/tasks/domain/use_cases/update_task_note.dart' as _i50;
import '../../features/tasks/presentation/cubit/filtered_tasks_cubit.dart'
    as _i11;
import '../../features/tasks/presentation/cubit/selected_tasks_cubit.dart'
    as _i22;
import '../../features/tasks/presentation/cubit/tasks_cubit.dart' as _i25;
import '../../features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart'
    as _i26;
import '../../features/users/data/get_profile_repository.dart' as _i14;
import '../../features/users/data/upsert_profile_repository.dart' as _i31;
import '../../features/users/domain/use_cases/add_points_to_viewer.dart'
    as _i51;
import '../../features/users/domain/use_cases/get_profile.dart' as _i38;
import '../../features/users/presentation/cubit/profile_cubit.dart' as _i21;
import '../services/use_case_exception_handler.dart'
    as _i32; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i18.GoToTaskPage>(() =>
      _i18.GoToTaskPage(provideContext: get<_i19.BuildContextProvider>()));
  gh.singleton<_i20.GoalsCubit>(_i20.GoalsCubit());
  gh.singleton<_i21.ProfileCubit>(_i21.ProfileCubit());
  gh.singleton<_i22.SelectedTasksCubit>(_i22.SelectedTasksCubit());
  gh.factory<_i23.SnackbarService>(() => _i23.SnackbarService(
      buildContextProvider: get<_i19.BuildContextProvider>()));
  gh.lazySingleton<_i24.StreakDaysInARowCalculator>(
      () => _i24.StreakDaysInARowCalculator());
  gh.singleton<_i25.TasksCubit>(_i25.TasksCubit());
  gh.singleton<_i26.TasksWorkedOnTodayCubit>(_i26.TasksWorkedOnTodayCubit());
  gh.singleton<_i27.UniqueIdGenerator>(_i27.UniqueIdGenerator());
  gh.lazySingleton<_i28.UpdateGoalRepository>(
      () => _i28.UpdateGoalRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i29.UpdateQuestRepository>(() =>
      _i29.UpdateQuestRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i30.UpdateTaskRepository>(
      () => _i30.UpdateTaskRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.factory<_i31.UpsertProfileRepository>(() =>
      _i31.UpsertProfileRepository(firestore: get<_i6.FirebaseFirestore>()));
  gh.singleton<_i32.UseCaseExceptionHandler>(_i32.UseCaseExceptionHandler(
      snackbarService: get<_i23.SnackbarService>()));
  gh.factory<_i33.UserLevelCalculator>(() => _i33.UserLevelCalculator(
      experienceToReachALevelCalculator:
          get<_i34.ExperienceToReachNextLevelCalculator>()));
  gh.factory<_i35.WorkOnTaskAction>(() => _i35.WorkOnTaskAction(
      tasksDoneTodayCubit: get<_i26.TasksWorkedOnTodayCubit>()));
  gh.factory<_i36.GetActiveQuests>(() => _i36.GetActiveQuests(
      getQuests: get<_i12.GetActiveQuestsRepository>(),
      uniqueIdGenerator: get<_i27.UniqueIdGenerator>(),
      activeQuestsCubit: get<_i3.ActiveQuestsCubit>(),
      createQuestRepository: get<_i7.CreateQuestRepository>()));
  gh.singleton<_i37.GetGoals>(_i37.GetGoals(
      goalsCubit: get<_i20.GoalsCubit>(),
      getGoalsRepo: get<_i13.GetGoalsRepository>(),
      useCaseExceptionHandler: get<_i32.UseCaseExceptionHandler>()));
  gh.singleton<_i38.GetProfile>(_i38.GetProfile(
      profileCubit: get<_i21.ProfileCubit>(),
      getProfileRepository: get<_i14.GetProfileRepository>(),
      useCaseExceptionHandler: get<_i32.UseCaseExceptionHandler>()));
  gh.singleton<_i39.GetTasksToDo>(_i39.GetTasksToDo(
      getTasks: get<_i15.GetTasksToDoRepository>(),
      tasksCubit: get<_i25.TasksCubit>(),
      exceptionHandler: get<_i32.UseCaseExceptionHandler>()));
  gh.singleton<_i40.GetTasksWorkedOnToday>(_i40.GetTasksWorkedOnToday(
      tasksDoneTodayCubit: get<_i26.TasksWorkedOnTodayCubit>(),
      exceptionHandler: get<_i32.UseCaseExceptionHandler>(),
      getTasksDoneTodayRepository:
          get<_i16.GetTasksWorkedOnTodayRepository>()));
  gh.lazySingleton<_i41.IncrementDailyStreakAction>(() =>
      _i41.IncrementDailyStreakAction(
          profileCubit: get<_i21.ProfileCubit>(),
          getTodaysDate: get<_i17.GetTodaysDate>(),
          tasksDoneTodayCubit: get<_i26.TasksWorkedOnTodayCubit>(),
          updateProfile: get<_i31.UpsertProfileRepository>()));
  gh.singleton<_i42.LevelProgressPercentageCalculator>(
      _i42.LevelProgressPercentageCalculator(
          userLevelCalculator: get<_i33.UserLevelCalculator>(),
          experienceToReachALevelCalculator:
              get<_i34.ExperienceToReachNextLevelCalculator>()));
  gh.factory<_i43.LevelUpAnimation>(() => _i43.LevelUpAnimation(
      userLevelCalculator: get<_i33.UserLevelCalculator>(),
      buildContextProvider: get<_i19.BuildContextProvider>()));
  gh.singleton<_i44.Logout>(_i44.Logout(
      tasksCubit: get<_i25.TasksCubit>(),
      profileCubit: get<_i21.ProfileCubit>(),
      firebaseAuth: get<_i45.FirebaseAuth>(),
      firebaseFirestore: get<_i6.FirebaseFirestore>(),
      tasksDoneTodayCubit: get<_i26.TasksWorkedOnTodayCubit>(),
      authentificationCubit: get<_i4.AuthentificationCubit>()));
  gh.lazySingleton<_i46.MakeStepForwardOnAGoal>(() =>
      _i46.MakeStepForwardOnAGoal(
          goalsCubit: get<_i20.GoalsCubit>(),
          profileCubit: get<_i21.ProfileCubit>(),
          updateGoalRepo: get<_i28.UpdateGoalRepository>(),
          updateProfileRepository: get<_i31.UpsertProfileRepository>()));
  gh.factory<_i47.SignInWithGoogle>(() => _i47.SignInWithGoogle(
      profileCubit: get<_i21.ProfileCubit>(),
      firebaseAuth: get<_i45.FirebaseAuth>(),
      uniqueIdGenerator: get<_i27.UniqueIdGenerator>(),
      getProfileRepository: get<_i14.GetProfileRepository>(),
      upsertProfileRepository: get<_i31.UpsertProfileRepository>(),
      useCaseExceptionHandler: get<_i32.UseCaseExceptionHandler>()));
  gh.factory<_i48.ToggleTaskSelection>(() => _i48.ToggleTaskSelection(
      tasksCubit: get<_i25.TasksCubit>(),
      updateTaskRepository: get<_i30.UpdateTaskRepository>()));
  gh.singleton<_i49.UpdateTask>(_i49.UpdateTask(
      tasksCubit: get<_i25.TasksCubit>(),
      updateTaskRepository: get<_i30.UpdateTaskRepository>()));
  gh.singleton<_i50.UpdateTaskNote>(_i50.UpdateTaskNote(
      tasksCubit: get<_i25.TasksCubit>(),
      updateTaskRepository: get<_i30.UpdateTaskRepository>()));
  gh.factory<_i51.AddPointsToViewer>(() => _i51.AddPointsToViewer(
      profileCubit: get<_i21.ProfileCubit>(),
      levelUpAnimation: get<_i43.LevelUpAnimation>(),
      userLevelCalculator: get<_i33.UserLevelCalculator>(),
      updateProfileRepository: get<_i31.UpsertProfileRepository>()));
  gh.singleton<_i52.CreateGoal>(_i52.CreateGoal(
      goalsCubit: get<_i20.GoalsCubit>(),
      profileCubit: get<_i21.ProfileCubit>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      createGoalRepo: get<_i5.CreateGoalRepository>(),
      addPointsToUser: get<_i51.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i27.UniqueIdGenerator>(),
      useCaseExceptionHandler: get<_i32.UseCaseExceptionHandler>()));
  gh.lazySingleton<_i53.CreateTask>(() => _i53.CreateTask(
      tasksCubit: get<_i25.TasksCubit>(),
      profileCubit: get<_i21.ProfileCubit>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      addPointsToUser: get<_i51.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i27.UniqueIdGenerator>(),
      createTaskRepository: get<_i8.CreateTaskRepository>()));
  gh.singleton<_i54.MakeStepForwardOnTheTask>(_i54.MakeStepForwardOnTheTask(
      tasksCubit: get<_i25.TasksCubit>(),
      updateTask: get<_i30.UpdateTaskRepository>(),
      profileCubit: get<_i21.ProfileCubit>(),
      goToMainPage: get<_i55.GoToMainPage>(),
      goToTaskPage: get<_i18.GoToTaskPage>(),
      getTodaysDate: get<_i17.GetTodaysDate>(),
      updateProfile: get<_i31.UpsertProfileRepository>(),
      snackbarService: get<_i23.SnackbarService>(),
      workOnTaskAction: get<_i35.WorkOnTaskAction>(),
      addPointsToViewer: get<_i51.AddPointsToViewer>(),
      tasksDoneTodayCubit: get<_i26.TasksWorkedOnTodayCubit>(),
      incrementDailyStreak: get<_i41.IncrementDailyStreakAction>(),
      nextRepetitionCalculator: get<_i56.NextRepetitionCalculator>()));
  gh.singleton<_i57.RejectTask>(_i57.RejectTask(
      tasksCubit: get<_i25.TasksCubit>(),
      goToMainPage: get<_i55.GoToMainPage>(),
      goToTaskPage: get<_i18.GoToTaskPage>(),
      snackbarService: get<_i23.SnackbarService>(),
      addPointsToUser: get<_i51.AddPointsToViewer>(),
      deleteTaskRepository: get<_i10.DeleteTaskRepository>()));
  return get;
}
