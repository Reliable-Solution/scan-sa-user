import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/business/domain/models/business_plan_body.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/models/package_model.dart';

abstract class BusinessServiceInterface {
  Future<PackageModel?> getPackageList();
  Future<String> processesBusinessPlan(
    String businessPlanStatus,
    int paymentIndex,
    int restaurantId,
    String? digitalPaymentName,
    int? selectedPackageId,
  );
  Future<String> setUpBusinessPlan(
    BusinessPlanBody businessPlanBody,
    String? digitalPaymentName,
    String businessPlanStatus,
    int restaurantId,
  );
}
