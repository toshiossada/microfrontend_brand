import '../repositories/enterprise_repository_interface.dart';
import 'interfaces/get_all_enterprise_interface.dart';

class GetAllEnterprise implements IGetAllEnterprise {
  final IEnterpriseRepository _enterpriseRepository;

  GetAllEnterprise(this._enterpriseRepository);
  @override
  Future<void> call() async {}
}
