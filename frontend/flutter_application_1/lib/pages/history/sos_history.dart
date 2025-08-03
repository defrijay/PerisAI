import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/search_bar.dart';
import 'package:flutter_application_1/pages/history/sos_history.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:flutter_application_1/pages/history/sos_history_detail.dart';
import 'package:flutter_application_1/pages/home/homepage.dart';
import 'package:flutter_application_1/components/menu_appbar.dart';

class SOSHistory extends StatelessWidget {
  const SOSHistory({super.key});

  void navigateTo(BuildContext context, int index) {
    Widget page;
    switch (index) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = HomePage();
        break;
      case 2:
        page = SOSHistory();
        break;
      // case 3:
      //   page = ProfilePage();
      //   break;
      default:
        page = HomePage();
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C19),
      appBar: MenuAppBar(
        title: "Riwayat SOS",
        onBackPressed: () => Navigator.pop(context),
        onHelpPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Bantuan'),
              content: const Text('Ini adalah halaman bantuan.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'),
                ),
              ],
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              MenuSearchBar(
                onChanged: (value) {
                  print("User mengetik: $value");
                },
                onFilterSelected: (filter) {
                  print("Filter dipilih: $filter");
                },
              ),

              const SizedBox(height: 24),
              const Text(
                'Hari Ini',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(color: Colors.white38),
              buildRiwayatCard(
                context: context,
                title: 'Pembegalan Sore Hari',
                date: '12 Juli 2025 | 17:00 WIB',
                status: 'Validasi SOS Berhasil!',
                location: 'Jl. Jendral Sudirman, Bandung, Jawa Barat',
                imagePath: 'assets/images/begal.png',
              ),
              buildRiwayatCard(
                context: context,
                title: 'Perampokan Mobil',
                date: '1 Juli 2025 | 07:00 WIB',
                status: 'Validasi SOS Berhasil!',
                location: 'Jl. Jendral Sudirman, Bandung, Jawa Barat',
                imagePath: 'assets/images/mobil.png',
              ),
              const SizedBox(height: 12),
              const Text(
                'Sebulan Lalu',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(color: Colors.white38),
              buildRiwayatCard(
                context: context,
                title: 'Perampokan Rumah',
                date: '12 Juni 2025 | 01:00 WIB',
                status: 'Validasi SOS Berhasil!',
                location: 'Jl. Jendral Sudirman, Bandung, Jawa Barat',
                imagePath: 'assets/images/rumah.png',
              ),
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

  Widget buildRiwayatCard({
    required BuildContext context,
    required String title,
    required String date,
    required String status,
    required String location,
    required String imagePath,
  }) {
    return Card(
      color: Color(0xFF102B66),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imagePath,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.calendar_month_outlined, size: 12),
                          SizedBox(width: 4),
                          Text(
                            date,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),

                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            status,
                            style: const TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: 12),
                          SizedBox(width: 4),
                          Text(
                            location,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Color(0xFF528EB2),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SosHistoryDetail()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Lihat Detail',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
