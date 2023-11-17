import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/specialDish/bloc/specialDish_bloc.dart';
import 'package:userappquanbadulich/specialDish/bloc/specialDish_event.dart';

import '../bloc/specialDish_state.dart';

class SpecialDishPage extends StatefulWidget {
  final String idCus;

  const SpecialDishPage({
    Key? key,
    required this.idCus,
  }) : super(key: key);

  @override
  State<SpecialDishPage> createState() => _SpecialDishPageState();
}

class _SpecialDishPageState extends State<SpecialDishPage> {
  late String idCus;

  @override
  void initState() {
    super.initState();
    idCus = widget.idCus;
    context.read<SpecialDishBloc>().add(FetchSpecialDish());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: BlocBuilder<SpecialDishBloc, SpecialDishState>(
        builder: (context, state) {
          if (state is SpecialDishLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SpecialDishLoaded) {
            final specialDishs = state.specialDishs;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: min(3, specialDishs.length),
              itemBuilder: (context, index) {
                final specialDish = specialDishs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        '/detail_touriestAttraction_specialDish',
                        arguments: {
                          'specialDishData': specialDish,
                          'idCus': idCus,
                        });
                  },
                  child: Container(
                    width: 250,
                    margin: const EdgeInsets.only(right: 10),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: specialDish.imgDish != null
                              ? Image.asset(
                                  'assets/img/${specialDish.imgDish!}',
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
                          right: 10,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.transparent,
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              specialDish.nameDish,
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
