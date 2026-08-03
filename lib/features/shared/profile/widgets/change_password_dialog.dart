import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'profile_form_field.dart';

typedef ChangePasswordCallback =
    Future<bool> Function({
      required String currentPassword,
      required String newPassword,
    });

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({required this.onChangePassword, super.key});

  final ChangePasswordCallback onChangePassword;

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  final _obscured = <bool>[true, true, true];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    setState(() => _isSubmitting = true);
    final success = await widget.onChangePassword(
      currentPassword: _currentController.text,
      newPassword: _newController.text,
    );
    if (!mounted) return;
    setState(() => _isSubmitting = false);
    if (!success) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 22 : 80,
        vertical: 24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.borderDialog),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 430),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: AppColors.hexFFE7FFE8,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_reset_rounded,
                        color: AppColors.hexFF229431,
                        size: 20,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      tooltip: 'Close',
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(
                        Icons.close_rounded,
                        color: AppColors.iconLight,
                        size: 21,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Change Your Password',
                  style: AppTextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'For your security, verify your current password and set a new one.',
                  style: AppTextStyle(
                    color: AppColors.hexFFC4C5CA,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 18),
                _passwordField(
                  index: 0,
                  label: 'Current Password',
                  controller: _currentController,
                ),
                const SizedBox(height: 15),
                _passwordField(
                  index: 1,
                  label: 'New Password',
                  controller: _newController,
                ),
                const SizedBox(height: 15),
                _passwordField(
                  index: 2,
                  label: 'Confirm Password',
                  controller: _confirmController,
                  isConfirmation: true,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: context.screenWidth,
                  height: 54,
                  child: FilledButton(
                    onPressed: _isSubmitting ? null : _changePassword,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.loginGreen,
                      foregroundColor: AppColors.buttonInk,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: _isSubmitting
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.buttonInk,
                            ),
                          )
                        : const Text(
                            'Yes, Change',
                            style: AppTextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
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

  Widget _passwordField({
    required int index,
    required String label,
    required TextEditingController controller,
    bool isConfirmation = false,
  }) {
    return ProfileFormField(
      label: label,
      controller: controller,
      hintText: 'Enter password',
      obscureText: _obscured[index],
      textInputAction: isConfirmation
          ? TextInputAction.done
          : TextInputAction.next,
      onFieldSubmitted: isConfirmation ? (_) => _changePassword() : null,
      suffixIcon: IconButton(
        onPressed: () => setState(() => _obscured[index] = !_obscured[index]),
        tooltip: _obscured[index] ? 'Show password' : 'Hide password',
        icon: Icon(
          _obscured[index]
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: AppColors.iconSubtle,
          size: 18,
        ),
      ),
      validator: (value) {
        if ((value ?? '').length < 6) {
          return 'Use at least 6 characters';
        }
        if (isConfirmation && value != _newController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }
}
