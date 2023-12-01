import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_bloc.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_event.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/detail_touristAttraction_about_widget.dart';

class DetailTouristAttraction_AboutPage extends StatefulWidget {
  final String idTourist;
  const DetailTouristAttraction_AboutPage({
    Key? key,
    required this.idTourist,
  }) : super(key: key);

  @override
  State<DetailTouristAttraction_AboutPage> createState() =>
      _DetailTouristAttraction_AboutPageState();
}

class _DetailTouristAttraction_AboutPageState
    extends State<DetailTouristAttraction_AboutPage> {
  bool isCheckVisibility = false;

  @override
  void initState() {
    context
        .read<DetailTourist_AboutBloc>()
        .add(getTouristWithIdTourist(idTourist: widget.idTourist));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTourist_AboutBloc, DetailTourist_AboutState>(
        builder: (context, state) {
          if (state is DetailTourist_AboutLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailTourist_AboutLoaded) {
            final tourist = state.touristAttraction;
            if (tourist != null) {
              return DetailTouristAttractionWidget(
                tourist: tourist,
                pageViewInit: 0,
              );
            }
          } else if (state is DetailTourist_AboutFailure) {
            return Center(
              child: Text('Đã xảy ra lỗi: ${state.error}'),
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
