import 'dart:io';
import 'package:yaml/yaml.dart';

Map? loadYamlFileSync(
  String path,
) {
  final file = File(
    path,
  );
  if (file.existsSync() == true) {
    return loadYaml(
      file.readAsStringSync(),
    );
  }
  return null;
}

Future<Map?> loadYamlFile(
  String path,
) async {
  final file = File(
    path,
  );
  if ((file.existsSync()) == true) {
    final content = await file.readAsString();
    return loadYaml(
      content,
    );
  }
  return null;
}

Map getConfig(
  Map items,
  List<List<String>> defaultConfig,
) {
  var config = {};
  for (var indEnv = 0; indEnv < defaultConfig[0].length; indEnv++) {
    final keyEnv = defaultConfig[indEnv][0];
    print(
      '   |- $keyEnv:',
    );
    for (var indPlatform = 0;
        indPlatform < defaultConfig[1].length;
        indPlatform++) {
      final keyPlatform = defaultConfig[indPlatform][1];
      print('     |- $keyPlatform');
      config = {
        ...config,
        ...?items[keyEnv][keyPlatform],
      };
    }
  }
  return config;
}

void saveYamlConfig(
  File file,
  Map config,
) {
  file
    ..writeAsStringSync('environment_config:\n')
    ..writeAsStringSync(
      '  path: config/env/env_config.dart\n',
      mode: FileMode.writeOnlyAppend,
    )
    ..writeAsStringSync(
      '  fields:\n',
      mode: FileMode.writeOnlyAppend,
    );
  config.forEach(
    (
      key,
      value,
    ) {
      if (value is Map) {
        file.writeAsStringSync(
          '    $key:\n',
          mode: FileMode.writeOnlyAppend,
        );
        value.forEach(
          (
            subkey,
            subvalue,
          ) {
            file.writeAsStringSync(
              '      $subkey: $subvalue\n',
              mode: FileMode.writeOnlyAppend,
            );
          },
        );
      } else {
        file.writeAsStringSync(
          '   $key: $value\n',
          mode: FileMode.writeOnlyAppend,
        );
      }
    },
  );
  file
    ..writeAsStringSync(
      'imports:\n',
      mode: FileMode.writeOnlyAppend,
    )
    ..writeAsStringSync(
      ' - dart:io\n',
      mode: FileMode.writeOnlyAppend,
    );
}

void appendLinesToFile(
  File file,
  List<String> linesToAppend,
) {
  final lines = file.readAsLinesSync();
  file.writeAsStringSync([...linesToAppend, ...lines].join(
    '\n',
  ));
}
