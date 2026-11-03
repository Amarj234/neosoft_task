

import '../../domain/reposetory/inspections_details_reposetory.dart';
import '../data_source/inspections_details_data_source.dart';
import '../model/inspections_details_model.dart';

class InspectionsDetailsReposetoryImpl extends InspectionsDetailsReposetory {
  final InspectionsDetailsDataSource dataSource;
  InspectionsDetailsReposetoryImpl({required this.dataSource});

  Future<InspectionDetailsResponse>getInspectionsDetailsData( String id) => dataSource.getInspectionsDetailsData(id);

  Future<InspectionDetailsResponse>updateInspectionsDetailsData(Map<String, dynamic> data) => dataSource.updateInspectionsDetailsData(data);


}