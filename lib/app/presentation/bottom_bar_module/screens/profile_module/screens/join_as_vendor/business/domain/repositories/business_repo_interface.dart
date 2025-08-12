import 'package:get/get_connect/connect.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/business/domain/models/business_plan_body.dart';
import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class BusinessRepoInterface implements RepositoryInterface<dynamic> {
  Future<Response<dynamic>> setUpBusinessPlan(
    BusinessPlanBody businessPlanBody,
  );
  Future<Response<dynamic>> subscriptionPayment(String id, String? paymentName);
}
