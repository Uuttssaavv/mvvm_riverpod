import 'package:flutter/material.dart';
import 'package:flutter_project/features/crud_item/item_view.dart';
import 'package:flutter_project/features/dashboard/profile_tab.dart';
import 'package:flutter_project/widgets/text.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);
  static const routeName = '/dashboard-view';
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const text("Dashboard"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Posts',
            icon: Icon(Icons.note),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          )
        ],
      ),
      body: selectedIndex == 1 ? const ProfileTab() : const ItemView(),
    );
  }
}
