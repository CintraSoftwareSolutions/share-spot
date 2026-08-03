import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/features/host/profile/providers/profile_provider.dart';
import 'package:sharespot/features/shared/profile/widgets/profile_form_field.dart';
import 'package:sharespot/features/shared/profile/widgets/profile_page_scaffold.dart';
import 'package:sharespot/features/shared/profile/widgets/profile_select_field.dart';

class VehicleManagementScreen extends StatefulWidget {
  const VehicleManagementScreen({super.key});

  @override
  State<VehicleManagementScreen> createState() =>
      _VehicleManagementScreenState();
}

class _VehicleManagementScreenState extends State<VehicleManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _makeController;
  late final TextEditingController _licenseController;
  late String _vehicleType;
  late String _model;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>();
    _vehicleType = profile.vehicleType;
    _model = profile.model;
    _makeController = TextEditingController(text: profile.make);
    _licenseController = TextEditingController(text: profile.licensePlate);
  }

  @override
  void dispose() {
    _makeController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    final success = await context.read<ProfileProvider>().saveVehicle(
      vehicleType: _vehicleType,
      make: _makeController.text.trim(),
      model: _model,
      licensePlate: _licenseController.text.trim(),
    );
    if (!mounted || !success) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Vehicle details saved.')));
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<ProfileProvider, bool>(
      (provider) => provider.isLoading,
    );
    final padding = context.isMobile ? 20.0 : 32.0;
    return ProfilePageScaffold(
      title: 'Vehicle Details',
      actionLabel: 'Save Details',
      onAction: _save,
      isLoading: isLoading,
      child: Form(
        key: _formKey,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(padding, 16, padding, 20),
          children: [
            ProfileSelectField(
              label: 'Vehicle Type',
              value: _vehicleType,
              items: const ['Sedan', 'SUV', 'Hatchback', 'Truck'],
              onChanged: (value) {
                if (value != null) setState(() => _vehicleType = value);
              },
            ),
            const SizedBox(height: 18),
            ProfileFormField(
              label: 'Make',
              controller: _makeController,
              hintText: 'e.g. 2015',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              suffixIcon: const Icon(
                Icons.calendar_today_outlined,
                color: AppColors.textTertiary,
                size: 17,
              ),
              validator: _required,
            ),
            const SizedBox(height: 18),
            ProfileSelectField(
              label: 'Model',
              value: _model,
              items: const ['Camry', 'Civic', 'Corolla', 'City'],
              onChanged: (value) {
                if (value != null) setState(() => _model = value);
              },
            ),
            const SizedBox(height: 18),
            ProfileFormField(
              label: 'License Plate',
              controller: _licenseController,
              hintText: 'e.g. LSE-3233',
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _save(),
              validator: _required,
            ),
          ],
        ),
      ),
    );
  }

  String? _required(String? value) {
    return (value ?? '').trim().isEmpty ? 'This field is required' : null;
  }
}
