

import '../../data/model/inspections_model.dart';

sealed class InspectionsState {}


class InspectionsInitial extends InspectionsState {}

class InspectionsLoading extends InspectionsState {}

class InspectionsSuceess extends InspectionsState{

  final InspectionResponse response;

  InspectionsSuceess(this.response);
}

class InspectionsFailure extends InspectionsState{

  final String error;

  InspectionsFailure(this.error);
}
