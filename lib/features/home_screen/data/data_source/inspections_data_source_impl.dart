

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:task/core/network/api_provider.dart';
import 'package:get_storage/get_storage.dart';
import '../model/inspections_model.dart';
import 'inspections_data_source.dart';

class InspectionsDataSourceImpl extends InspectionsDataSource{


  final Dio dio=ApiProvider.dio;
  @override
  Future<InspectionResponse> getInspectionsData() async{
    final box = GetStorage();

    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

// Determines whether any active network connection exists.
    if (connectivityResult.hasConnectivity==false) {

      if(box.read("inspections")==null)throw Exception("No Internet Connection");


   final data = box.read("inspections");

   if(data==null)throw Exception("No Internet Connection");

   return InspectionResponse.fromJson(data);

    }

  try{
    final res=await dio.get('/inspections');

    if(res.statusCode==200){

      box.write("inspections", res.data);
      final data=InspectionResponse.fromJson(res.data);


      return data;
    }
    throw Exception("something went wrong");


  }catch(e){
    throw Exception("$e");
  }
  }

  }
