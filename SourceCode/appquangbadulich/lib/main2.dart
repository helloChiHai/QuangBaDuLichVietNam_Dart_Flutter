import 'package:appquangbadulich/hotel/bloc/hotel_bloc.dart';
import 'package:appquangbadulich/hotel/bloc/hotel_event.dart';
import 'package:appquangbadulich/hotel/bloc/hotel_state.dart';
import 'package:appquangbadulich/hotel/model/hotelModel.dart';
import 'package:appquangbadulich/repositories/HotelRepositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => HotelRepository(),
        child: const Home(),
      ),
      // home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotelBloc(
        RepositoryProvider.of<HotelRepository>(context),
      )..add(LoadHotelEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ĐÂY LÀ DS HOTEL'),
        ),
        body: BlocBuilder<HotelBloc, HotelState>(
          builder: (context, state) {
            if (state is HotelLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HotelLoadedState) {
              List<HotelModel> hotelList = state.hotels;
              return ListView.builder(
                itemCount: hotelList.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      print('hotelList');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        hotelList[index].nameHotel,
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (state is HotelErrorState) {
              return const Center(
                child: Text('Error'),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
