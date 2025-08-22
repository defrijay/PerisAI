import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:flutter_application_1/components/menu_appbar.dart';

class NearbyPoliceDetail extends StatelessWidget {
  const NearbyPoliceDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();
    final List<String> buktiImages = [
      'https://via.placeholder.com/300x200',
      'https://via.placeholder.com/300x200',
      'https://via.placeholder.com/300x200',
    ];

    return Scaffold(
      backgroundColor: Color(0xFF0A0C19),
      appBar: MenuAppBar(
        title: "Detail Kantor Polisi",
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Utama
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul
                  Center(
                    child: Text(
                      'Polres Antapani',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pin_end_outlined,
                        color: Colors.white70,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text('6.5 KM', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Location Kantor
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 250,
                      ), // memastikan tinggi minimal
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xFF102B66),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lokasi Kantor',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 12),
                          SizedBox(
                            height:
                                200, // tentukan tinggi tetap agar tidak error
                            width: double.infinity,
                            child: Image.network(
                              'https://maps.googleapis.com/maps/api/staticmap?center=-6.914744,107.609810&zoom=15&size=400x200&key=YOUR_API_KEY',
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(height: 20),
                          Text(
                            'Jl. Jendral Sudirman, Bandung, Jawa Barat',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Foto Kantor
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF102B66),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Foto Kantor',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (_pageController.hasClients) {
                                      _pageController.previousPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (_pageController.hasClients) {
                                      _pageController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 180,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: buktiImages.length,
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  buktiImages[index],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // Hubungi Kantor
                  // Hubungi Kantor
                  Container(
                    width:
                        double.infinity, // membuat container penuh (expanded)
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF102B66),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Teks di sebelah kiri
                        Text(
                          'Hubungi Kantor',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),

                        // Icon Call di sebelah kanan
                        IconButton(
                          onPressed: () {
                            print("Menghubungi kantor polisi...");
                            // Gunakan url_launcher jika ingin langsung melakukan panggilan
                          },
                          icon: Icon(
                            Icons.call_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
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
