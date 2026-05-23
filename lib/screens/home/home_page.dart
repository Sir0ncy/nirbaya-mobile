import 'package:flutter/material.dart';

import '../../widgets/nirbaya_bottom_nav.dart';

const Color _navy = Color(0xFF1F2E4D);
const Color _navySoft = Color(0xFF51658B);
const Color _sheet = Color(0xFFFFFFFF);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedModeIndex = 2;

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF2EFE6),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE6E1D4),
                    Color(0xFFF7F4EC),
                  ],
                ),
              ),
              child: const _MapPlaceholder(),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).padding.top + 10, // Adjusted height to be shorter
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _navy.withAlpha(230), // Slightly darker at the very top (approx 0.9 opacity)
                    _navy.withAlpha(0),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Column(
                  children: const [
                    Text(
                      'NIRBAYA',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.6,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Telusuri rute amanmu',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 150),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x22000000),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.my_location, color: Colors.black87),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                bottom: bottomInset > 0 ? bottomInset + 12 : 24,
              ),
              decoration: const BoxDecoration(
                color: _sheet,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 16,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mau kemana hari ini?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Jl. Ring Road Utara',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _navy,
                        ),
                        prefixIcon: const Icon(Icons.search, size: 20, color: _navySoft),
                        filled: true,
                        fillColor: const Color(0xFFF3F4F8),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ModeChip(
                          icon: Icons.directions_walk,
                          label: 'Jalan',
                          selected: _selectedModeIndex == 0,
                          onTap: () => _setMode(0),
                        ),
                        _ModeChip(
                          icon: Icons.pedal_bike,
                          label: 'Sepeda',
                          selected: _selectedModeIndex == 1,
                          onTap: () => _setMode(1),
                        ),
                        _ModeChip(
                          icon: Icons.two_wheeler,
                          label: 'Motor',
                          selected: _selectedModeIndex == 2,
                          onTap: () => _setMode(2),
                        ),
                        _ModeChip(
                          icon: Icons.directions_car,
                          label: 'Mobil',
                          selected: _selectedModeIndex == 3,
                          onTap: () => _setMode(3),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Center(
                      child: NirbayaBottomNav(currentIndex: 0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _setMode(int index) {
    setState(() {
      _selectedModeIndex = index;
    });
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color background = selected ? _navy : const Color(0xFFF3F4F8);
    final Color foreground = selected ? Colors.white : _navySoft;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 76,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? _navy : const Color(0xFFE0E3EC)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: foreground),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  const _MapPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
