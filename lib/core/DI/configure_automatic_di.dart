import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'configure_automatic_di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureAutomaticDI() => $initGetIt(getIt);
