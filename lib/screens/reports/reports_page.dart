import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/nirbaya_bottom_nav.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final PageController _todayController = PageController(viewportFraction: 0.92);
  final PageController _weekController = PageController(viewportFraction: 0.92);

  static const Color _headerBlue = Color(0xFF2B4771);
  static const Color _buttonBlue = Color(0xFF2F4A73);

  final List<_ReportCardData> _todayReports = const [
    _ReportCardData(
      title: 'Klitih di Jl. Ring Road Utara',
      time: '09.41',
      age: '2 Minggu yang lalu',
      description: 'Korban diserang oleh kelompok bermotor saat berhenti di pinggir jalan, dan mengalami luka ringan pada bagian kepala dan tangan.',
    ),
    _ReportCardData(
      title: 'Klitih di Jl. Ring Road Selatan',
      time: '08.31',
      age: '4 Minggu yang lalu',
      description: 'Korban diserang oleh kelompok bermotor saat berhenti di pinggir jalan, dan mengalami luka ringan pada bagian kepala dan tangan.',
    ),
  ];

  final List<_ReportCardData> _weekReports = const [
    _ReportCardData(
      title: 'Klitih di Jl. Ring Road Utara',
      time: '09.41',
      age: '1 Minggu yang lalu',
      description: 'Korban diserang oleh kelompok bermotor saat berhenti di pinggir jalan, dan mengalami luka ringan pada bagian kepala dan tangan.',
    ),
    _ReportCardData(
      title: 'Klitih di Jl. Ring Road Timur',
      time: '11.10',
      age: '6 Hari yang lalu',
      description: 'Korban diserang oleh kelompok bermotor saat berhenti di pinggir jalan, dan mengalami luka ringan pada bagian kepala dan tangan.',
    ),
  ];

  @override
  void dispose() {
    _todayController.dispose();
    _weekController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _headerBlue,
        foregroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
        title: const Text(
          'Laporan Kejahatan',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 33),
                    child: Text(
                      'Hari ini',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      controller: _todayController,
                      itemCount: _todayReports.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16, right: 8),
                          child: _ReportCard(data: _todayReports[index]),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 33),
                    child: Text(
                      'Kejadian dalam sepekan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 270,
                    child: PageView.builder(
                      controller: _weekController,
                      itemCount: _weekReports.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16, right: 8),
                          child: _ReportCard(data: _weekReports[index], compact: true),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: bottomInset > 0 ? bottomInset + 12 : 24,
              ),
              child: const Center(
                child: NirbayaBottomNav(currentIndex: 1),
              ),
            ),
          ),
          // Floating Action Button di pojok kanan bawah
          Positioned(
            right: 16,
            bottom: bottomInset > 0 ? bottomInset + 96 : 96, // Menyesuaikan agar berada di atas bottom nav
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.addReports);
              },
              backgroundColor: _buttonBlue,
              foregroundColor: Colors.white,
              elevation: 4,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportCardData {
  const _ReportCardData({
    required this.title,
    required this.time,
    required this.age,
    required this.description,
  });

  final String title;
  final String time;
  final String age;
  final String description;
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.data, this.compact = false});

  final _ReportCardData data;
  final bool compact;

  static const Color _cardBorder = Color(0xFFD7D7D7);
  static const Color _cardTitle = Color(0xFF1E1E1E);
  static const Color _metaBlue = Color(0xFF35517C);
  static const Color _metaGrey = Color(0xFF68768A);
  static const Color _buttonBlue = Color(0xFF2F4A73);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: _cardTitle,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              _MetaPill(label: data.time, color: _metaBlue),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  data.age,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: _metaGrey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: compact ? 96 : 140,
            decoration: BoxDecoration(
              color: const Color(0xFFE9EDF4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD5DCE8)),
            ),
            child: const Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                size: 34,
                color: Color(0xFF92A0B4),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              data.description,
              maxLines: compact ? 2 : 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                height: 1.35,
                color: Color(0xFF67758A),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 34,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _buttonBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                'Lihat detail',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}
