import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentService {
  final CollectionReference Courts =
      FirebaseFirestore.instance.collection('Courts');

  Future<List<DateTime>> getAvailableAppointments(
      DateTime selectedDate, String start, String end) async {
    int startHour = int.parse(start);
    int endHour = int.parse(end);
    DateTime startDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      startHour,
    );
    DateTime endDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      endHour,
    );

    List<DateTime> availableAppointments = [];
    DateTime now = DateTime.now();

    for (int i = startHour; i < endHour; i++) {
      DateTime candidateTime =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day, i);

      if (selectedDate.isAtSameMomentAs(now) && candidateTime.hour > now.hour) {
        availableAppointments.add(candidateTime);
      } else if (selectedDate.isAfter(now)) {
        availableAppointments.add(candidateTime);
      }
    }

    return availableAppointments;
  }
}
