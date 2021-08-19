import '../../../domain/usecases/interfaces/get_all_enterprise_interface.dart';

import 'home_store.dart';

class HomeController {
  final IGetAllEnterprise _getAllEnterprise;
  final HomeStore store;

  HomeController(
    this._getAllEnterprise,
    this.store,
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
