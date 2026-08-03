import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/features/common/auth/providers/onboarding_provider.dart';
import 'package:sharespot/features/common/auth/widgets/auth_flexible_gap.dart';
import 'package:sharespot/features/common/auth/widgets/auth_select_field.dart';
import 'package:sharespot/features/common/auth/widgets/auth_sheet_heading.dart';
import 'package:sharespot/features/common/auth/widgets/auth_text_field.dart';
import 'package:sharespot/features/common/auth/widgets/gradient_auth_scaffold.dart';
import 'package:sharespot/features/common/auth/widgets/onboarding_primary_button.dart';

class VehicleDetailsScreen extends StatefulWidget {
  const VehicleDetailsScreen({super.key});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _yearController = TextEditingController();
  final _licenseController = TextEditingController();

  @override
  void dispose() {
    _yearController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  Future<void> _pickYear() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year),
      firstDate: DateTime(1980),
      lastDate: DateTime(now.year + 1),
      helpText: 'Select vehicle year',
    );
    if (selected != null) {
      _yearController.text = selected.year.toString();
    }
  }

  Future<void> _continue() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final success = await context.read<OnboardingProvider>().saveVehicle(
      year: _yearController.text,
      licensePlate: _licenseController.text.trim(),
    );
    if (!mounted || !success) return;
    Navigator.pushNamed(context, AppRouteNames.permissions);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();

    return GradientAuthScaffold(
      headerFraction: context.isCompactHeight ? 0.18 : 0.38,
      topPadding: context.isCompactHeight ? 18 : 24,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthSheetHeading(
              title: 'Vehicle Details',
              subtitle: 'Tell us about your vehicle',
            ),
            AuthFlexibleGap(height: context.isCompactHeight ? 10 : 24),
            AuthSelectField(
              label: 'Vehicle Type',
              value: provider.vehicleType,
              items: const ['Sedan', 'SUV', 'Hatchback', 'Truck'],
              onChanged: provider.setVehicleType,
            ),
            AuthFlexibleGap(height: context.isCompactHeight ? 8 : 16),
            AuthSelectField(
              label: 'Model',
              value: provider.vehicleModel,
              items: const ['Camry', 'Civic', 'Corolla', 'City'],
              onChanged: provider.setVehicleModel,
            ),
            AuthFlexibleGap(height: context.isCompactHeight ? 8 : 16),
            AuthTextField(
              controller: _yearController,
              label: 'Make',
              hintText: 'e.g. 2025',
              readOnly: true,
              onTap: _pickYear,
              suffixIcon: IconButton(
                onPressed: _pickYear,
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.iconMuted,
                  size: 18,
                ),
              ),
              validator: (value) => (value ?? '').isEmpty
                  ? 'Please select the vehicle year'
                  : null,
            ),
            AuthFlexibleGap(height: context.isCompactHeight ? 8 : 16),
            AuthTextField(
              controller: _licenseController,
              label: 'License Plate',
              hintText: 'e.g. LSE-3233',
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _continue(),
              validator: (value) => (value ?? '').trim().isEmpty
                  ? 'Please enter the license plate'
                  : null,
            ),
            AuthFlexibleGap(height: context.isCompactHeight ? 10 : 26),
            OnboardingPrimaryButton(
              label: 'Continue',
              isLoading: provider.isLoading,
              onPressed: _continue,
            ),
          ],
        ),
      ),
    );
  }
}
