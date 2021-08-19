# Mobile Microfrontend

Projeto do aplicativo **Business to Consumer** contendo a nova proposta de arquitetura baseada no [micro front-end](https://gist.github.com/toshiossada/4f1e1933f78ee5bcd36c92e09b47ea58).

![Estrutura](https://user-images.githubusercontent.com/2637049/117327456-fed2ed00-ae68-11eb-9afd-874c67587955.png)A estrutura inicial de pasta e arquivos do projeto ficará da seguinte maneira.

![image](https://user-images.githubusercontent.com/2637049/129359236-ac6f8902-f066-4749-9e02-8e215b16ba82.png)

# Execução do Projeto

Para que seja possível executar o projeto siga os seguintes passos:
Agora é necessário baixar todas as dependências do projeto

  
```sh
make clean
make get
```
Retorno ao diretorio raiz e execute o comando para gerar os arquivos de white-label passando **marca(brand)** que será as que etão no diretorio da **BRAND**, o **ambiente(env)** que será **PRODUCTION** ou **STAGING** e a **plataforma(platform)** que será **ANDROID** ou **IOS**, exemplo:

  
```sh
make pre-action env=AMBIENTE brand=NOMA_BRAND platform=ANDROID
```

A execução pode ser encadeada
```sh
make clean; make get; make pre-action env=AMBIENTE brand=NOMA_BRAND platform=ANDROID;
```
Agora vá ao diretório **minha_app** e execute-o.

  
```sh
cd minha_app
flutter run
```


  

# Minha App

![image](https://user-images.githubusercontent.com/2637049/129361967-b3b796ab-9a53-4fca-a184-b3b7a1a52dd4.png)

O `minha_app` é o ponto de entrada da minha aplicação, ele irá conversar somente com o **CORE** que irá acessar os módulos.

  

Ele irá ter a chamado do `runApp()` e as classes referente ao **white-label**.

  

```dart
void main() {
	runApp(
		ModularApp(
			child: AppWidget(),
		),
	);
}

```

# Core

![image](https://user-images.githubusercontent.com/2637049/129364643-716a5533-a002-4afd-ae86-66999a21858f.png)

  

O core é o coração do nosso app, ele fará a ponte de conversa entre o **base_app** e os **módulos** é nele que estará a configuração das rotas principais e a chamada para o **MaterialApp()**.

```dart

class AppWidget extends StatelessWidget {
	const AppWidget({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'App B2C',
			theme: ThemeData(primarySwatch: Colors.blue),
		).modular();
	}
}

```

  

# Commons

![image](https://user-images.githubusercontent.com/2637049/129364992-dedfcb2a-b04e-4481-9bdf-515232a4e7ab.png)

  

O **commons** é o pacote que será responsável por ter toda a funcionalidade que será compartilhado entre todos os módulos, como **interceptors, widgets, stores, controllers, design system, etc**.

**Este e a Commons Dependencies são as únicas dependências que o modulo pode possuir**.

  

# Commons Dependencies

![image](https://user-images.githubusercontent.com/2637049/129365106-6c19c222-4629-4d0e-b5e2-d30b50c8124c.png)

  

Aqui é onde terá todas as dependências do projeto e os módulos pegam suas dependências daqui, desta forma garantimos que todos os módulos utilizam a mesma versão de package **Este e a Commons são as únicas dependências que o modulo pode possuir**.

  
  

# Modules

![image](https://user-images.githubusercontent.com/2637049/129358992-4c9d333c-1bdd-4fee-8227-7a3d7dabb424.png)

Os **módulos** são as quebras de funcionalidades do app. Eles são responsáveis pelas features do app, cada modulo deve possuir **uma e somente uma responsabilidade**.

  

**IMPORTANTE:** Os módulos são totalmente desacoplados e independente de outros módulos e não podem compartilhar informações entre eles, caso isso seja necessário, colocar no **Commons**.

  

# Packages

![image](https://user-images.githubusercontent.com/2637049/129365779-6023576f-7a5c-430b-a86c-043464b61428.png)

  

Neste diretório ficara todos os pacote que são desenvolvidos internamente