import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/culture/bloc/culture_bloc.dart';
import 'package:userappquanbadulich/culture/bloc/culture_event.dart';
import 'package:userappquanbadulich/culture/bloc/culture_state.dart';
import 'package:userappquanbadulich/detailTouristAttraction/screens/detailTourist_culture/detail_touristacctraction_culture.dart';

class CulturePage extends StatefulWidget {
  final String idCus;

  const CulturePage({
    Key? key,
    required this.idCus,
  }) : super(key: key);

  @override
  State<CulturePage> createState() => _CulturePageState();
}

class _CulturePageState extends State<CulturePage> {
  late String idCus;

  @override
  void initState() {
    super.initState();
    idCus = widget.idCus;
    context.read<CultureBloc>().add(FetchCultures());
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
      child: BlocBuilder<CultureBloc, CultureState>(
        builder: (context, state) {
          if (state is CultureLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CultureLoaded) {
            final cultures = state.cultures;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: min(3, cultures.length),
              itemBuilder: (context, index) {
                final culture = cultures[index];
                return GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pushNamed(
                    //     '/detail_touriestAttraction_culture',
                    //     arguments: {
                    //       'cultureData': culture,
                    //       'idCus': idCus,
                    //     });

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailTouristAttraction_Culture(
                        culture: culture,
                        idCus: idCus,
                      ),
                    ));
                  },
                  child: Container(
                    width: 180,
                    margin: const EdgeInsets.only(right: 10),
                    child: Stack(
                      children: [
                        FutureBuilder<Widget>(
                          future: _buildImage(culture.imgCulture),
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
                              culture.titleCulture,
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
