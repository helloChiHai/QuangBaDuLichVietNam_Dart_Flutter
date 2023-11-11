import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/region_bloc.dart';
import '../bloc/region_event.dart';
import '../bloc/region_state.dart';

class RegionPage extends StatelessWidget {
  const RegionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách khu vực'),
      ),
      body: BlocBuilder<RegionBloc, RegionState>(
        builder: (context, state) {
          if (state is RegionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RegionLoaded) {
            final regions = state.regions;
            return ListView.builder(
              itemCount: regions.length,
              itemBuilder: (context, index) {
                final region = regions[index];
                return ListTile(
                  title: Text(region.nameRegion),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: region.provinces.map((province) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(province.nameProvines),
                          ...province.touristAttraction!.map((touristAttraction) {
                            return ExpansionTile(
                              title: Text(touristAttraction.nameTourist),
                              children: [
                                // Text("History: ${touristAttraction.history.historyStory}"),
                                Text("Right Time: ${touristAttraction.rightTime.join(', ')}"),
                                ExpansionTile(
                                  title: Text("Culture"),
                                  children: touristAttraction.culture.map((culture) {
                                    return Text("Culture Name: ${culture.titleCulture}");
                                  }).toList(),
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
            );
          } else if (state is RegionLoadFailure) {
            return Center(
              child: Text('Lỗi: ${state.error}'),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<RegionBloc>().add(FetchRegions());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
