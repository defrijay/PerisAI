import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home/homepage.dart';
import 'package:flutter_application_1/pages/history/sos_history.dart';
import 'package:flutter_application_1/pages/profile/profile.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({required this.currentIndex});

  void _navigateTo(BuildContext context, int index) {
    Widget page;

    switch (index) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = HomePage(); // ganti jika sudah ada MessagesPage()
        break;
      case 2:
        page = SOSHistory();
        break;
      case 3:
        page = Profile();
        break;
      default:
        page = HomePage();
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 4,
      color: const Color(0xFF5CA3C6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(context, Icons.home, "Beranda", 0),
            _buildNavItem(context, Icons.chat, "Pesan", 1),
            const SizedBox(width: 48), // space for FAB
            _buildNavItem(context, Icons.history, "Riwayat SOS", 2),
            _buildNavItem(context, Icons.person, "Profil", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => _navigateTo(context, index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.white : Colors.grey[200]),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[200],
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
