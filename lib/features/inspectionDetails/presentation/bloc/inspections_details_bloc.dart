

import 'package:bloc/bloc.dart';

import '../../domain/usecase/inspections_details_usecase.dart';
import 'inspections_details_event.dart';
import 'inspections_details_state.dart';

class InspectionsDetailsBloc  extends Bloc<InspectionsDetailsEvent, InspectionsDetailsState>{
  final InspectionsDetailsUsecase usecase;
  InspectionsDetailsBloc(this.usecase) : super(InspectionsDetailsStateInitial()) {
    on<InspectionsDetailsFetchEvent>(_fetchInspectionsDetails);
    on<InspectionsUpdateDetailsc>(_updateInspectionsDetails);

  }

  _fetchInspectionsDetails( InspectionsDetailsFetchEvent event , Emitter<InspectionsDetailsState> emit) async{

    try{
      emit(InspectionsDetailsStateLoading());
      final data=await usecase.getInspectionsDetailsData(event.id);
      emit(InspectionsDetailsStateSuccess(data));
    }catch(e){
      emit(InspectionsDetailsStateError(e.toString()));

    }
  }

  _updateInspectionsDetails(InspectionsUpdateDetailsc event , Emitter<InspectionsDetailsState> emit) async{

    try{
      emit(InspectionsDetailsStateLoading());
      final data=await usecase.updateInspectionsDetailsData(event.data);
      if(data.success==true){
      emit(InspectionsDetailsStateSuccess(data));}
  }catch(e){
      emit(InspectionsDetailsStateError(e.toString()));
    }
}

}