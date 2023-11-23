import 'package:adminquangbadulich/addTouristAttraction/bloc/addTouristAttraction_bloc.dart';
import 'package:adminquangbadulich/addTouristAttraction/bloc/addTouristAttraction_state.dart';
import 'package:adminquangbadulich/addTouristAttraction/screens/addTouristAttraction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTouristAttractionPage extends StatelessWidget {
  const AddTouristAttractionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Thêm địa điểm mới',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      body: BlocListener<AddTouristAttractionBloc, AddTouristAttractionState>(
        listener: (context, state) {
          if (state is AddTouristAttractionSuccess) {
            print('Thêm địa điểm mới thành công');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Thêm địa điểm mới thành công',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pushNamed('/AddTouristAttractionSuccesful');
          }
          if (state is AddTouristAttractionFailure) {
            print(state.error);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        // child: SingleChildScrollView(child: AddTouristAttractionForm()),
      ),
    );
  }
}
