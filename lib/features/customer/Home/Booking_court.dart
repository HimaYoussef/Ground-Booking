import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/customer/Home/Widgets/available_appointments.dart';
import 'package:pitch_test/features/customer/Home/data/Court_model.dart';
import 'package:pitch_test/features/customer/Home/nav_bar.dart';
import 'package:pitch_test/features/customer/Presentation/Search/widgets/Courts_view.dart';
import 'package:pitch_test/generated/l10n.dart';

class BookingCourt extends StatefulWidget {
  final Court courts;

  const BookingCourt({
    super.key,
    required this.courts,
  });

  @override
  State<BookingCourt> createState() => BookingCourtState();
}

class BookingCourtState extends State<BookingCourt> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController(
    text: DateFormat('dd-MM-yyyy', 'en').format(DateTime.now()),
  );

  TimeOfDay currentTime = TimeOfDay.now();
  String? dateUTC;
  String? dateTime;
  String? dateTime1;

  int isSelected = -1;
  int _isSelected = -1;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  List<int> times = [];

  Future<void> getAvailableTimes(String selectedDate) async {
    times.clear();

    // Parse the selected date using English numerals
    // DateTime startOfDay = DateFormat('yyyy-MM-dd', 'en').parse(selectedDate);
    // DateTime endOfDay =
    //     DateTime(startOfDay.year, startOfDay.month, startOfDay.day, 23, 59, 59);
    DateTime startOfDay = DateTime.parse('$selectedDate 00:00:00');
    DateTime endOfDay = DateTime.parse('$selectedDate 23:59:59');

    final bookedTimes = await FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('pending')
        .where('CourtID', isEqualTo: widget.courts.id)
        .where('StartHour', isGreaterThanOrEqualTo: startOfDay)
        .where('StartHour', isLessThanOrEqualTo: endOfDay)
        .get();

    List<int> bookedHours = [];
    for (var appointment in bookedTimes.docs) {
      DateTime startHour =
          (appointment.data()['StartHour'] as Timestamp).toDate();
      DateTime endHour = (appointment.data()['EndHour'] as Timestamp).toDate();

      for (int hour = startHour.hour; hour < endHour.hour; hour++) {
        bookedHours.add(hour);
      }
    }

    List<DateTime> availableAppointments =
        await AppointmentService().getAvailableAppointments(
      startOfDay,
      widget.courts.StartHour,
      widget.courts.EndHour,
    );

    List<int> availableHours = [];
    for (var appointment in availableAppointments) {
      availableHours.add(appointment.hour);
    }

    for (int hour in availableHours) {
      if (!bookedHours.contains(hour)) {
        times.add(hour);
      }
    }

    setState(() {});
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.color1,
            colorScheme: ColorScheme.light(primary: AppColors.color1),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        _dateController.text = DateFormat('dd-MM-yyyy', 'en').format(date);
        dateUTC = DateFormat('yyyy-MM-dd', 'en').format(date);
        getAvailableTimes(dateUTC!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios_new, color: AppColors.color1)),
        centerTitle: false,
        title: Text(
          S.of(context).Booking_court_Head,
          style: getTitleStyle(
              fontSize: 20,
              color: AppColors.color1,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Courts_details(
                name: widget.courts.name,
                image: widget.courts.imageUrl,
                price: widget.courts.price,
                desc: widget.courts.description,
                rate: widget.courts.rate,
                rate_num: widget.courts.rate_num,
                onPressed: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).Booking_court_desc,
                        style: getTitleStyle(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            S.of(context).Booking_court_Date,
                            style: getsmallStyle(
                                color: AppColors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintStyle: getsmallStyle(
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            selectDate(context);
                          },
                          icon: Icon(
                            Icons.calendar_month_outlined,
                            color: AppColors.color1,
                          ),
                        ),
                      ),
                      controller: _dateController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      style: getbodyStyle(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(S.of(context).Booking_court_Start_Time),
                    Wrap(
                      spacing: 8.0,
                      children: [
                        for (int i = 0; i < times.length; i++)
                          ChoiceChip(
                            backgroundColor: AppColors.scaffoldBG,
                            selectedColor: AppColors.color1,
                            label: Text(
                              '${times[i].toString().padLeft(2, '0')}:00',
                              style: TextStyle(
                                color: i == isSelected
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            ),
                            selected: i == isSelected,
                            onSelected: (selected) {
                              setState(() {
                                isSelected = i;
                                dateTime =
                                    '${times[i].toString().padLeft(2, '0')}:00';
                              });
                            },
                          ),
                        const SizedBox(
                          height: 75,
                        ),
                      ],
                    ),
                    Text(S.of(context).Booking_court_End_Time),
                    Wrap(
                      spacing: 8.0,
                      children: [
                        for (int j = 1; j < times.length; j++)
                          ChoiceChip(
                            backgroundColor: AppColors.scaffoldBG,
                            selectedColor: AppColors.color2,
                            label: Text(
                              '${times[j].toString().padLeft(2, '0')}:00',
                              style: TextStyle(
                                color: j == _isSelected
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            ),
                            selected: j == _isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _isSelected = j;
                                dateTime1 =
                                    '${times[j].toString().padLeft(2, '0')}:00';
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: AnimatedButton(
                          text: S.of(context).Booking_court_Booking_button,
                          color: AppColors.color1,
                          pressEvent: () {
                            if (_formKey.currentState!.validate() &&
                                isSelected != -1 &&
                                _isSelected != -1 &&
                                isSelected < _isSelected) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                showCloseIcon: true,
                                title: S
                                    .of(context)
                                    .Booking_court_Dialog_success_title,
                                desc: S
                                    .of(context)
                                    .Booking_court_Dialog_success_desc,
                                btnOkOnPress: () {
                                  _createAppointment();
                                  pushToWithReplacement(context, HomeView());
                                },
                              ).show();
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                showCloseIcon: true,
                                title: S
                                    .of(context)
                                    .Booking_court_Dialog_fail_title,
                                desc: S
                                    .of(context)
                                    .Booking_court_Dialog_fail_desc,
                                btnCancelOnPress: () {
                                  Navigator.pop(context);
                                },
                              ).show();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createAppointment() async {
    final Map<String, dynamic> appointmentData = {
      'UserID': user!.email,
      'image': widget.courts.imageUrl,
      'price': widget.courts.price,
      'CourtID': widget.courts.id,
      'name': user!.displayName,
      'description': widget.courts.description,
      'Court': widget.courts.name,
      'StartHour': DateTime.parse('${dateUTC!} $dateTime:00'),
      'EndHour': DateTime.parse('${dateUTC!} $dateTime1:00'),
      'rating': null,
    };

    await FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('pending')
        .doc()
        .set(appointmentData, SetOptions(merge: true));

    await FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('all')
        .doc()
        .set(appointmentData, SetOptions(merge: true));
  }
}
