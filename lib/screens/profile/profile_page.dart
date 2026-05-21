import 'package:flutter/material.dart';

import '../../widgets/nirbaya_bottom_nav.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EC),
      body: Stack(
        children: [
          const Center(
            child: Text('Profile Page'),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomInset + 16),
              child: const Center(
                child: NirbayaBottomNav(currentIndex: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
