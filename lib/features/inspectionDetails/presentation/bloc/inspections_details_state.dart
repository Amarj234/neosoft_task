


import '../../data/model/inspections_details_model.dart';

sealed class InspectionsDetailsState{}


class InspectionsDetailsStateInitial extends InspectionsDetailsState{}

class InspectionsDetailsStateLoading extends InspectionsDetailsState{}

class InspectionsDetailsStateSuccess extends InspectionsDetailsState{
  final InspectionDetailsResponse data;
  InspectionsDetailsStateSuccess(this.data);
}

class InspectionsDetailsStateError extends InspectionsDetailsState{
  final String message;
  InspectionsDetailsStateError(this.message);
}

