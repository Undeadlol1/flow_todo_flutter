// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:build_context_provider/build_context_provider.dart' as _i16;
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i30;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/authentification/domain/entities/use_cases/logout.dart'
    as _i29;
import '../../features/authentification/presentation/cubit/authentification_cubit.dart'
    as _i3;
import '../../features/common/domain/use_cases/go_to_main_page.dart' as _i32;
import '../../features/common/services/get_todays_date.dart' as _i12;
import '../../features/common/services/snackbar_service.dart' as _i15;
import '../../features/common/services/unique_id_generator.dart' as _i19;
import '../../features/goals/data/create_goal_repository.dart' as _i4;
import '../../features/goals/data/get_goals_repository.dart' as _i8;
import '../../features/goals/domain/use_cases/create_goal.dart' as _i24;
import '../../features/goals/domain/use_cases/get_goals.dart' as _i26;
import '../../features/goals/presentation/cubit/goals_cubit.dart' as _i13;
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart'
    as _i34;
import '../../features/tasks/data/create_task_repository.dart' as _i6;
import '../../features/tasks/data/delete_task_repository.dart' as _i7;
import '../../features/tasks/data/get_task_done_today_repository.dart' as _i10;
import '../../features/tasks/data/get_tasks_to_do_repository.dart' as _i11;
import '../../features/tasks/data/update_task_repository.dart' as _i21;
import '../../features/tasks/domain/use_cases/create_task.dart' as _i25;
import '../../features/tasks/domain/use_cases/get_tasks_done_today.dart'
    as _i28;
import '../../features/tasks/domain/use_cases/go_to_task_page.dart' as _i33;
import '../../features/tasks/domain/use_cases/make_step_forward_on_the_task.dart'
    as _i31;
import '../../features/tasks/domain/use_cases/reject_task.dart' as _i35;
import '../../features/tasks/domain/use_cases/update_task.dart' as _i36;
import '../../features/tasks/domain/use_cases/update_task_note.dart' as _i37;
import '../../features/tasks/presentation/cubit/tasks_cubit.dart' as _i17;
import '../../features/tasks/presentation/cubit/tasks_done_today_cubit.dart'
    as _i18;
import '../../features/users/data/get_profile_repository.dart' as _i9;
import '../../features/users/data/update_profile_repository.dart' as _i20;
import '../../features/users/domain/use_cases/add_points_to_viewer.dart'
    as _i23;
import '../../features/users/domain/use_cases/get_profile.dart' as _i27;
import '../../features/users/presentation/cubit/profile_cubit.dart' as _i14;
import '../services/use_case_exception_handler.dart'
    as _i22; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i8.GetGoalsRepository>(
      _i8.GetGoalsRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i9.GetProfileRepository>(
      _i9.GetProfileRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i10.GetTasksDoneTodayRepository>(
      _i10.GetTasksDoneTodayRepository(
          firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i11.GetTasksToDoRepository>(() =>
      _i11.GetTasksToDoRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i12.GetTodaysDate>(_i12.GetTodaysDate());
  gh.singleton<_i13.GoalsCubit>(_i13.GoalsCubit());
  gh.singleton<_i14.ProfileCubit>(_i14.ProfileCubit());
  gh.factory<_i15.SnackbarService>(() => _i15.SnackbarService(
      buildContextProvider: get<_i16.BuildContextProvider>()));
  gh.singleton<_i17.TasksCubit>(_i17.TasksCubit());
  gh.singleton<_i18.TasksDoneTodayCubit>(_i18.TasksDoneTodayCubit());
  gh.singleton<_i19.UniqueIdGenerator>(_i19.UniqueIdGenerator());
  gh.factory<_i20.UpdateProfileRepository>(() =>
      _i20.UpdateProfileRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i21.UpdateTaskRepository>(
      () => _i21.UpdateTaskRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i22.UseCaseExceptionHandler>(_i22.UseCaseExceptionHandler(
      snackbarService: get<_i15.SnackbarService>()));
  gh.singleton<_i23.AddPointsToViewer>(_i23.AddPointsToViewer(
      profileCubit: get<_i14.ProfileCubit>(),
      updateProfileRepository: get<_i20.UpdateProfileRepository>()));
  gh.singleton<_i24.CreateGoal>(_i24.CreateGoal(
      goalsCubit: get<_i13.GoalsCubit>(),
      profileCubit: get<_i14.ProfileCubit>(),
      getTodaysDate: get<_i12.GetTodaysDate>(),
      createGoalRepo: get<_i4.CreateGoalRepository>(),
      addPointsToUser: get<_i23.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i19.UniqueIdGenerator>(),
      useCaseExceptionHandler: get<_i22.UseCaseExceptionHandler>()));
  gh.singleton<_i25.CreateTask>(_i25.CreateTask(
      tasksCubit: get<_i17.TasksCubit>(),
      profileCubit: get<_i14.ProfileCubit>(),
      getTodaysDate: get<_i12.GetTodaysDate>(),
      addPointsToUser: get<_i23.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i19.UniqueIdGenerator>(),
      createTaskRepository: get<_i6.CreateTaskRepository>()));
  gh.singleton<_i26.GetGoals>(_i26.GetGoals(
      goalsCubit: get<_i13.GoalsCubit>(),
      getGoalsRepo: get<_i8.GetGoalsRepository>(),
      useCaseExceptionHandler: get<_i22.UseCaseExceptionHandler>()));
  gh.singleton<_i27.GetProfile>(_i27.GetProfile(
      profileCubit: get<_i14.ProfileCubit>(),
      getProfileRepository: get<_i9.GetProfileRepository>()));
  gh.singleton<_i28.GetTasksDoneToday>(_i28.GetTasksDoneToday(
      tasksDoneTodayCubit: get<_i18.TasksDoneTodayCubit>(),
      exceptionHandler: get<_i22.UseCaseExceptionHandler>(),
      getTasksDoneTodayRepository: get<_i10.GetTasksDoneTodayRepository>()));
  gh.singleton<_i29.Logout>(_i29.Logout(
      tasksCubit: get<_i17.TasksCubit>(),
      profileCubit: get<_i14.ProfileCubit>(),
      firebaseAuth: get<_i30.FirebaseAuth>(),
      authentificationCubit: get<_i3.AuthentificationCubit>()));
  gh.singleton<_i31.MakeStepForwardOnTheTask>(_i31.MakeStepForwardOnTheTask(
      tasksCubit: get<_i17.TasksCubit>(),
      profileCubit: get<_i14.ProfileCubit>(),
      goToMainPage: get<_i32.GoToMainPage>(),
      goToTaskPage: get<_i33.GoToTaskPage>(),
      getTodaysDate: get<_i12.GetTodaysDate>(),
      snackbarService: get<_i15.SnackbarService>(),
      addPointsToViewer: get<_i23.AddPointsToViewer>(),
      tasksDoneTodayCubit: get<_i18.TasksDoneTodayCubit>(),
      updateTaskRepository: get<_i21.UpdateTaskRepository>(),
      updateProfileRepository: get<_i20.UpdateProfileRepository>(),
      nextRepetitionCalculator: get<_i34.NextRepetitionCalculator>()));
  gh.singleton<_i35.RejectTask>(_i35.RejectTask(
      tasksCubit: get<_i17.TasksCubit>(),
      goToMainPage: get<_i32.GoToMainPage>(),
      goToTaskPage: get<_i33.GoToTaskPage>(),
      snackbarService: get<_i15.SnackbarService>(),
      addPointsToUser: get<_i23.AddPointsToViewer>(),
      deleteTaskRepository: get<_i7.DeleteTaskRepository>()));
  gh.singleton<_i36.UpdateTask>(_i36.UpdateTask(
      tasksCubit: get<_i17.TasksCubit>(),
      updateTaskRepository: get<_i21.UpdateTaskRepository>()));
  gh.singleton<_i37.UpdateTaskNote>(_i37.UpdateTaskNote(
      tasksCubit: get<_i17.TasksCubit>(),
      updateTaskRepository: get<_i21.UpdateTaskRepository>()));
  return get;
}
