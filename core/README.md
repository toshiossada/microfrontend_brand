# core
![image](https://user-images.githubusercontent.com/2637049/129375785-3291f0d3-d471-49be-8d7c-e82e08afab9b.png)

O core é o coração do nosso app, ele fará a ponte de conversa entre o  **base_app**  e os  **módulos**  é nele que estará a configuração das rotas principais e a chamada para o  **MaterialApp()**

# app_widget.dart
Aqui será o **widget** responsável por chamar o `MaterialApp` e todas as configurações do **modular**.
```dart
class AppWidget extends StatelessWidget {
  const AppWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App B2C',
      theme: ThemeData(primarySwatch: Colors.blue),
    ).modular();
  }
}
```
#	app_module.dart
Esta é a classe responsável por configurações  de rotas e dependências globais do aplicativo, ele recebera por construtor as injeções referente ao `white-label`.
```dart
class AppModule extends Module {
  final List<Bind> injectableBinds;

  AppModule({
    this.injectableBinds = const [],
  }) {
    if (injectableBinds.isNotEmpty) binds.addAll(injectableBinds);
  }
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<IAppController>((i) => AppController()),
    Bind.lazySingleton((i) => (i) => CustomDio(i())),
    Bind.lazySingleton((i) => BaseOptions(
          baseUrl: '',
          connectTimeout: 5000,
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
  ];
}
```
# app_controller.dart
Aqui conterá as configurações iniciais do aplicativo que necessitará do conhecimento de todos os módulos, como o caso da `internacionalização`.
```dart
class AppController implements IAppController {
  Future loadLangs() async {
    Localization.setTranslationDirectories([
      'packages/home/config/lang/',
      'lib/config/lang',
    ]);
    await Localization.configuration();
  }
}
```