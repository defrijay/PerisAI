import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:flutter_application_1/components/menu_appbar.dart';
import 'package:flutter_application_1/components/search_bar.dart';
import 'package:flutter_application_1/pages/crime_history/crime_history_detail.dart';
import 'package:flutter_application_1/pages/nearby_police/nearby_police_detail.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyPolice extends StatefulWidget {
  @override
  _NearbyPoliceState createState() => _NearbyPoliceState();
}

class _NearbyPoliceState extends State<NearbyPolice> {
  final sheetKey = GlobalKey();
  final controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onSheetChanged);
  }

  void onSheetChanged() {
    final currentSize = controller.size;
    // Auto collapse jika ukuran sangat kecil
    if (currentSize <= 0.06) collapseSheet();
  }

  void collapseSheet() => animateSheet(getSheet.snapSizes!.first);
  void expandSheet() => animateSheet(getSheet.maxChildSize);
  void animateSheet(double size) {
    controller.animateTo(
      size,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    );
  }

  DraggableScrollableSheet get getSheet =>
      (sheetKey.currentWidget as DraggableScrollableSheet);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuAppBar(
        title: "Kantor Polisi Terdekat",
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
      body: Stack(
        children: [
          // Background Map Area
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[300],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 100, color: Colors.grey[600]),
                  SizedBox(height: 16),
                  Text(
                    'Google Maps Area',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Google Map placeholder (uncomment untuk menggunakan Google Maps)
          // GoogleMap(
          //   initialCameraPosition: CameraPosition(
          //     target: LatLng(-6.914744, 107.609810),
          //     zoom: 13,
          //   ),
          //   onMapCreated: (controller) => _mapController = controller,
          //   myLocationEnabled: true,
          //   zoomControlsEnabled: false,
          // ),

          // Title Text
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'Ceritanya Google Maps di sini',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          // Draggable Bottom Sheet
          LayoutBuilder(
            builder: (context, constraints) {
              // Menghitung tinggi minimum untuk indicator bar saja
              double indicatorHeight = 70; // Tingkatkan sedikit
              double minChildSize = indicatorHeight / constraints.maxHeight;

              return DraggableScrollableSheet(
                key: sheetKey,
                controller: controller,
                initialChildSize: 0.45, // Mulai dari 45% layar
                minChildSize: minChildSize, // Minimum hanya indicator bar
                maxChildSize: 0.98, // Maksimum hampir menutupi seluruh layar
                snap: true,
                snapSizes: [
                  minChildSize, // Collapsed state
                  0.45, // Medium state
                  0.98, // Full screen state
                ],
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF0A0C19),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Indicator Bar (dapat di-drag)
                        GestureDetector(
                          onTap: () {
                            // Toggle between collapsed and medium state
                            if (controller.size <= 0.1) {
                              animateSheet(0.45);
                            } else if (controller.size < 0.9) {
                              animateSheet(1.0);
                            } else {
                              animateSheet(minChildSize);
                            }
                          },
                          child: Container(
                            height: indicatorHeight,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: Container(
                                width: 100,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Konten yang dapat di-scroll
                        Expanded(
                          child: CustomScrollView(
                            controller: scrollController,
                            slivers: [
                              // Search Bar
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: _buildSearchBar(),
                                ),
                              ),

                              SliverToBoxAdapter(child: SizedBox(height: 16)),

                              // Section: Kecamatan + Cards
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: _buildSection(),
                                ),
                              ),

                              // Tambahan konten untuk testing scroll
                              SliverToBoxAdapter(child: SizedBox(height: 16)),
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: _buildAdditionalContent(),
                                ),
                              ),

                              // Bottom padding untuk ruang scroll
                              SliverToBoxAdapter(child: SizedBox(height: 100)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
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

  Widget _buildSearchBar() {
    return MenuSearchBar(
      hintText: "Cari kantor polisi terdekat...",
      onChanged: (value) {
        print("User mengetik: $value");
      },
      onFilterSelected: (filter) {
        print("Filter dipilih: $filter");
      },
    );
  }

  Widget _buildSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Antapani',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Divider(color: Colors.white30, thickness: 1),
        SizedBox(height: 8),
        _buildCrimeCard(
          imagePath: 'assets/crime1.png',
          title: 'Polsek Antapani',
          distance: '2 Km',
          location: 'Jl. Jendral Sudirman, Bandung, Jawa Barat',
        ),
        SizedBox(height: 12),
        _buildCrimeCard(
          imagePath: 'assets/crime2.png',
          title: 'Polres Antapani',
          distance: '6.5 KM',
          location: 'Jl. Jendral Sudirman, Bandung, Jawa Barat',
        ),
      ],
    );
  }

  Widget _buildAdditionalContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cicendo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Divider(color: Colors.white30, thickness: 1),
        SizedBox(height: 8),
        _buildCrimeCard(
          imagePath: 'assets/crime1.png',
          title: 'Polres Cicendo',
          distance: '7 KM',
          location: 'Jl. Sukajadi, Bandung, Jawa Barat',
        ),
        SizedBox(height: 12),
        _buildCrimeCard(
          imagePath: 'assets/crime2.png',
          title: 'Polda Cicendo',
          distance: '27 KM',
          location: 'Jl. Pasteur, Bandung, Jawa Barat',
        ),
      ],
    );
  }

  Widget _buildCrimeCard({
    required String imagePath,
    required String title,
    required String distance,
    required String location,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF102B66),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10, width: 1),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Placeholder untuk gambar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.warning_amber,
                  color: Colors.orange,
                  size: 40,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.pin_end_outlined,
                          size: 14,
                          color: Colors.white60,
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            distance,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.white60,
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            location,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Color(0xFF396B88),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => NearbyPoliceDetail()),
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
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Color(0xFF528EB2),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => CrimeHistoryDetail()),
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hubungi',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.phone_callback_outlined, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
