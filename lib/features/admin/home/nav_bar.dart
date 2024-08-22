import 'package:flutter/material.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/features/admin/home/home_view.dart';
import 'package:pitch_test/features/customer/Presentation/profile/profile_view.dart';

class ManagerNavBarView extends StatefulWidget {
  const ManagerNavBarView({super.key});

  @override
  State<ManagerNavBarView> createState() => _ManagerNavBarViewState();
}

class _ManagerNavBarViewState extends State<ManagerNavBarView> {
  List<Widget> views = [
    const AdminHomeView(),
    // const ManagerWalletView(),
    const profile_view()
  ];
  int _selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: views[_selectedItem],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide(width: 1, color: AppColors.color2))),
        child: BottomNavigationBar(
            currentIndex: _selectedItem,
            onTap: (value) {
              setState(() {
                _selectedItem = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                  activeIcon: Image.asset('assets/home1.png'),
                  icon: Image.asset('assets/home.png'),
                  label: ''),
              // BottomNavigationBarItem(
              //     activeIcon: Image.asset('assets/ticket1.png'),
              //     icon: Image.asset('assets/ticket.png'),
              //     label: ''),
              BottomNavigationBarItem(
                  activeIcon: Image.asset('assets/user1.png'),
                  icon: Image.asset('assets/user.png'),
                  label: ''),
            ]),
      ),
    );
  }
}
