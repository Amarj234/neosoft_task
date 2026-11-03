

import '../model/inspections_details_model.dart';

abstract class InspectionsDetailsDataSource {

  Future<InspectionDetailsResponse>getInspectionsDetailsData( String id);

  Future<InspectionDetailsResponse>updateInspectionsDetailsData(Map<String, dynamic> data);
}