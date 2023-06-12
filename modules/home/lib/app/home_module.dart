import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/enterprise_repository_interface.dart';
import 'domain/usecases/get_all_enterprise.dart';
import 'domain/usecases/interfaces/get_all_enterprise_interface.dart';
import 'infra/data/repositories/enterprise_repository.dart';
import 'presenter/pages/home/home_controller.dart';
import 'presenter/pages/home/home_page.dart';
import 'presenter/pages/home/home_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton<IGetAllEnterprise>((i) => GetAllEnterprise(i())),
    Bind.lazySingleton<IEnterpriseRepository>((i) => EnterpriseRepository()),
    Bind.lazySingleton((i) => HomeController(i(), i(), i())),
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
  ];
}
