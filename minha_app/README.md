
# minha_app

O **minha_app** é o ponto de entrada da minha aplicação, ele irá conversar somente com o  **CORE**  que irá acessar os módulos. 


![image](https://user-images.githubusercontent.com/2637049/129366674-038347fd-507f-4913-a646-83fd87fb5415.png)
# Brands
O diretório **brands** conterá todas as classes e arquivos de configurações que é necessário a separação por marcas e ambiente.
# Scripts
O diretório **scripts** é onde conterá os scripts de pré-build para gerar os arquivos de suas respectivas marcas.
# brand_binds.dart
O arquivo `brand_binds.dart` terá a lista de instancias dos objetos que serão gerados pelo script do `white-label`, está lista será passado para o arquivo de configuração do gestor de dependências (`modular`) para que seja possível recuperar nos módulos.
```dart
    final List<Bind> brandBinds = [
      Bind.lazySingleton<BaseAppColors>((i) => AppColors()),
    ];
```

