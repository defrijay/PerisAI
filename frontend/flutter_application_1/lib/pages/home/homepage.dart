import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:flutter_application_1/components/unavailable_modal.dart';
import 'package:flutter_application_1/pages/crime_history/crime_history.dart';
import 'package:flutter_application_1/pages/nearby_police/nearby_police.dart';
import 'package:flutter_application_1/pages/nearby_police/nearby_police_detail.dart';
import 'package:flutter_application_1/pages/profile/profile.dart';
import 'package:flutter_application_1/pages/history/sos_history.dart';

class HomePage extends StatelessWidget {
  void _showPopupMenu(BuildContext context, Offset position) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final selected = await showMenu<String>(
      context: context,
      color: Color(0xFF5CA3C6),
      position: RelativeRect.fromRect(
        position & const Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'profile',
          child: Row(
            children: const [
              Icon(Icons.person, color: Colors.white),
              SizedBox(width: 8),
              Text('Profile', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: const [
              Icon(Icons.logout, color: Colors.white),
              SizedBox(width: 8),
              Text('Keluar', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );

    if (selected == 'profile') {
      // Navigasi ke halaman profile
      Navigator.push(context, MaterialPageRoute(builder: (_) => Profile()));
    } else if (selected == 'logout') {
      // Logika logout
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(const SnackBar(content: Text('Logout berhasil')));
    }
  }

  Widget buildMenuTile(String title, String asset, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Color(0xFF5DC4F1), Color(0xFF83D4FF)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset(asset, height: 40, width: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void _showNotificationMenu(BuildContext context, Offset position) async {
      final RenderBox overlay =
          Overlay.of(context).context.findRenderObject() as RenderBox;

      await showMenu<String>(
        context: context,
        color: const Color(0xFF5CA3C6),
        position: RelativeRect.fromRect(
          position & const Size(20, 20),
          Offset.zero & overlay.size,
        ),
        items: <PopupMenuEntry<String>>[
          // Label Minggu Ini
          const PopupMenuItem<String>(
            enabled: false,
            child: Text(
              'Minggu Ini',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          PopupMenuDivider(),
          // Notifikasi Hari Ini
          const PopupMenuItem<String>(
            value: 'notif1',
            child: Text(
              '📢 Peringatan di dekat Anda',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'notif2',
            child: Text(
              '🚔 Pos Polisi baru ditambahkan',
              style: TextStyle(color: Colors.white),
            ),
          ),

          // Label Minggu Lalu
          const PopupMenuItem<String>(
            enabled: false,
            child: Text(
              'Minggu Lalu',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),

          PopupMenuDivider(),
          // Notifikasi Minggu Lalu
          const PopupMenuItem<String>(
            value: 'notif3',
            child: Text(
              'ℹ️ Update keamanan minggu lalu',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFF1F2040), // Warna biru tua background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.security, color: Colors.blueAccent),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("PerisAI", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  "Keamanan Cerdas Adaptif Berbasis AI",
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              _showNotificationMenu(
                context,
                details.globalPosition,
              ); // ✅ Panggil popup notifikasi
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.notifications, color: Colors.orangeAccent),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTapDown: (TapDownDetails details) {
                _showPopupMenu(context, details.globalPosition);
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 18,
                child: Icon(Icons.person, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildMenuTile(
                "Kantor Polisi terdekat",
                "assets/icons/police.png",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => NearbyPolice()),
                  );
                },
              ),
              buildMenuTile(
                "Kontak Darurat",
                "assets/icons/emergency_contact.png",
                () {
                  showUnavailableModal(context);
                },
              ),
              buildMenuTile("Peta Zona Rawan", "assets/icons/map.png", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CrimeHistory()),
                );
              }),
              buildMenuTile(
                "Live Tracking Kerabat",
                "assets/icons/tracking.png",
                () {
                  showUnavailableModal(context);
                },
              ),
              buildMenuTile(
                "Edukasi Keamanan",
                "assets/icons/education.png",
                () {
                  showUnavailableModal(context);
                },
              ),
              buildMenuTile("Panduan Aplikasi", "assets/icons/guide.png", () {
                showUnavailableModal(context);
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (_) => DaruratPage()));
        },
        backgroundColor: Colors.orange,
        shape: CircleBorder(),
        child: Icon(Icons.warning, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }
}
