import 'package:appquangbadulich/region/model/specialtyDishModel.dart';
import 'package:flutter/material.dart';

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
              Text(
                specialtyDish.dishIntroduction,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              specialtyDish.imgDish!.isEmpty
                  ? const SizedBox()
                  : Container(
                      width: double.infinity,
                      height: 250,
                      child: Image.asset(
                        'assets/img/${specialtyDish.imgDish}',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
              const SizedBox(height: 15),
            ],
          );
        },
      ),
    );
  }
}
