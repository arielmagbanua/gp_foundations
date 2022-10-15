import 'package:get_it/get_it.dart';

import 'features/user/presentation/cubits/authentication_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // blocs and cubits
  sl.registerSingleton(() => AuthenticationCubit());
}
