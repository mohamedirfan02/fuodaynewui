import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';

class EmployeeBottomNav extends StatelessWidget {
  const EmployeeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    // Bottom Nav Provider
    final bottomNavProvider = context.bottomNavProviderWatch;
    final theme = Theme.of(context);

    return Scaffold(
      body: bottomNavProvider.currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomNavProvider.currentIndex,
        onTap: (index) {
          context.bottomNavProviderRead.setCurrentIndex(index);
        },
        selectedIconTheme: IconThemeData(size: 24.h),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: theme.textTheme.headlineLarge?.color,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            activeIcon: Icon(Icons.message),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree_outlined),
            activeIcon: Icon(Icons.account_tree),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
