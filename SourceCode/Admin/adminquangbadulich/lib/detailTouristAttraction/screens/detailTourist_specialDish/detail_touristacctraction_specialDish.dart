import 'package:adminquangbadulich/detailTouristAttraction/bloc/bloc_specialDish/detailTourist_specialDish_bloc.dart';
import 'package:adminquangbadulich/detailTouristAttraction/bloc/bloc_specialDish/detailTourist_specialDish_event.dart';
import 'package:adminquangbadulich/model/specialtyDishModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bloc_specialDish/detailTourist_specialDish_state.dart';
import '../../widgets/detail_touristAttraction_about_widget.dart';

class DetailTouristAttraction_SpecialDish extends StatefulWidget {
  const DetailTouristAttraction_SpecialDish({super.key});

  @override
  State<DetailTouristAttraction_SpecialDish> createState() =>
      _DetailTouristAttraction_SpecialDishState();
}

class _DetailTouristAttraction_SpecialDishState
    extends State<DetailTouristAttraction_SpecialDish> {
  late SpecialtyDishModel specialDish;
  bool isCheckVisibility = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      specialDish = arguments['specialDishData'];
      context
          .read<DetailTourist_SpecialDishBloc>()
          .add(getTouristWithSpecialDish(idDish: specialDish.idDish));
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
      body: BlocBuilder<DetailTourist_SpecialDishBloc,
          DetailTourist_SpecialDishState>(
        builder: (context, state) {
          if (state is DetailTourist_SpecialDishLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailTourist_SpecialDishLoaded) {
            final tourist = state.touristAttraction;
            if (tourist != null) {
              return DetailTouristAttractionWidget(
                tourist: tourist,
                pageViewInit: 3,
              );
            }
          } else if (state is DetailTourist_SpecialDishFailure) {
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
