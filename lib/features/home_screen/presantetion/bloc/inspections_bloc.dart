
import "../../domain/usecase/inspections_usercase.dart";
import "inspections_event.dart";
import "inspections_state.dart";
import 'package:bloc/bloc.dart';

class InspectionsBloc extends Bloc<InspectionsEvent, InspectionsState> {
  final InspectionsUsercase usercase;
  InspectionsBloc(this.usercase) : super(InspectionsInitial()) {

    on<GetInspectionsEvent>(getInpector);
  }

  getInpector(GetInspectionsEvent event, Emitter<InspectionsState> emit)async{

    emit(InspectionsLoading());

    try{
      final res=await usercase.getInspectionsData();
      emit(InspectionsSuceess(res));
    }catch(e){
      emit(InspectionsFailure(e.toString()));

    }


  }

}