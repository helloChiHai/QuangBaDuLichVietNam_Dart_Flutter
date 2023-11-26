import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/filterTypeTourist/bloc/filterTypeTourist_bloc.dart';
import 'package:userappquanbadulich/filterTypeTourist/bloc/filterTypeTourist_event.dart';
import 'package:userappquanbadulich/filterTypeTourist/bloc/filterTypeTourist_state.dart';

class DetailFilterTypeTourist extends StatefulWidget {
  const DetailFilterTypeTourist({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailFilterTypeTourist> createState() =>
      _DetailFilterTypeTouristState();
}

class _DetailFilterTypeTouristState extends State<DetailFilterTypeTourist> {
  String? idTypeTourist;
  String? idCus;
  late String titleTypeTourist;
  late String imgTypeTourist;
  late String introTypeTourist;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    idTypeTourist = args['idTypeTourist']!;
    titleTypeTourist = args['titleTypeTourist']!;
    imgTypeTourist = args['imgTypeTourist']!;
    introTypeTourist = args['introTypeTourist']!;
    idCus = args['idCus']!;

    context
        .read<FilterTypeTouristBloc>()
        .add(FilterTypeTouristAttraction(typeTourist: idTypeTourist!));
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          titleTypeTourist,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/searchTouristAttraction');
            },
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/img/$imgTypeTourist'),
              width: double.infinity,
              height: 190,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 15),
            Center(
              child: Container(
                width: 30,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 2.0, // Độ dài của đường gạch ngang
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                introTypeTourist,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 15),
            Container(
              constraints: const BoxConstraints(
                minHeight: 500.0,
              ),
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<FilterTypeTouristBloc, FilterTypeTouristState>(
                builder: (context, state) {
                  if (state is FilterTypeTouristLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FilterTypeTouristLoaded) {
                    final touristAttractions = state.tourist;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: touristAttractions.length,
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                FutureBuilder<Widget>(
                                  future:
                                      _buildImage(touristAttraction.imgTourist),
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
                                    child:
                                        touristAttraction.nameTourist.isNotEmpty
                                            ? Text(
                                                touristAttraction.nameTourist,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                              )
                                            : Container(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is FilterTypeTouristFailure) {
                    Container(
                      child: const Text('Khong co gi het'),
                    );
                  }
                  return Container(
                    child: const Text('Khong co gi het'),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
