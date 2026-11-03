


import '../../domain/reposetory/inspections_reposetory.dart';
import '../data_source/inspections_data_source.dart';
import '../model/inspections_model.dart';

class InspectionsReposetoryImpl extends InspectionsReposetory{
  final InspectionsDataSource dataSource;
  InspectionsReposetoryImpl(this.dataSource);

  @override
  Future<InspectionResponse> getInspectionsData() => dataSource.getInspectionsData();


}