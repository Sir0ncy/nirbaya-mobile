import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class NirbayaBottomNav extends StatelessWidget {
  const NirbayaBottomNav({super.key, required this.currentIndex});

  final int currentIndex;

  static const Color _navySoft = Color(0xFF51658B);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _navySoft,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BottomNavItem(
            icon: Icons.home_filled,
            label: 'Beranda',
            selected: currentIndex == 0,
            onTap: () {
              if (currentIndex != 0) {
                Navigator.of(context).pushReplacementNamed(AppRoutes.home);
              }
            },
          ),
          _BottomNavItem(
            icon: Icons.article_outlined,
            label: 'Laporan',
            selected: currentIndex == 1,
            onTap: () {
              if (currentIndex != 1) {
                Navigator.of(context).pushReplacementNamed(AppRoutes.reports);
              }
            },
          ),
          _BottomNavItem(
            icon: Icons.person_outline,
            label: 'Profil',
            selected: currentIndex == 2,
            onTap: () {
              if (currentIndex != 2) {
                Navigator.of(context).pushReplacementNamed(AppRoutes.profile);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  static const Color _navy = Color(0xFF1F2E4D);

  @override
  Widget build(BuildContext context) {
    final Color background = selected ? Colors.white : Colors.transparent;
    final Color foreground = selected ? _navy : Colors.white;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: selected
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 12)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: foreground),
            if (selected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: foreground,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
