import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appquangbadulich/culture/bloc/culture_bloc.dart';
import 'package:appquangbadulich/culture/bloc/culture_event.dart';
import 'package:appquangbadulich/culture/bloc/culture_state.dart';

class CulturePage extends StatefulWidget {
  const CulturePage({super.key});

  @override
  State<CulturePage> createState() => _CulturePageState();
}

class _CulturePageState extends State<CulturePage> {
  @override
  void initState() {
    super.initState();
    context.read<CultureBloc>().add(FetchCultures());
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
              itemCount: cultures.length,
              itemBuilder: (context, index) {
                final culture = cultures[index];
                return GestureDetector(
                  onTap: () {
                    print(culture.idCulture);
                  },
                  child: Container(
                    width: 180,
                    margin: const EdgeInsets.only(right: 10),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: culture.imgCulture != null
                              ? Image.asset(
                                  'assets/img/${culture.imgCulture!}',
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
                            culture.titleCulture,
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
