

import '../../data/model/inspections_details_model.dart';
import '../reposetory/inspections_details_reposetory.dart';

class InspectionsDetailsUsecase {
  InspectionsDetailsUsecase({required this.reposetory});
  final InspectionsDetailsReposetory reposetory;

  Future<InspectionDetailsResponse>getInspectionsDetailsData( String id)=> reposetory.getInspectionsDetailsData(id);

  Future<InspectionDetailsResponse>updateInspectionsDetailsData(Map<String, dynamic> data)=> reposetory.updateInspectionsDetailsData(data);
}
