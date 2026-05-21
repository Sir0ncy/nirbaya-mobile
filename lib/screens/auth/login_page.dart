import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF264167),
      body: Stack(
        children: [
          // ── Gradient 1: Kanan Atas — highlight terang, kecil & kuat ──
          Positioned(
            top: -170,
            right: -190,
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
            top: 160,
            left: -230,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.42),
                    Colors.white.withValues(alpha: 0.10),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.50, 1.0],
                ),
              ),
            ),
          ),

          // Foreground Image: auth_img.png
          Positioned(
            top: 60, // Turun sedikit dari status bar
            right: -50, // Menyesuaikan agar letaknya mirip di Figma (sedikit terpotong di kanan)
            child: Transform.rotate(
              angle: 6.06 * pi / 180, // Rotasi ~6 derajat
              child: Image.asset(
                'assets/images/auth_img.png',
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
                      const SizedBox(height: 20),
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Masuk ke akun',
                                style: GoogleFonts.poppins(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Silakan masukkan email dan password Anda',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF8C8C8C),
                                ),
                              ),
                              const SizedBox(height: 32),
                              
                              // Email Field
                              _buildTextField(
                                label: 'Email',
                                hintText: 'Ketikan email Anda',
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                errorText: _emailError,
                                onChanged: (value) {
                                  if (_emailError != null) {
                                    setState(() {
                                      _emailError = null;
                                    });
                                  }
                                },
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
                              const SizedBox(height: 40),
                              
                              // Login Button
                              SizedBox(
                                width: double.infinity,
                                height: 51,
                                child: ElevatedButton(
                                  onPressed: () {
                                    String emailValue = _emailController.text;
                                    bool isEmailValid = true;

                                    if (emailValue.isEmpty) {
                                      setState(() {
                                        _emailError = 'Email tidak boleh kosong';
                                      });
                                      isEmailValid = false;
                                    } else {
                                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                      if (!emailRegex.hasMatch(emailValue)) {
                                        setState(() {
                                          _emailError = 'Format email tidak sesuai';
                                        });
                                        isEmailValid = false;
                                      } else {
                                        setState(() {
                                          _emailError = null;
                                        });
                                      }
                                    }

                                    bool isFormValid = _formKey.currentState?.validate() ?? false;

                                    if (isEmailValid && isFormValid) {
                                      // Handle login action
                                    }
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
                              const SizedBox(height: 16),
                              
                              // Register link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Belum punya akun? ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF646464),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                                      );
                                    },
                                    child: Text(
                                      'Daftar',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF264167),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    TextEditingController? controller,
    void Function(String)? onChanged,
    String? errorText,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        errorText: errorText,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
