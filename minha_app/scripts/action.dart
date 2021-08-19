import 'dart:async';
import 'package:args/args.dart';
import 'package:process_run/shell.dart';

Future main(
  List<String> args,
) async {
  final shell = Shell();
  final parser = ArgParser()
    ..addOption(
      'brand',
      abbr: 'b',
      defaultsTo: 'CVC',
    )
    ..addOption(
      'env',
      abbr: 'e',
      defaultsTo: 'PRODUCTION',
    )
    ..addOption(
      'platform',
      abbr: 'p',
      defaultsTo: 'ANDROID',
    )
    ..addOption(
      'buildType',
      abbr: 't',
      defaultsTo: 'debug',
    )
    ..addOption(
      'configYaml',
      abbr: 'c',
      defaultsTo: 'lib/config/env/env_config.yaml',
    )
    ..addOption(
      'version_name',
      abbr: 'v',
      defaultsTo: 'version_name',
    )
    ..addOption(
      'version_code',
      abbr: 'r',
      defaultsTo: 'version_code',
    );
  final argResults = parser.parse(
    args,
  );

  final brand = argResults['brand'].toString().toUpperCase();
  // final env = argResults['env'].toString().toUpperCase();
  // final platform = argResults['platform'].toString().toUpperCase();


  await shell.run(
    'cp -Rf minha_app/brands/$brand/config minha_app/lib/',
  );
  
  await shell.run(
    'cp -Rf minha_app/brands/$brand/assets minha_app/',
  );
}
