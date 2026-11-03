

import '../../data/model/inspections_model.dart';
import '../reposetory/inspections_reposetory.dart';

class InspectionsUsercase {
  InspectionsUsercase(this.reposetory);

  final InspectionsReposetory reposetory;

  Future<InspectionResponse> getInspectionsData()=>reposetory.getInspectionsData();
}