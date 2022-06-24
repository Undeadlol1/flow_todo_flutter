// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:build_context_provider/build_context_provider.dart' as _i12;
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../features/authentification/presentation/cubit/authentification_cubit.dart'
    as _i3;
import '../features/common/services/get_todays_date.dart' as _i9;
import '../features/common/services/snackbar_service.dart' as _i11;
import '../features/tasks/data/create_task_repository.dart' as _i4;
import '../features/tasks/data/delete_task_repository.dart' as _i6;
import '../features/tasks/data/get_tasks_to_do_repository.dart' as _i8;
import '../features/tasks/data/update_task_repository.dart' as _i16;
import '../features/tasks/presentation/cubit/tasks_cubit.dart' as _i13;
import '../features/tasks/presentation/cubit/tasks_done_today_cubit.dart'
    as _i14;
import '../features/users/data/get_profile_repository.dart' as _i7;
import '../features/users/data/update_profile_repository.dart' as _i15;
import '../features/users/presentation/cubit/profile_cubit.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i7.GetProfileRepository>(
      () => _i7.GetProfileRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i8.GetTasksToDoRepository>(() =>
      _i8.GetTasksToDoRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.singleton<_i9.GetTodaysDate>(_i9.GetTodaysDate());
  gh.singleton<_i10.ProfileCubit>(_i10.ProfileCubit());
  gh.factory<_i11.SnackbarService>(() => _i11.SnackbarService(
      buildContextProvider: get<_i12.BuildContextProvider>()));
  gh.singleton<_i13.TasksCubit>(_i13.TasksCubit());
  gh.singleton<_i14.TasksDoneTodayCubit>(_i14.TasksDoneTodayCubit());
  gh.factory<_i15.UpdateProfileRepository>(() =>
      _i15.UpdateProfileRepository(firestore: get<_i5.FirebaseFirestore>()));
  gh.factory<_i16.UpdateTaskRepository>(
      () => _i16.UpdateTaskRepository(firestore: get<_i5.FirebaseFirestore>()));
  return get;
}
