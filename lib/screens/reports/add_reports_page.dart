import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../routes/app_routes.dart';

const Color _navy = Color(0xFF2B4771);
const Color _buttonBlue = Color(0xFF2F4A73);
const Color _fieldBorder = Color(0xFFC9D2E0);
const Color _fieldText = Color(0xFF1B2B46);
const LatLong _tuguJogja = LatLong(-7.7829, 110.3667);

class AddReportsPage extends StatefulWidget {
  const AddReportsPage({super.key});

  @override
  State<AddReportsPage> createState() => _AddReportsPageState();
}

class _AddReportsPageState extends State<AddReportsPage> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final ImagePicker _mediaPicker = ImagePicker();

  XFile? _pickedMedia;
  bool _isVideo = false;
  double? _pickedLat;
  double? _pickedLng;

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _timeController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.reports),
        ),
        title: const Text(
          'Laporan kejadian',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: _showMediaSheet,
                child: DottedBorder(
                  color: _fieldBorder,
                  strokeWidth: 1.2,
                  dashPattern: const [8, 6],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 170,
                    child: _buildMediaPreview(),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _FieldLabel(text: 'Judul kejadian'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _titleController,
                hintText: 'Geng motor melakukan klitih',
              ),
              const SizedBox(height: 14),
              _FieldLabel(text: 'Lokasi kejadian'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _locationController,
                hintText: 'Pilih lokasi kejadian',
                readOnly: true,
                suffixIcon: const Icon(Icons.location_on_outlined, color: _fieldText),
                onTap: _openLocationPicker,
              ),
              if (_pickedLat != null && _pickedLng != null)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    'Lat: ${_pickedLat!.toStringAsFixed(5)}, Lng: ${_pickedLng!.toStringAsFixed(5)}',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF6C7A92)),
                  ),
                ),
              const SizedBox(height: 14),
              _FieldLabel(text: 'Waktu'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _timeController,
                hintText: '21.35',
                readOnly: true,
                suffixIcon: const Icon(Icons.expand_more, color: _fieldText),
                onTap: _pickTime,
              ),
              const SizedBox(height: 14),
              _FieldLabel(text: 'Detail kejadian'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _detailController,
                hintText: 'Tulis detail kejadian di sini...',
                maxLines: 5,
                textInputAction: TextInputAction.newline,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _buttonBlue,
                    foregroundColor: Colors.white,
                    elevation: 6,
                    shadowColor: _buttonBlue.withOpacity(0.35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Kirim laporan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaPreview() {
    if (_pickedMedia == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.camera_alt_outlined, size: 54, color: Color(0xFF8A97AD)),
          SizedBox(height: 10),
          Text(
            'Tambahkan foto kejadian',
            style: TextStyle(fontSize: 14, color: Color(0xFF2E2E2E)),
          ),
        ],
      );
    }

    if (_isVideo) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.videocam, size: 42, color: _fieldText),
          const SizedBox(height: 10),
          Text(
            _pickedMedia!.name,
            style: const TextStyle(fontSize: 13, color: _fieldText),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.file(
        File(_pickedMedia!.path),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool readOnly = false,
    int maxLines = 1,
    TextInputAction? textInputAction,
    Widget? suffixIcon,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      textInputAction: textInputAction,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF8A97AD), fontSize: 13),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _fieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _navy, width: 1.2),
        ),
      ),
      style: const TextStyle(color: _fieldText, fontSize: 13, fontWeight: FontWeight.w600),
    );
  }

  Future<void> _showMediaSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _MediaOption(
                  icon: Icons.photo_camera,
                  label: 'Ambil foto (kamera)',
                  onTap: () => _pickImage(ImageSource.camera),
                ),
                _MediaOption(
                  icon: Icons.videocam,
                  label: 'Ambil video (kamera)',
                  onTap: () => _pickVideo(ImageSource.camera),
                ),
                _MediaOption(
                  icon: Icons.photo_library,
                  label: 'Pilih foto dari galeri',
                  onTap: () => _pickImage(ImageSource.gallery),
                ),
                _MediaOption(
                  icon: Icons.video_library,
                  label: 'Pilih video dari galeri',
                  onTap: () => _pickVideo(ImageSource.gallery),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    Navigator.of(context).pop();
    final XFile? file = await _mediaPicker.pickImage(source: source, imageQuality: 85);
    if (file == null) {
      return;
    }
    setState(() {
      _pickedMedia = file;
      _isVideo = false;
    });
  }

  Future<void> _pickVideo(ImageSource source) async {
    Navigator.of(context).pop();
    final XFile? file = await _mediaPicker.pickVideo(source: source);
    if (file == null) {
      return;
    }
    setState(() {
      _pickedMedia = file;
      _isVideo = true;
    });
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(alwaysUse24HourFormat: true),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked == null) {
      return;
    }
    setState(() {
      final String hour = picked.hour.toString().padLeft(2, '0');
      final String minute = picked.minute.toString().padLeft(2, '0');
      _timeController.text = '$hour.$minute';
    });
  }

  Future<void> _openLocationPicker() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: SafeArea(
            child: FlutterLocationPicker(
              userAgent: 'Nirbaya/1.0 (support@nirbaya.app)',
              initPosition: _tuguJogja,
              onPicked: (pickedData) {
                final latLong = pickedData.latLong;
                final String address = pickedData.address;
                setState(() {
                  _pickedLat = latLong.latitude;
                  _pickedLng = latLong.longitude;
                  _locationController.text = address.isNotEmpty
                      ? address
                      : '${latLong.latitude.toStringAsFixed(5)}, ${latLong.longitude.toStringAsFixed(5)}';
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF2D2D2D)),
    );
  }
}

class _MediaOption extends StatelessWidget {
  const _MediaOption({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: _navy),
      title: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      onTap: onTap,
    );
  }
}
