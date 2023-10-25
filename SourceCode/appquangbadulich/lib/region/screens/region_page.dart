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
                  // Hiển thị các thông tin khác về khu vực tại đây
                );
              },
            );
          } else if (state is RegionLoadFailure) {
            return Center(
              child: Text('ádfasdfsdaLỗi: ${state.error}'),
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
