import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/history/sos_history.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:flutter_application_1/pages/history/sos_history_detail.dart';
import 'package:flutter_application_1/pages/home/homepage.dart';

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
      backgroundColor: const Color(0xFF1F2040),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Riwayat SOS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.black54),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Cari riwayat SOS kamu...',
                                hintStyle: TextStyle(color: Colors.black45),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF2A4BA0), // Warna biru seperti gambar
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.tune, color: Colors.white, size: 20),
                  ),
                ],
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
      color: const Color(0xFF203D89),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
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
                      Text(
                        date,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        status,
                        style: const TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        location,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SosHistoryDetail()),
                  );
                },
                child: Text(
                  'Lihat Detail  →',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
