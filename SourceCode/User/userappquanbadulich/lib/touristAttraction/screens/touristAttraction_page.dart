import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

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

  Future<bool> doesImageExist(String imagePath) async {
    try {
      await rootBundle.load(imagePath);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<Widget> _buildImage(String? img) async {
    if (img != null && img.isNotEmpty) {
      try {
        List<int> imageBytes = Base64Decoder().convert(img);
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.memory(
            Uint8List.fromList(imageBytes),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      } catch (e) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/img/${img}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      }
    } else {
      return const SizedBox();
    }
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
              itemCount: min(3, touristAttractions.length),
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
                        FutureBuilder<Widget>(
                          future: _buildImage(touristAttraction.imgTourist),
                          builder: (BuildContext context,
                              AsyncSnapshot<Widget> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return snapshot.data ?? Container();
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          right: 10,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.transparent,
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              touristAttraction.nameTourist,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
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
