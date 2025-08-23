import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahu_home_services_app/features/services/models/user_base_profile_model.dart';
import 'package:mahu_home_services_app/features/services/services/profile_services.dart';

class EditProfileScreen extends StatefulWidget {
  final UserBaseProfileModel user;

  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  File? _avatarImageFile;
  String? _avatarUrl;

  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.user.email ?? '');
    _phoneController = TextEditingController(text: widget.user.phone ?? '');
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _avatarUrl = widget.user.avatar;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _avatarImageFile = File(pickedFile.path);
        _avatarUrl = null;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    String? avatarToUpload;

    if (_avatarImageFile != null) {

      avatarToUpload = await uploadImage(_avatarImageFile!);

      // avatarToUpload = _avatarImageFile!.path;
    } else {
      avatarToUpload = _avatarUrl;
    }

    final service = ProfileServices();
    final result = await service.editProfile(
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      avatar: avatarToUpload,
    );

    result.fold(
          (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
          (updatedProfile) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        Navigator.pop(context, updatedProfile);
      },
    );

    setState(() => _isLoading = false);
  }

  Widget _buildAvatar() {
    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: CircleAvatar(
          radius: 60.r,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: _avatarImageFile != null
              ? FileImage(_avatarImageFile!)
              : (_avatarUrl != null && _avatarUrl!.isNotEmpty
              ? NetworkImage(_avatarUrl!)
              : AssetImage('assets/imgs/no_avatar.png'))
          as ImageProvider<Object>,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildAvatar(),
              SizedBox(height: 20.h),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (val) =>
                val == null || val.isEmpty ? 'Email cannot be empty' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (val) =>
                val == null || val.isEmpty ? 'Phone cannot be empty' : null,
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (val) =>
                val == null || val.isEmpty ? 'First name cannot be empty' : null,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (val) =>
                val == null || val.isEmpty ? 'Last name cannot be empty' : null,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _isLoading ? null : _saveProfile,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
