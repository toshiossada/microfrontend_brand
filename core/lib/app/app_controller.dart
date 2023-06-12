import 'package:commons_dependencies/commons_dependencies.dart';
import 'package:commons/shared/controllers/interfaces/app_controller_interface.dart';

class AppController implements IAppController {
  Future loadLangs() async {
    Localization.setTranslationDirectories([
      'packages/home/config/lang',
      'lib/config/lang',
    ]);
    await Localization.configuration();
  }
}
