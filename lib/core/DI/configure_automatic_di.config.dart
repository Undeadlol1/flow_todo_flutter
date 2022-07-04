// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:build_context_provider/build_context_provider.dart' as _i15;
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i31;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/authentification/domain/entities/use_cases/logout.dart'
    as _i30;
import '../../features/authentification/presentation/cubit/authentification_cubit.dart'
    as _i3;
import '../../features/common/domain/use_cases/go_to_main_page.dart' as _i25;
import '../../features/common/services/get_todays_date.dart' as _i11;
import '../../features/common/services/snackbar_service.dart' as _i14;
import '../../features/common/services/unique_id_generator.dart' as _i18;
import '../../features/goals/data/get_goals_repository.dart' as _i7;
import '../../features/goals/domain/use_cases/get_goals.dart' as _i27;
import '../../features/goals/presentation/cubit/goals_cubit.dart' as _i12;
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart'
    as _i33;
import '../../features/tasks/data/create_task_repository.dart' as _i4;
import '../../features/tasks/data/delete_task_repository.dart' as _i6;
import '../../features/tasks/data/get_task_done_today_repository.dart' as _i9;
import '../../features/tasks/data/get_tasks_to_do_repository.dart' as _i10;
import '../../features/tasks/data/update_task_repository.dart' as _i20;
import '../../features/tasks/domain/use_cases/create_task.dart' as _i23;
import '../../features/tasks/domain/use_cases/delete_task.dart' as _i24;
import '../../features/tasks/domain/use_cases/get_tasks_done_today.dart'
    as _i29;
import '../../features/tasks/domain/use_cases/go_to_task_page.dart' as _i26;
import '../../features/tasks/domain/use_cases/make_step_forward_on_the_task.dart'
    as _i32;
import '../../features/tasks/domain/use_cases/update_task.dart' as _i34;
import '../../features/tasks/domain/use_cases/update_task_note.dart' as _i35;
import '../../features/tasks/presentation/cubit/tasks_cubit.dart' as _i16;
import '../../features/tasks/presentation/cubit/tasks_done_today_cubit.dart'
    as _i17;
import '../../features/users/data/get_profile_repository.dart' as _i8;
import '../../features/users/data/update_profile_repository.dart' as _i19;
import '../../features/users/domain/use_cases/add_points_to_viewer.dart'
    as _i22;
import '../../features/users/domain/use_cases/get_profile.dart' as _i28;
import '../../features/users/presentation/cubit/profile_cubit.dart' as _i13;
import '../services/use_case_exception_handler.dart'
    as _i21; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.AuthentificationCubit>(_i3.AuthentificationCubit());
  gh.factory<_i4.CreateTaskRepository>(
      () => _i4.CreateTaskRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i6.DeleteTaskRepository>(
      () => _i6.DeleteTaskRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i7.GetGoalsRepository>(
      _i7.GetGoalsRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i8.GetProfileRepository>(
      _i8.GetProfileRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i9.GetTasksDoneTodayRepository>(
      _i9.GetTasksDoneTodayRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i10.GetTasksToDoRepository>(() =>
      _i10.GetTasksToDoRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i11.GetTodaysDate>(_i11.GetTodaysDate());
  gh.singleton<_i12.GoalsCubit>(_i12.GoalsCubit());
  gh.singleton<_i13.ProfileCubit>(_i13.ProfileCubit());
  gh.factory<_i14.SnackbarService>(() => _i14.SnackbarService(
      buildContextProvider: get<_i15.BuildContextProvider>()));
  gh.singleton<_i16.TasksCubit>(_i16.TasksCubit());
  gh.singleton<_i17.TasksDoneTodayCubit>(_i17.TasksDoneTodayCubit());
  gh.singleton<_i18.UniqueIdGenerator>(_i18.UniqueIdGenerator());
  gh.factory<_i19.UpdateProfileRepository>(() =>
      _i19.UpdateProfileRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i20.UpdateTaskRepository>(
      () => _i20.UpdateTaskRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i21.UseCaseExceptionHandler>(_i21.UseCaseExceptionHandler(
      snackbarService: get<_i14.SnackbarService>()));
  gh.singleton<_i22.AddPointsToViewer>(_i22.AddPointsToViewer(
      profileCubit: get<_i13.ProfileCubit>(),
      updateProfileRepository: get<_i19.UpdateProfileRepository>()));
  gh.singleton<_i23.CreateTask>(_i23.CreateTask(
      tasksCubit: get<_i16.TasksCubit>(),
      profileCubit: get<_i13.ProfileCubit>(),
      getTodaysDate: get<_i11.GetTodaysDate>(),
      addPointsToUser: get<_i22.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i18.UniqueIdGenerator>(),
      createTaskRepository: get<_i4.CreateTaskRepository>()));
  gh.singleton<_i24.DeleteTask>(_i24.DeleteTask(
      tasksCubit: get<_i16.TasksCubit>(),
      goToMainPage: get<_i25.GoToMainPage>(),
      goToTaskPage: get<_i26.GoToTaskPage>(),
      snackbarService: get<_i14.SnackbarService>(),
      addPointsToUser: get<_i22.AddPointsToViewer>(),
      deleteTaskRepository: get<_i6.DeleteTaskRepository>()));
  gh.singleton<_i27.GetGoals>(_i27.GetGoals(
      goalsCubit: get<_i12.GoalsCubit>(),
      getGoalsRepo: get<_i7.GetGoalsRepository>(),
      useCaseExceptionHandler: get<_i21.UseCaseExceptionHandler>()));
  gh.singleton<_i28.GetProfile>(_i28.GetProfile(
      profileCubit: get<_i13.ProfileCubit>(),
      getProfileRepository: get<_i8.GetProfileRepository>()));
  gh.singleton<_i29.GetTasksDoneToday>(_i29.GetTasksDoneToday(
      tasksDoneTodayCubit: get<_i17.TasksDoneTodayCubit>(),
      getTasksDoneTodayRepository: get<_i9.GetTasksDoneTodayRepository>()));
  gh.singleton<_i30.Logout>(_i30.Logout(
      tasksCubit: get<_i16.TasksCubit>(),
      profileCubit: get<_i13.ProfileCubit>(),
      firebaseAuth: get<_i31.FirebaseAuth>(),
      authentificationCubit: get<_i3.AuthentificationCubit>()));
  gh.singleton<_i32.MakeStepForwardOnTheTask>(_i32.MakeStepForwardOnTheTask(
      tasksCubit: get<_i16.TasksCubit>(),
      profileCubit: get<_i13.ProfileCubit>(),
      goToMainPage: get<_i25.GoToMainPage>(),
      goToTaskPage: get<_i26.GoToTaskPage>(),
      getTodaysDate: get<_i11.GetTodaysDate>(),
      snackbarService: get<_i14.SnackbarService>(),
      addPointsToViewer: get<_i22.AddPointsToViewer>(),
      tasksDoneTodayCubit: get<_i17.TasksDoneTodayCubit>(),
      updateTaskRepository: get<_i20.UpdateTaskRepository>(),
      updateProfileRepository: get<_i19.UpdateProfileRepository>(),
      nextRepetitionCalculator: get<_i33.NextRepetitionCalculator>()));
  gh.singleton<_i34.UpdateTask>(_i34.UpdateTask(
      tasksCubit: get<_i16.TasksCubit>(),
      updateTaskRepository: get<_i20.UpdateTaskRepository>()));
  gh.singleton<_i35.UpdateTaskNote>(_i35.UpdateTaskNote(
      tasksCubit: get<_i16.TasksCubit>(),
      updateTaskRepository: get<_i20.UpdateTaskRepository>()));
  return get;
}
