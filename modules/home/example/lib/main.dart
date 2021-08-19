import 'package:flutter/material.dart';
import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:commons/commons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:home/app/home_module.dart';
import 'package:core/app/app_module.dart' as appModule;

import 'config/ui/theme/colors.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
      child: AppWidget(),
    ),
  );
}

class AppWidget extends StatelessWidget {
  const AppWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Example',
      theme: ThemeData(primarySwatch: Colors.blue),
    ).modular();
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var c = Modular.get<IAppController>();
    c.loadLangs().then((value) => Modular.to.navigate('/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AppModule extends Module {
  @override
  final List<Bind> binds = appModule.AppModule().binds;

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SplashScreen()),
    ModuleRoute('/home', module: HomeModule()),
  ];
}
