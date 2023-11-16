import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/touristAttraction_bloc.dart';
import '../bloc/touristAttraction_event.dart';
import '../bloc/touristAttraction_state.dart';

class TouristAttractionPage extends StatefulWidget {
  final String idCus;
  const TouristAttractionPage({
    Key? key,
    required this.idCus,
  }) : super(key: key);

  @override
  State<TouristAttractionPage> createState() => TouristAttractionPageState();
}

class TouristAttractionPageState extends State<TouristAttractionPage> {
  late String idCus;

  @override
  void initState() {
    super.initState();
    idCus = widget.idCus;
    context.read<TouristAttractionBloc>().add(FetchTouristAttraction());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: BlocBuilder<TouristAttractionBloc, TouristAttractionState>(
        builder: (context, state) {
          if (state is TouristAttractionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TouristAttractionLoaded) {
            final touristAttractions = state.touristAttraction;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                final touristAttraction = touristAttractions[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        '/detail_touriestAttraction_about',
                        arguments: {
                          'aboutTouristData': touristAttraction,
                          'idCus': idCus,
                        });
                  },
                  child: Container(
                    width: 180,
                    margin: const EdgeInsets.only(right: 10),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: touristAttraction.imgTourist != null
                              ? Image.asset(
                                  'assets/img/${touristAttraction.imgTourist!}',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/img/img_12.png',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Text(
                            touristAttraction.nameTourist,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
