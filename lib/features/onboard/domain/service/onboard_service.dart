import 'package:get/get.dart';
import 'package:scan_sa_user/features/onboard/domain/repository/onboard_repository_interface.dart';
import 'package:scan_sa_user/features/onboard/domain/service/onboard_service_interface.dart';

class OnboardService implements OnboardServiceInterface {
  OnboardService({required this.onboardRepositoryInterface});
  final OnboardRepositoryInterface onboardRepositoryInterface;

  @override
  Future<Response> getOnBoardingList() async {
    return await onboardRepositoryInterface.getList();
  }
}
