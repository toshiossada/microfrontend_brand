import 'package:commons/shared/theme/base_colors.dart';

import '../../../domain/usecases/interfaces/get_all_enterprise_interface.dart';

import 'home_store.dart';

class HomeController {
  final IGetAllEnterprise _getAllEnterprise;
  final HomeStore store;
  final BaseAppColors color;
  HomeController(
    this._getAllEnterprise,
    this.store,
    this.color
  );

  void increment() {
    if (store.count.value < 10) {
      store.increment();
    }else{
      store.decrement();
    }
  }

  Future<void> getEnterprises() async {
    _getAllEnterprise();
  }
}
