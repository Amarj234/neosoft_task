import 'package:get_it/get_it.dart';

import 'features/home_screen/data/data_source/inspections_data_source.dart';
import 'features/home_screen/data/data_source/inspections_data_source_impl.dart';
import 'features/home_screen/data/reposetory/inspections_reposetory_impl.dart';
import 'features/home_screen/domain/reposetory/inspections_reposetory.dart';
import 'features/home_screen/domain/usecase/inspections_usercase.dart';
import 'features/home_screen/presantetion/bloc/inspections_bloc.dart';
import 'features/inspectionDetails/data/data_source/inspections_details_data_source.dart';
import 'features/inspectionDetails/data/data_source/inspections_details_data_source_impl.dart';
import 'features/inspectionDetails/data/reposetory/inspections_details_reposetory_impl.dart';
import 'features/inspectionDetails/domain/reposetory/inspections_details_reposetory.dart';
import 'features/inspectionDetails/domain/usecase/inspections_details_usecase.dart';
import 'features/inspectionDetails/presentation/bloc/inspections_details_bloc.dart';

final GetIt sl=GetIt.instance;

init(){

  sl.registerFactory(() => InspectionsBloc(sl()));

  sl.registerLazySingleton(()=>InspectionsUsercase(sl()));

  sl.registerLazySingleton<InspectionsReposetory>(()=>InspectionsReposetoryImpl(sl()));

  sl.registerLazySingleton<InspectionsDataSource>(()=>InspectionsDataSourceImpl());
  detaildInjection();
}




detaildInjection(){

  sl.registerFactory(() => InspectionsDetailsBloc(sl()));

  sl.registerFactory(()=>InspectionsDetailsUsecase(reposetory: sl()));
  sl.registerLazySingleton<InspectionsDetailsReposetory>(()=>InspectionsDetailsReposetoryImpl(dataSource: sl()));

  sl.registerLazySingleton<InspectionsDetailsDataSource>(()=>InspectionsDetailsDataSourceImpl());
}