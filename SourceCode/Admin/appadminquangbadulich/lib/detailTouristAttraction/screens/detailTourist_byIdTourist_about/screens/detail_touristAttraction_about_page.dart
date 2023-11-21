import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_bloc.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_event.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_state.dart';
import 'package:appadminquangbadulich/model/touristAttractionModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/detail_touristAttraction_about_widget.dart';

class DetailTouristAttraction_AboutPage extends StatefulWidget {
  const DetailTouristAttraction_AboutPage({Key? key}) : super(key: key);

  @override
  State<DetailTouristAttraction_AboutPage> createState() =>
      _DetailTouristAttraction_AboutPageState();
}

class _DetailTouristAttraction_AboutPageState
    extends State<DetailTouristAttraction_AboutPage> {
  late TouristAttractionModel touristAttraction;
  bool isCheckVisibility = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      touristAttraction = arguments['aboutTouristData'];
      context
          .read<DetailTourist_AboutBloc>()
          .add(getTouristWithIdTourist(idTourist: touristAttraction.idTourist));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
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
}
