import 'dart:convert';

class InspectionResponse {
  final bool success;
  final String? message;
  final List<InspectionItem> data;
  final dynamic errors;

  InspectionResponse({
    required this.success,
    this.message,
    required this.data,
    this.errors,
  });

  factory InspectionResponse.fromJson(Map<String, dynamic> json) {
    return InspectionResponse(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null
          ? List<InspectionItem>.from(
        json['data'].map((x) => InspectionItem.fromJson(x)),
      )
          : [],
      errors: json['errors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
      'errors': errors,
    };
  }
}

class InspectionItem {
  final int id;
  final String inspectionTitle;
  final String siteName;
  final String location;
  final String inspectionDate; // Alternatively use DateTime if preferred
  final String priority;
  final String status;
  final DateTime createdOn;
  final DateTime? updatedOn;

  InspectionItem({
    required this.id,
    required this.inspectionTitle,
    required this.siteName,
    required this.location,
    required this.inspectionDate,
    required this.priority,
    required this.status,
    required this.createdOn,
    this.updatedOn,
  });

  factory InspectionItem.fromJson(Map<String, dynamic> json) {
    return InspectionItem(
      id: json['id'] ?? 0,
      inspectionTitle: json['inspectionTitle'] ?? '',
      siteName: json['siteName'] ?? '',
      location: json['location'] ?? '',
      inspectionDate: json['inspectionDate'] ?? '',
      priority: json['priority'] ?? '',
      status: json['status'] ?? '',
      createdOn: json['createdOn'] != null
          ? DateTime.parse(json['createdOn'])
          : DateTime.now(),
      updatedOn: json['updatedOn'] != null
          ? DateTime.parse(json['updatedOn'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'inspectionTitle': inspectionTitle,
      'siteName': siteName,
      'location': location,
      'inspectionDate': inspectionDate,
      'priority': priority,
      'status': status,
      'createdOn': createdOn.toIso8601String(),
      'updatedOn': updatedOn?.toIso8601String(),
    };
  }
}
