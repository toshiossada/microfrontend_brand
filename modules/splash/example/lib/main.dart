import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:core/app/app_module.dart' as appModule;
import 'package:splash/app/splash_module.dart';

void main() => runApp(
      ModularApp(
        module: AppModule(),
        child: AppWidget(),
      ),
    );

class AppWidget extends StatelessWidget {
  const AppWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Example',
      theme: ThemeData(primarySwatch: Colors.blue),
    ).modular();
  }
}

class AppModule extends Module {
  @override
  final List<Bind> binds = appModule.AppModule().binds;

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/home', child: (_, args) => Container(color: Colors.red)),
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
  ];
}
