import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scan_sa_user/features/store/domain/models/store_model.dart';
import 'package:scan_sa_user/util/images.dart';

class ReservationController extends GetxController {
  RxInt numberOfGuest = 2.obs;
  RxInt visitingDateIndex = 0.obs;
  DateTime? selectedTime;

  void changeGuest(int value) {
    numberOfGuest.value = value;
    update();
  }

  void changeDate(int value) {
    visitingDateIndex.value = value;
    selectedTime = null;
    update();
  }

  SlotCategory getSlotCategory(DateTime slotTime) {
    final morningStart =
        DateTime(slotTime.year, slotTime.month, slotTime.day, 3, 0);
    final morningEnd =
        DateTime(slotTime.year, slotTime.month, slotTime.day, 12, 0);
    final afternoonStart =
        DateTime(slotTime.year, slotTime.month, slotTime.day, 12, 0);
    final afternoonEnd =
        DateTime(slotTime.year, slotTime.month, slotTime.day, 17, 0);

    if (slotTime.isAfter(morningStart) && slotTime.isBefore(morningEnd)) {
      return SlotCategory.Morning;
    }
    if (slotTime.isAfter(afternoonStart) && slotTime.isBefore(afternoonEnd)) {
      return SlotCategory.Afternoon;
    }
    return SlotCategory.Evening;
  }

  List<TimeModel> _generateSlotsForDay(
    DateTime date,
    Schedules schedule,
  ) {
    List<TimeModel> timeList = [];
    List<SlotModel> slots = [];
    final opening = DateFormat('yyyy-MM-dd HH:mm').parse(
      '${DateFormat('yyyy-MM-dd').format(date)} ${schedule.openingTime}',
    );
    final closing = DateFormat('yyyy-MM-dd HH:mm').parse(
      '${DateFormat('yyyy-MM-dd').format(date)} ${schedule.closingTime}',
    );
    var slotStart = opening;
    while (slotStart.add(const Duration(minutes: 30)).isBefore(closing) ||
        slotStart.add(const Duration(minutes: 30)).isAtSameMomentAs(closing)) {
      final slotEnd = slotStart.add(const Duration(minutes: 30));
      final category = getSlotCategory(slotStart);
      slots.add(
        SlotModel(
          start: slotStart,
          end: slotEnd,
          category: category.toString().split('.').last,
        ),
      );
      slotStart = slotEnd;
    }

    for (var element in SlotCategory.values) {
      final list = slots
          .where(
            (e) => e.category == element.name,
          )
          .toList();
      if (list.isNotEmpty) {
        timeList.add(
          TimeModel(
            title: element.name,
            icon: switch (element.name) {
              "Morning" => Images.breakfastIc,
              'Afternoon' => Images.lunchIc,
              _ => Images.dinnerIc,
            },
            time: "${DateFormat('hh:mm a').format(list.first.start)} to "
                "${DateFormat('hh:mm a').format(list.last.end)}",
            isExpand: false.obs,
            slotList: slots
                .where(
                  (e) => e.category == element.name,
                )
                .toList(),
          ),
        );
      }
    }
    return timeList;
  }

  final dayList = ['Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'];

  List<SlotModelList> slotsByDay = [];
  void generateNext30DaysSlots(
    List<Schedules> schedules,
  ) {
    slotsByDay = [];
    for (int i = 0; i < 30; i++) {
      final currDate = DateTime.now().add(Duration(days: i));
      final weekday = currDate.weekday;
      for (final schedule in schedules) {
        if (schedule.day == weekday) {
          final slots = _generateSlotsForDay(currDate, schedule);
          slotsByDay.add(
            SlotModelList(
              date: currDate,
              slotList: slots,
              day: dayList[weekday - 1],
              weekDay: weekday,
              isToday: currDate.day == DateTime.now().day &&
                  weekday == currDate.weekday,
            ),
          );
        }
      }
    }
  }
}

// ignore: constant_identifier_names
enum SlotCategory { Morning, Afternoon, Evening }

class TimeModel {
  TimeModel({
    required this.title,
    required this.icon,
    required this.time,
    required this.isExpand,
    required this.slotList,
  });
  final String icon;
  final String title;
  final String time;
  final RxBool isExpand;
  final List<SlotModel> slotList;
}

class SlotModel {
  SlotModel({
    required this.start,
    required this.end,
    required this.category,
  });
  final DateTime start;
  final DateTime end;
  final String category;
}

class SlotModelList {
  SlotModelList({
    required this.slotList,
    required this.date,
    required this.day,
    required this.weekDay,
    this.isToday = false,
  });
  final List<TimeModel> slotList;
  final DateTime date;
  final String day;
  final int weekDay;
  final bool isToday;
}
