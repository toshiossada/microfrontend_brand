import 'package:commons/shared/controllers/interfaces/app_controller_interface.dart';
import 'package:commons/shared/custom_dio/custom_dio.dart';
import 'package:commons/shared/theme/base_colors.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:home/app/home_module.dart';
import 'package:minha_app/config/ui/theme/colors.dart';
import 'package:splash/app/splash_module.dart';
import 'package:dio/dio.dart';

import 'app_controller.dart';

class AppModule extends Module {
  AppModule() {}
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<IAppController>((i) => AppController()),
    Bind.lazySingleton((i) => (i) => CustomDio(i())),
    Bind.lazySingleton((i) => BaseOptions(
          baseUrl: '',
          connectTimeout: 5000,
        )),
    Bind.lazySingleton<BaseAppColors>((i) => AppColors()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
  ];
}
