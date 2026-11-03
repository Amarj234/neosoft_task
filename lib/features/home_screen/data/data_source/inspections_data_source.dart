

import 'package:dio/dio.dart';

import '../../../../core/network/api_provider.dart';
import '../model/inspections_model.dart';

abstract class InspectionsDataSource {



    Future<InspectionResponse> getInspectionsData() ;
  }
