import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/features/guest/profile/providers/profile_provider.dart';
import 'package:sharespot/features/shared/profile/widgets/change_password_dialog.dart';
import 'package:sharespot/features/shared/profile/widgets/profile_form_field.dart';
import 'package:sharespot/features/shared/profile/widgets/profile_page_scaffold.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _locationController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>();
    _nameController = TextEditingController(text: profile.name);
    _emailController = TextEditingController(text: profile.email);
    _locationController = TextEditingController(text: profile.location);
    _passwordController = TextEditingController(text: 'password');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    final success = await context.read<ProfileProvider>().saveProfile(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      location: _locationController.text.trim(),
    );
    if (!mounted || !success) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Profile details saved.')));
  }

  Future<void> _openPasswordDialog() async {
    final changed = await showDialog<bool>(
      context: context,
      barrierColor: AppColors.black.withValues(alpha: 0.82),
      builder: (_) => ChangePasswordDialog(
        onChangePassword: context.read<ProfileProvider>().changePassword,
      ),
    );
    if (!mounted || changed != true) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password changed successfully.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<ProfileProvider, bool>(
      (provider) => provider.isLoading,
    );
    final padding = context.isMobile ? 20.0 : 32.0;
    return ProfilePageScaffold(
      title: 'Profile Settings',
      actionLabel: 'Save Details',
      onAction: _save,
      isLoading: isLoading,
      child: Form(
        key: _formKey,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(padding, 4, padding, 14),
          children: [
            const Text(
              'Upload Picture',
              style: AppTextStyle(
                color: AppColors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const CircleAvatar(
                    radius: 43,
                    backgroundColor: AppColors.hexFFE4E5E7,
                    backgroundImage: AssetImage(AppImages.profile),
                  ),
                  Positioned(
                    right: -1,
                    bottom: 2,
                    child: Container(
                      width: 19,
                      height: 19,
                      decoration: BoxDecoration(
                        color: AppColors.loginGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: AppColors.hexFF075B12,
                        size: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            ProfileFormField(
              label: 'Name',
              controller: _nameController,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(
                Icons.person_outline_rounded,
                color: AppColors.textTertiary,
                size: 18,
              ),
              validator: _required,
            ),
            const SizedBox(height: 15),
            ProfileFormField(
              label: 'Email Address',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(
                Icons.mail_outline_rounded,
                color: AppColors.textTertiary,
                size: 18,
              ),
              validator: (value) {
                final email = value?.trim() ?? '';
                return email.contains('@') && email.contains('.')
                    ? null
                    : 'Enter a valid email address';
              },
            ),
            const SizedBox(height: 15),
            ProfileFormField(
              label: 'Location',
              controller: _locationController,
              textInputAction: TextInputAction.done,
              validator: _required,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Password',
                  style: AppTextStyle(
                    color: AppColors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: _openPasswordDialog,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.authLink,
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Change',
                    style: AppTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              readOnly: true,
              obscureText: true,
              onTap: _openPasswordDialog,
              style: const AppTextStyle(color: AppColors.white, fontSize: 13),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.authField,
                isDense: true,
                suffixIcon: const Icon(
                  Icons.visibility_off_outlined,
                  color: AppColors.iconSubtle,
                  size: 18,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 13,
                ),
                border: _passwordBorder(),
                enabledBorder: _passwordBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _required(String? value) {
    return (value ?? '').trim().isEmpty ? 'This field is required' : null;
  }

  OutlineInputBorder _passwordBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: const BorderSide(color: AppColors.authBorder),
    );
  }
}
