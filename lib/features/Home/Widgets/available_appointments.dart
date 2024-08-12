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
    for (int i = startHour; i < endHour; i++) {
      DateTime candidateTime =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day, i);

      if (candidateTime.hour > DateTime.now().hour &&
          candidateTime.day == DateTime.now().day &&
          candidateTime.month == DateTime.now().month) {
        availableAppointments.add(candidateTime);
      }
      if (candidateTime.day != DateTime.now().day &&
          candidateTime.day > DateTime.now().day) {
        availableAppointments.add(candidateTime);
      }
    }

    return availableAppointments;
  }
}
