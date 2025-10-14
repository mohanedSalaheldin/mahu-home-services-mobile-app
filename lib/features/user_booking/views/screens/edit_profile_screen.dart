import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/services/models/user_base_profile_model.dart';
import 'package:mahu_home_services_app/features/services/services/profile_services.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class EditProfileScreen extends StatefulWidget {
  final UserBaseProfileModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  // late TextEditingController _businessNameController;

  File? _avatarImageFile;
  String? _avatarUrl;
  bool _isLoading = false;
  bool _isUploading = false;
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
    final action = await showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading:
                    const Icon(Icons.photo_library, color: AppColors.primary),
                title: Text(S.of(context).editProfileScreenChooseFromGallery),
                onTap: () => Navigator.pop(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: AppColors.primary),
                title: Text(S.of(context).editProfileScreenTakePhoto),
                onTap: () => Navigator.pop(context, 2),
              ),
            ],
          ),
        );
      },
    );

    if (action == null) return;

    final source = action == 1 ? ImageSource.gallery : ImageSource.camera;

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _avatarImageFile = File(pickedFile.path);
          _avatarUrl = null;
        });
      }
    } catch (e) {
      _showErrorSnackBar(
          S.of(context).editProfileScreenImagePickError(e.toString()));
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    setState(() => _isUploading = true);

    try {
      String? imageUrl = await uploadImage(imageFile);

      if (imageUrl != null) {
        return imageUrl;
      } else {
        _showErrorSnackBar(S.of(context).editProfileScreenImageUploadError);
        return null;
      }
    } catch (e) {
      _showErrorSnackBar(S
          .of(context)
          .editProfileScreenImageUploadErrorDetailed(e.toString()));
      return null;
    } finally {
      setState(() => _isUploading = false);
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    String? avatarUrl;
    if (_avatarImageFile != null) {
      avatarUrl = await _uploadImage(_avatarImageFile!);
      if (avatarUrl == null) {
        setState(() => _isLoading = false);
        return;
      }
    } else {
      avatarUrl = _avatarUrl;
    }

    final service = ProfileServices();
    final result = await service.editUserProfile(
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      avatar: avatarUrl,
    );

    result.fold(
      (failure) {
        _showErrorSnackBar(failure.message);
      },
      (updatedProfile) {
        _showSuccessSnackBar(S.of(context).editProfileScreenSuccessMessage);
        print(updatedProfile);
        Navigator.pop(context, updatedProfile);
      },
    );

    setState(() => _isLoading = false);
  }

  void _showErrorSnackBar(String message) {
    showCustomSnackBar(
      context: context,
      message: message,
      type: SnackBarType.failure,
    );
  }

  void _showSuccessSnackBar(String message) {
    showCustomSnackBar(
      context: context,
      message: message,
      type: SnackBarType.success,
    );
  }

  Widget _buildAvatar() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 3,
            ),
          ),
          child: ClipOval(
            child: _isUploading
                ? Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                  )
                : _avatarImageFile != null
                    ? Image.file(
                        _avatarImageFile!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildPlaceholderAvatar(),
                      )
                    : _avatarUrl != null && _avatarUrl!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: _avatarUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.primary),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                _buildPlaceholderAvatar(),
                          )
                        : _buildPlaceholderAvatar(),
          ),
        ),
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: IconButton(
            icon: Icon(Icons.camera_alt, size: 20.w, color: Colors.white),
            onPressed: _pickImage,
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderAvatar() {
    return Container(
      color: Colors.grey.shade200,
      child: Icon(
        Icons.person,
        size: 50.w,
        color: Colors.grey.shade400,
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        Gap(6.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.primary, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              suffixIcon: suffixIcon,
            ),
            validator: validator,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          S.of(context).editProfileScreenTitle,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(child: _buildAvatar()),
                Gap(32.h),
                Text(
                  S.of(context).editProfileScreenPersonalInfo,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                Gap(20.h),
                _buildFormField(
                  controller: _firstNameController,
                  label: S.of(context).editProfileScreenFirstNameLabel,
                  hintText: S.of(context).editProfileScreenFirstNameHint,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).editProfileScreenFirstNameError;
                    }
                    return null;
                  },
                ),
                Gap(16.h),
                _buildFormField(
                  controller: _lastNameController,
                  label: S.of(context).editProfileScreenLastNameLabel,
                  hintText: S.of(context).editProfileScreenLastNameHint,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).editProfileScreenLastNameError;
                    }
                    return null;
                  },
                ),
                Gap(16.h),
                Text(
                  S.of(context).editProfileScreenContactInfo,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                Gap(20.h),
                _buildFormField(
                  controller: _emailController,
                  label: S.of(context).editProfileScreenEmailLabel,
                  hintText: S.of(context).editProfileScreenEmailHint,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).editProfileScreenEmailErrorEmpty;
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return S.of(context).editProfileScreenEmailErrorInvalid;
                    }
                    return null;
                  },
                ),
                Gap(16.h),
                _buildFormField(
                  controller: _phoneController,
                  label: S.of(context).editProfileScreenPhoneLabel,
                  hintText: S.of(context).editProfileScreenPhoneHint,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).editProfileScreenPhoneError;
                    }
                    return null;
                  },
                ),
                Gap(32.h),
                AppFilledButton(
                  onPressed: _isLoading ? () {} : _saveProfile,
                  fontSize: 16,
                  text: S.of(context).editProfileScreenSaveButton,
                ),
                Gap(20.h),
                TextButton(
                  onPressed: _isLoading ? null : () => Navigator.pop(context),
                  child: Text(
                    S.of(context).editProfileScreenCancelButton,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
