import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_state.dart';
import 'package:mahu_home_services_app/features/services/models/service_type.dart';
import 'package:mahu_home_services_app/features/services/views/screens/select_coverage_area_screen.dart';
import 'package:mahu_home_services_app/features/services/views/screens/select_service_type_screen.dart';

import '../../cubit/servises_cubit.dart';

class EnterServiceDetailsScreen extends StatefulWidget {
  const EnterServiceDetailsScreen({super.key});

  @override
  State<EnterServiceDetailsScreen> createState() =>
      _EnterServiceDetailsScreenState();
}

class _EnterServiceDetailsScreenState extends State<EnterServiceDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _instructionController = TextEditingController();
  final _durationController = TextEditingController();

  final _categories = ["cleaning", "ironing", "babysitting", "other"];
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final cubit = ServiceCubit.get(context);
    final pricingModel = cubit.pricingModel;

    return Scaffold(
      appBar: AppBar(title: const Text('Enter Service Details')),
      body: BlocBuilder<ServiceCubit, ServiceState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField("Service Name", _nameController),
                  _buildTextField("Description", _descController, maxLines: 3),
                  if (pricingModel == PricingModel.fixed)
                    _buildTextField("Base Price (e.g. 150)", _priceController,
                        keyboardType: TextInputType.number),
                  if (pricingModel == PricingModel.photoBased)
                    _buildTextField(
                        "Price Instructions", _instructionController,
                        maxLines: 3),
                  _buildTextField(
                      "Estimated Duration (minutes)", _durationController,
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 10),
                  _buildCategoryDropdown(),
                  const SizedBox(height: 10),
                  _buildImageUpload(cubit),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.serviceName = _nameController.text;
                        cubit.description = _descController.text;
                        if (pricingModel == PricingModel.fixed) {
                          cubit.basePrice = double.parse(_priceController.text);
                        } else {
                          cubit.priceInstructions = _instructionController.text;
                        }
                        cubit.duration = int.parse(_durationController.text);
                        cubit.category = _selectedCategory ?? "cleaning";

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SelectCoverageAreaScreen(),
                            ));
                      }
                    },
                    child: const Text("Next"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: (val) => val == null || val.isEmpty ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      items: _categories
          .map((e) => DropdownMenuItem(value: e, child: Text(e.toUpperCase())))
          .toList(),
      onChanged: (val) {
        setState(() {
          _selectedCategory = val;
        });
      },
      decoration: const InputDecoration(
        labelText: "Service Category",
        border: OutlineInputBorder(),
      ),
      validator: (val) => val == null ? "Please select category" : null,
    );
  }

  Widget _buildImageUpload(ServiceCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Service Image",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () async {
            final picker = ImagePicker();
            final image = await picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              cubit.imageUrl = image.path;
            }
          },
          icon: const Icon(Icons.upload),
          label: const Text("Upload Image"),
        ),
        const SizedBox(height: 8),
        if (cubit.imageUrl.isNotEmpty)
          Image.file(
            File(cubit.imageUrl),
            height: 150,
            fit: BoxFit.cover,
          )
      ],
    );
  }
}
