

import 'package:flutter/material.dart';

import '../../home_screen/data/model/inspections_model.dart';
import '../data/model/inspections_details_model.dart';

// Assuming you import your InspectionItem data model here
// import 'path_to_your_model/inspection_item.dart';

class EditInspectionScreen extends StatefulWidget {
// Pass your InspectionItem model object here
final InspectionDetailsResponse inspectionItem;

  const EditInspectionScreen({super.key, required this.inspectionItem,});

  @override
  State<EditInspectionScreen> createState() => _EditInspectionScreenState();
}

class _EditInspectionScreenState extends State<EditInspectionScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController _titleController;
  late TextEditingController _siteController;
  late TextEditingController _locationController;

  // Form Dropdown Values
  String? _selectedPriority;
  String? _selectedStatus;

  final List<String> _priorities = ['High', 'Medium', 'Low'];
  final List<String> _statuses = ['Pending', 'In Progress', 'Completed'];

  @override
  void initState() {


    super.initState();
    // Initialize fields with current data
    _titleController = TextEditingController(text: widget.inspectionItem.data?.inspectionTitle);
    _siteController = TextEditingController(text: widget.inspectionItem.data?.siteName);
    _locationController = TextEditingController(text: widget.inspectionItem.data?.location);

    // Exact string match with validation backup
    _selectedPriority = _priorities.contains(widget.inspectionItem.data?.priority)
        ? widget.inspectionItem.data?.priority
        : _priorities.first;
    _selectedStatus = _statuses.contains(widget.inspectionItem.data?.status)
        ? widget.inspectionItem.data?.status
        : _statuses.first;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _siteController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Edit Inspection',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Text Inputs Section
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Inspection Title',
                            prefixIcon: Icon(Icons.title),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _siteController,
                          decoration: const InputDecoration(
                            labelText: 'Site Name',
                            prefixIcon: Icon(Icons.business),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a site name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _locationController,
                          decoration: const InputDecoration(
                            labelText: 'Location',
                            prefixIcon: Icon(Icons.location_on),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a location';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Categorization & Dropdowns Section
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: _selectedPriority,
                          decoration: const InputDecoration(
                            labelText: 'Priority',
                            prefixIcon: Icon(Icons.outlined_flag),
                            border: OutlineInputBorder(),
                          ),
                          items: _priorities.map((String priority) {
                            return DropdownMenuItem(
                              value: priority,
                              child: Text(priority),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedPriority = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedStatus,
                          decoration: const InputDecoration(
                            labelText: 'Status',
                            prefixIcon: Icon(Icons.donut_large),
                            border: OutlineInputBorder(),
                          ),
                          items: _statuses.map((String status) {
                            return DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedStatus = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Save Action Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Collect updated values
                      final updatedFields = {
                        "id": widget.inspectionItem.data?.id,
                        "inspectionTitle": _titleController.text.trim(),
                        "siteName": _siteController.text.trim(),
                        "location": _locationController.text.trim(),
                        "priority": _selectedPriority,
                        "status": _selectedStatus,
                      };



                      // Navigate back passing updated data out
                      Navigator.pop(context, updatedFields);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
