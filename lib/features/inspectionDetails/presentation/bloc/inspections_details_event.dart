

abstract class InspectionsDetailsEvent {}


class InspectionsDetailsFetchEvent extends InspectionsDetailsEvent {

  final String id;
  InspectionsDetailsFetchEvent(this.id);
}

class InspectionsUpdateDetailsc extends InspectionsDetailsEvent{

  Map<String, dynamic> data;
  InspectionsUpdateDetailsc(this.data);
}
