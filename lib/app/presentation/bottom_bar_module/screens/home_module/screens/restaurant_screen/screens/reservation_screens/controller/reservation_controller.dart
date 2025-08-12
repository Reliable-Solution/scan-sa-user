import 'package:get/get.dart';
import 'package:scan_sa_user/utils/app_icons.dart';

class ReservationController extends GetxController {
  RxInt numberOfGuest = 2.obs;
  RxInt visitingDateIndex = 0.obs;
  RxString selectedTime = ''.obs;

  void changeGuest(int value) {
    numberOfGuest.value = value;
    update();
  }

  void changeDate(int value) {
    visitingDateIndex.value = value;
    update();
  }

  List<
    ({
      String icon,
      String title,
      String time,
      List<String> timeList,
      RxBool isExpand,
    })
  >
  dataList = [
    (
      icon: AppIcons.breakfastIc,
      isExpand: false.obs,
      time: '11:30 AM to 12:00 PM',
      timeList: ['11:30 AM', '11:45 AM'],
      title: 'Breakfast',
    ),
    (
      icon: AppIcons.lunchIc,
      isExpand: false.obs,
      time: '12:00 PM to 05:00 PM',
      timeList: [
        '12:00 PM',
        '12:30 AM',
        '01:00 PM',
        '01:30 PM',
        '02:00 PM',
        '02:30 PM',
        '03:00 PM',
        '03:30 PM',
        '04:00 PM',
        '04:30 PM',
      ],
      title: 'Lunch',
    ),
    (
      icon: AppIcons.dinnerIc,
      isExpand: false.obs,
      time: '05:00 PM to 02:00 AM',
      timeList: [
        '05:00 PM',
        '05:30 PM',
        '06:00 PM',
        '06:30 PM',
        '07:00 PM',
        '07:30 PM',
        '08:00 PM',
        '08:30 PM',
        '09:00 PM',
        '09:30 PM',
      ],
      title: 'Dinner',
    ),
  ];
}
