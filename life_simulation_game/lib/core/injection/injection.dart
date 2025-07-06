import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:life_simulation_game/core/injection/injection.config.dart';

/// GetIt instance for dependency injection
final getIt = GetIt.instance;

/// Configure dependencies using Injectable
@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
}

/// Reset dependencies (useful for testing)
void resetDependencies() {
  getIt.reset();
}