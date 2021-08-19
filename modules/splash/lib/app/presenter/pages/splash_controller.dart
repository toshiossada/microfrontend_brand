import 'package:commons/shared/controllers/interfaces/app_controller_interface.dart';
import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashController {
  final IAppController appController;
  SplashController(this.appController) {
    load();
  }

  Future<void> load() async {
    await appController.loadLangs();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Modular.to.navigate('/home');
    });
  }
}
