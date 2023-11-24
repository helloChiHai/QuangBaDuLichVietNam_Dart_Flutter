import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../model/specialtyDishModel.dart';

class DetailSpecialtyDish extends StatefulWidget {
  final List<SpecialtyDishModel> dataSpecialtyDish;
  const DetailSpecialtyDish({Key? key, required this.dataSpecialtyDish})
      : super(key: key);

  @override
  State<DetailSpecialtyDish> createState() => _DetailSpecialtyDishState();
}

class _DetailSpecialtyDishState extends State<DetailSpecialtyDish> {
  late List<SpecialtyDishModel> ListSpecialtyDish;

  @override
  void initState() {
    super.initState();
    ListSpecialtyDish = widget.dataSpecialtyDish;
  }

  Future<Widget> _buildImage(String? img) async {
    if (img != null && img.isNotEmpty) {
      try {
        List<int> imageBytes = Base64Decoder().convert(img);
        return SizedBox(
          height: 250,
          child: Image.memory(
            Uint8List.fromList(imageBytes),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      } catch (e) {
        return SizedBox(
          height: 250,
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
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ListSpecialtyDish.length,
        itemBuilder: (context, index) {
          final specialtyDish = ListSpecialtyDish[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              specialtyDish.nameDish.isEmpty
                  ? const SizedBox()
                  : Text(
                      specialtyDish.nameDish,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
              const SizedBox(height: 5),
              specialtyDish.addressDish.isNotEmpty
                  ? Text(
                      'Địa chỉ: ${specialtyDish.addressDish}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  : Container(),
              const SizedBox(height: 10),
              Text(
                specialtyDish.dishIntroduction,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              // specialtyDish.imgDish!.isEmpty
              //     ? const SizedBox()
              //     : SizedBox(
              //         width: double.infinity,
              //         height: 250,
              //         child: Image.asset(
              //           'assets/img/${specialtyDish.imgDish}',
              //           width: double.infinity,
              //           height: double.infinity,
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              FutureBuilder<Widget>(
                future: _buildImage(specialtyDish.imgDish),
                builder:
                    (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data ?? Container();
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}
