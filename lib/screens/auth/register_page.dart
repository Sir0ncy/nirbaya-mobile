import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/app_routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _agreeToTerms = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF264167),
      body: Stack(
        children: [
          // ── Gradient 1: Kanan Atas — highlight terang, kecil & kuat ──
          Positioned(
            top: -160,
            right: -180,
            child: Container(
              width: 380,
              height: 380,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.38),
                    Colors.white.withValues(alpha: 0.10),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.40, 1.0],
                ),
              ),
            ),
          ),

          // ── Gradient 2: Kiri Tengah — lebar, redup, atmospheric ──────
          Positioned(
            top: 80,
            left: -220,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.12),
                    Colors.white.withValues(alpha: 0.04),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.50, 1.0],
                ),
              ),
            ),
          ),

          // Foreground Image: mantap.png
          Positioned(
            top: 0, // Turun sedikit dari status bar
            right: -50, // Menyesuaikan agar letaknya mirip di Figma (sedikit terpotong di kanan)
            child: Transform.rotate(
              angle: 6.06 * pi / 180, // Rotasi ~6 derajat
              child: Image.asset(
                'assets/images/mantap.png',
                width: 350,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),
          ),

          // Scrollable Content (Form Sheet)
          SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Spacer untuk mendorong form ke bawah 
                      // dan memberi ruang agar gambar di atas tetap terlihat
                      const SizedBox(height: 250),
                      const Spacer(),
                      
                      // Bottom sheet form
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          left: 36.0,
                          right: 36.0,
                          top: 40.0,
                          bottom: 40.0 + MediaQuery.of(context).padding.bottom,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Buat akun',
                              style: GoogleFonts.poppins(
                                fontSize: 27,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Ketikan detail pribadi Anda',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF8C8C8C),
                              ),
                            ),
                            const SizedBox(height: 32),
                            
                            // Name Field
                            _buildTextField(
                              label: 'Nama',
                              hintText: 'Ketikan nama Anda',
                            ),
                            const SizedBox(height: 24),
                            
                            // Email Field
                            _buildTextField(
                              label: 'Email',
                              hintText: 'Ketikan email Anda',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 24),
                            
                            // Password Field
                            _buildTextField(
                              label: 'Password',
                              hintText: 'Ketikan password Anda',
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                  color: const Color(0xFF9C9999),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 24),
                            
                            // Checkbox and terms
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                    value: _agreeToTerms,
                                    onChanged: (value) {
                                      setState(() {
                                        _agreeToTerms = value ?? false;
                                      });
                                    },
                                    side: const BorderSide(color: Color(0xFF373737)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    activeColor: const Color(0xFF264167),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Saya setuju dengan syarat & kebijakan',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF646464),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            
                            // Register Button
                            SizedBox(
                              width: double.infinity,
                              height: 51,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                                  },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF264167),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Masuk',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
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
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          color: const Color(0xFF264167),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: const Color(0xFF9C9999),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF264167)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF264167)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF264167), width: 1.5),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
