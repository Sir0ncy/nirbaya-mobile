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

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
            top: 80,
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
            top: 0, // Turun sedikit dari status bar
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
                                controller: _nameController,
                                errorText: _nameError,
                                onChanged: (value) {
                                  if (_nameError != null) {
                                    setState(() {
                                      _nameError = null;
                                    });
                                  }
                                },
                              ),
                              const SizedBox(height: 24),
                              
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
                                controller: _passwordController,
                                errorText: _passwordError,
                                onChanged: (value) {
                                  if (_passwordError != null) {
                                    setState(() {
                                      _passwordError = null;
                                    });
                                  }
                                },
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
                                    bool isFormValid = true;

                                    // Validasi Nama
                                    if (_nameController.text.isEmpty) {
                                      setState(() {
                                        _nameError = 'Nama tidak boleh kosong';
                                      });
                                      isFormValid = false;
                                    }

                                    // Validasi Email
                                    String emailValue = _emailController.text;
                                    if (emailValue.isEmpty) {
                                      setState(() {
                                        _emailError = 'Email tidak boleh kosong';
                                      });
                                      isFormValid = false;
                                    } else {
                                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                      if (!emailRegex.hasMatch(emailValue)) {
                                        setState(() {
                                          _emailError = 'Format email tidak sesuai';
                                        });
                                        isFormValid = false;
                                      }
                                    }

                                    // Validasi Password
                                    String passwordValue = _passwordController.text;
                                    if (passwordValue.isEmpty) {
                                      setState(() {
                                        _passwordError = 'Password tidak boleh kosong';
                                      });
                                      isFormValid = false;
                                    } else if (passwordValue.length < 8) {
                                      setState(() {
                                        _passwordError = 'Password harus minimal 8 karakter';
                                      });
                                      isFormValid = false;
                                    } else {
                                      // Cek kombinasi huruf, angka, dan simbol
                                      final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(passwordValue);
                                      final hasNumber = RegExp(r'[0-9]').hasMatch(passwordValue);
                                      final hasSymbol = RegExp(r'[!@#\$&*~`%\^()_+\-=\[\]{};' r"':" r'"\\|,.<>\/?]').hasMatch(passwordValue);
                                      
                                      if (!hasLetter || !hasNumber || !hasSymbol) {
                                        setState(() {
                                          _passwordError = 'Password harus mengandung huruf, angka, dan simbol';
                                        });
                                        isFormValid = false;
                                      }
                                    }

                                    if (!_agreeToTerms) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Anda harus menyetujui syarat & kebijakan'),
                                        ),
                                      );
                                      isFormValid = false;
                                    }

                                    if (isFormValid) {
                                      // Handle register action
                                      Navigator.pushReplacementNamed(context, AppRoutes.home);
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
                                    'Daftar',
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
    TextEditingController? controller,
    void Function(String)? onChanged,
    String? errorText,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        errorText: errorText,
        errorMaxLines: 2, // Biar tulisan panjang tidak terpotong
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
