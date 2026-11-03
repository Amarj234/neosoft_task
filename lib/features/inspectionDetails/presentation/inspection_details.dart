import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main_injection.dart';
import '../../home_screen/data/model/inspections_model.dart';
import '../../home_screen/presantetion/bloc/inspections_bloc.dart';
import '../../home_screen/presantetion/bloc/inspections_event.dart';
import 'Inspector_edit.dart';
import 'bloc/inspections_details_bloc.dart';
import 'bloc/inspections_details_event.dart';
import 'bloc/inspections_details_state.dart';

class InspectionDetails extends StatelessWidget {
  final String id;
  const InspectionDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    InspectionItem? items;
    return BlocProvider(
      create: (context) =>
          sl<InspectionsDetailsBloc>()..add(InspectionsDetailsFetchEvent(id)),
      child: BlocBuilder<InspectionsDetailsBloc, InspectionsDetailsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    if (state is! InspectionsDetailsStateSuccess) return;

                    // Navigate to the form and wait for returning values
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditInspectionScreen(inspectionItem: state.data),
                      ),
                    );

                    if (result != null) {
                      final updatedFields = result as Map<String, dynamic>;

                      context.read<InspectionsDetailsBloc>().add(
                        InspectionsUpdateDetailsc(updatedFields),
                      );

                      // amarjeet we can also find edited id and then update only that id using copywith method
                      sl.get<InspectionsBloc>().add(GetInspectionsEvent());
                    }
                  },
                ),
              ],
              title: const Text(
                'Inspection Details',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.blue[700],
              elevation: 2,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: SafeArea(
              child: Builder(
                builder: (context) {
                  if (state is InspectionsDetailsStateLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is InspectionsDetailsStateSuccess) {
                    final item = state.data.data;

                    if (item == null) {
                      return const Center(
                        child: Text('No details found for this inspection.'),
                      );
                    }

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Card with Title and Status
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: Colors.grey[200]!),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildPriorityChip(item.priority),
                                      _buildStatusChip(item.status),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    item.inspectionTitle,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Location & Site Details Card
                          _buildSectionTitle('Location Information'),
                          const SizedBox(height: 8),
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: Colors.grey[200]!),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  _buildInfoRow(
                                    Icons.business,
                                    'Site Name',
                                    item.siteName,
                                  ),
                                  const Divider(height: 24),
                                  _buildInfoRow(
                                    Icons.location_on_rounded,
                                    'Location',
                                    item.location,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Schedule & Metadata Card
                          _buildSectionTitle('Timeline & Overview'),
                          const SizedBox(height: 8),
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: Colors.grey[200]!),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  _buildInfoRow(
                                    Icons.calendar_today_rounded,
                                    'Inspection Date',
                                    item.inspectionDate,
                                  ),
                                  const Divider(height: 24),
                                  _buildInfoRow(
                                    Icons.add_circle_outline_rounded,
                                    'Created On',
                                    item.createdOn.toString().substring(0, 10),
                                  ),
                                  if (item.updatedOn != null) ...[
                                    const Divider(height: 24),
                                    _buildInfoRow(
                                      Icons.edit_calendar_rounded,
                                      'Last Updated',
                                      item.updatedOn.toString().substring(
                                        0,
                                        10,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // if (state is InspectionsDetailsStateFailure) {
                  //   return Center(
                  //     child: Text(
                  //       'Something went wrong. Please try again.',
                  //       style: TextStyle(color: Colors.red[700]),
                  //     ),
                  //   );
                  // }

                  return const Center(child: Text('Something went wrong.'));
                },
              ),
            ),
          );
        },
      ),
    );
  }

  // Section Headers
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // Generic Row Layout for Information
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue[700], size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Dynamic Priority Badges
  Widget _buildPriorityChip(String priority) {
    Color color;
    switch (priority.toLowerCase()) {
      case 'high':
        color = Colors.red;
        break;
      case 'medium':
        color = Colors.orange;
        break;
      default:
        color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        '$priority Priority',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  // Dynamic Status Badges
  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'completed':
        color = Colors.green;
        break;
      case 'in progress':
        color = Colors.blue;
        break;
      default:
        color = Colors.amber[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
