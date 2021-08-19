import 'package:flutter_modular/flutter_modular.dart';
import 'presenter/pages/splash_controller.dart';
import 'presenter/pages/splash_page.dart';

class SplashModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SplashController(i())),
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const SplashPage()),
  ];
}
