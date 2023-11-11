import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  MyBottomNavigationBar({
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Tr.Chủ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Các địa điểm',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Tài khoản',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.amber[800],
      selectedLabelStyle: const TextStyle(fontSize: 18.0),
      unselectedLabelStyle: const TextStyle(fontSize: 16.0),
      onTap: onItemTapped,
    );
  }
}
