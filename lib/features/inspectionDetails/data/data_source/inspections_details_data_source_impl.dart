

import 'package:dio/dio.dart';

import '../../../../core/network/api_provider.dart';
import '../model/inspections_details_model.dart';
import 'inspections_details_data_source.dart';

class InspectionsDetailsDataSourceImpl extends InspectionsDetailsDataSource{



    final Dio dio=ApiProvider.dio;
    @override
    Future<InspectionDetailsResponse> getInspectionsDetailsData(String id) async{

      try{
        final res=await dio.get('/inspections/$id');

        if(res.statusCode==200){

          final data=InspectionDetailsResponse.fromJson(res.data);

          return data;
        }
        throw Exception("something went wrong");


      }catch(e){
        throw Exception("$e");
      }
    }


    @override
    Future<InspectionDetailsResponse> updateInspectionsDetailsData(Map<String, dynamic> data) async{

      try{

        final res=await dio.put('/inspections/${data['id']}',data: data);
        if(res.statusCode==200){
          final data=InspectionDetailsResponse.fromJson(res.data);
          return data;
        }

        throw Exception("something went wrong");


        }catch(e){
          throw Exception("$e");

      }
      }

    }



