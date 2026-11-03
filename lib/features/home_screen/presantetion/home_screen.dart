import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main_injection.dart';
import '../../inspectionDetails/presentation/inspection_details.dart';
import '../data/model/inspections_model.dart';
import 'bloc/inspections_bloc.dart';
import 'bloc/inspections_event.dart';
import 'bloc/inspections_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocProvider(
        create: (context) => sl<InspectionsBloc>()..add(GetInspectionsEvent()),
        child: SafeArea(
          child: BlocBuilder<InspectionsBloc, InspectionsState>(
            builder: (context, state) {
              if (state is InspectionsLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is InspectionsFailure) {
                return Center(child: Text(state.error));
              }
              if (state is InspectionsSuceess) {
                List<InspectionItem> list = state.response.data;

                return Container(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async{
                          print(list[index].id);
                        await  Navigator.push(context, MaterialPageRoute(builder: (context) => InspectionDetails(id: list[index].id.toString(),)));

                          context.read<InspectionsBloc>().add(GetInspectionsEvent());
                        },
                        trailing: TextButton(onPressed: (){}, child: Text(list[index].status)),
                        title: Text(list[index].inspectionTitle),
                        subtitle: Text(list[index].siteName + "\n" + list[index].location),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
