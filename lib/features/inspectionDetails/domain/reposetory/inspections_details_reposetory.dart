

import '../../data/model/inspections_details_model.dart';

abstract class InspectionsDetailsReposetory {

  Future<InspectionDetailsResponse>getInspectionsDetailsData( String id);

  Future<InspectionDetailsResponse>updateInspectionsDetailsData(Map<String, dynamic> data);

}