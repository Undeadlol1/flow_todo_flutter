// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:build_context_provider/build_context_provider.dart' as _i13;
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i27;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/authentification/domain/entities/use_cases/logout.dart'
    as _i26;
import '../../features/authentification/presentation/cubit/authentification_cubit.dart'
    as _i3;
import '../../features/common/domain/use_cases/go_to_main_page.dart' as _i22;
import '../../features/common/services/get_todays_date.dart' as _i10;
import '../../features/common/services/snackbar_service.dart' as _i12;
import '../../features/common/services/unique_id_generator.dart' as _i16;
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart'
    as _i29;
import '../../features/tasks/data/create_task_repository.dart' as _i4;
import '../../features/tasks/data/delete_task_repository.dart' as _i6;
import '../../features/tasks/data/get_task_done_today_repository.dart' as _i8;
import '../../features/tasks/data/get_tasks_to_do_repository.dart' as _i9;
import '../../features/tasks/data/update_task_repository.dart' as _i18;
import '../../features/tasks/domain/use_cases/create_task.dart' as _i20;
import '../../features/tasks/domain/use_cases/delete_task.dart' as _i21;
import '../../features/tasks/domain/use_cases/get_tasks_done_today.dart'
    as _i25;
import '../../features/tasks/domain/use_cases/go_to_task_page.dart' as _i23;
import '../../features/tasks/domain/use_cases/make_step_forward_on_the_task.dart'
    as _i28;
import '../../features/tasks/domain/use_cases/update_task.dart' as _i30;
import '../../features/tasks/domain/use_cases/update_task_note.dart' as _i31;
import '../../features/tasks/presentation/cubit/tasks_cubit.dart' as _i14;
import '../../features/tasks/presentation/cubit/tasks_done_today_cubit.dart'
    as _i15;
import '../../features/users/data/get_profile_repository.dart' as _i7;
import '../../features/users/data/update_profile_repository.dart' as _i17;
import '../../features/users/domain/use_cases/add_points_to_viewer.dart'
    as _i19;
import '../../features/users/domain/use_cases/get_profile.dart' as _i24;
import '../../features/users/presentation/cubit/profile_cubit.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i7.GetProfileRepository>(
      _i7.GetProfileRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i8.GetTasksDoneTodayRepository>(
      _i8.GetTasksDoneTodayRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i9.GetTasksToDoRepository>(() =>
      _i9.GetTasksToDoRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i10.GetTodaysDate>(_i10.GetTodaysDate());
  gh.singleton<_i11.ProfileCubit>(_i11.ProfileCubit());
  gh.factory<_i12.SnackbarService>(() => _i12.SnackbarService(
      buildContextProvider: get<_i13.BuildContextProvider>()));
  gh.singleton<_i14.TasksCubit>(_i14.TasksCubit());
  gh.singleton<_i15.TasksDoneTodayCubit>(_i15.TasksDoneTodayCubit());
  gh.singleton<_i16.UniqueIdGenerator>(_i16.UniqueIdGenerator());
  gh.factory<_i17.UpdateProfileRepository>(() =>
      _i17.UpdateProfileRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i18.UpdateTaskRepository>(
      () => _i18.UpdateTaskRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i19.AddPointsToViewer>(_i19.AddPointsToViewer(
      profileCubit: get<_i11.ProfileCubit>(),
      updateProfileRepository: get<_i17.UpdateProfileRepository>()));
  gh.singleton<_i20.CreateTask>(_i20.CreateTask(
      tasksCubit: get<_i14.TasksCubit>(),
      profileCubit: get<_i11.ProfileCubit>(),
      getTodaysDate: get<_i10.GetTodaysDate>(),
      addPointsToUser: get<_i19.AddPointsToViewer>(),
      uniqueIdGenerator: get<_i16.UniqueIdGenerator>(),
      createTaskRepository: get<_i4.CreateTaskRepository>()));
  gh.singleton<_i21.DeleteTask>(_i21.DeleteTask(
      tasksCubit: get<_i14.TasksCubit>(),
      goToMainPage: get<_i22.GoToMainPage>(),
      goToTaskPage: get<_i23.GoToTaskPage>(),
      snackbarService: get<_i12.SnackbarService>(),
      addPointsToUser: get<_i19.AddPointsToViewer>(),
      deleteTaskRepository: get<_i6.DeleteTaskRepository>()));
  gh.singleton<_i24.GetProfile>(_i24.GetProfile(
      profileCubit: get<_i11.ProfileCubit>(),
      getProfileRepository: get<_i7.GetProfileRepository>()));
  gh.singleton<_i25.GetTasksDoneToday>(_i25.GetTasksDoneToday(
      tasksDoneTodayCubit: get<_i15.TasksDoneTodayCubit>(),
      getTasksDoneTodayRepository: get<_i8.GetTasksDoneTodayRepository>()));
  gh.singleton<_i26.Logout>(_i26.Logout(
      tasksCubit: get<_i14.TasksCubit>(),
      profileCubit: get<_i11.ProfileCubit>(),
      firebaseAuth: get<_i27.FirebaseAuth>(),
      authentificationCubit: get<_i3.AuthentificationCubit>()));
  gh.singleton<_i28.MakeStepForwardOnTheTask>(_i28.MakeStepForwardOnTheTask(
      tasksCubit: get<_i14.TasksCubit>(),
      profileCubit: get<_i11.ProfileCubit>(),
      goToMainPage: get<_i22.GoToMainPage>(),
      goToTaskPage: get<_i23.GoToTaskPage>(),
      getTodaysDate: get<_i10.GetTodaysDate>(),
      snackbarService: get<_i12.SnackbarService>(),
      addPointsToViewer: get<_i19.AddPointsToViewer>(),
      tasksDoneTodayCubit: get<_i15.TasksDoneTodayCubit>(),
      updateTaskRepository: get<_i18.UpdateTaskRepository>(),
      updateProfileRepository: get<_i17.UpdateProfileRepository>(),
      nextRepetitionCalculator: get<_i29.NextRepetitionCalculator>()));
  gh.singleton<_i30.UpdateTask>(_i30.UpdateTask(
      tasksCubit: get<_i14.TasksCubit>(),
      updateTaskRepository: get<_i18.UpdateTaskRepository>()));
  gh.singleton<_i31.UpdateTaskNote>(_i31.UpdateTaskNote(
      tasksCubit: get<_i14.TasksCubit>(),
      updateTaskRepository: get<_i18.UpdateTaskRepository>()));
  return get;
}
