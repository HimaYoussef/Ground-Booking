import 'package:flutter/material.dart';
import 'package:pitch_test/core/utils/Style.dart';

class NoScheduledWidget extends StatelessWidget {
  const NoScheduledWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/no_scheduled.png', width: 250),
          Text('There\'s no upcoming Booking ', style: getbodyStyle()),
        ],
      ),
    );
  }
}
