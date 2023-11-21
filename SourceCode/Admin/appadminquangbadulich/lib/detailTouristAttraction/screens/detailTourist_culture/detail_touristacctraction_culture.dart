import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_culture/detailTourist_culture_bloc.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_culture/detailTourist_culture_event.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_culture/detailTourist_culture_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/cultureModel.dart';
import '../../widgets/detail_touristAttraction_about_widget.dart';

class DetailTouristAttraction_Culture extends StatefulWidget {
  const DetailTouristAttraction_Culture({super.key});

  @override
  State<DetailTouristAttraction_Culture> createState() =>
      _DetailTouristAttraction_CultureState();
}

class _DetailTouristAttraction_CultureState
    extends State<DetailTouristAttraction_Culture> {
  late CultureModel culture;
  bool isCheckVisibility = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      culture = arguments['cultureData'];
      context
          .read<DetailTourist_CultureBloc>()
          .add(getTouristWithCulture(idCulture: culture.idCulture));
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
      body: BlocBuilder<DetailTourist_CultureBloc, DetailTourist_CultureState>(
        builder: (context, state) {
          if (state is DetailTourist_CultureLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailTourist_CultureLoaded) {
            final tourist = state.touristAttraction;
            if (tourist != null) {
              return DetailTouristAttractionWidget(
                      tourist: tourist,
                      pageViewInit: 1,
                    );
            }
          } else if (state is DetailTourist_CultureFailure) {
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
