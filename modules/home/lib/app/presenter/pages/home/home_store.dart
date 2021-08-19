import 'package:get/get.dart';

class HomeStore extends GetxController {
  var count = 0.obs;
  increment() => count++;
  decrement() => count--;
}
