

import '../../data/model/inspections_model.dart';

abstract class InspectionsReposetory {

  Future<InspectionResponse> getInspectionsData();
}