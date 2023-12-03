import 'package:appadminquangbadulich/addTouristAttraction/bloc/addTouristAttraction_bloc.dart';
import 'package:appadminquangbadulich/addTouristAttraction/bloc/addTouristAttraction_state.dart';
import 'package:appadminquangbadulich/addTouristAttraction/screens/addTouristAttraction_form.dart';
import 'package:appadminquangbadulich/homeAdmin/screens/homeAdmin_page.dart';
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
            Future.delayed(const Duration(seconds: 1), () {
              // Navigator.of(context).pushNamed('/homeAdmin');
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeAdminPage(),));
            });
          }
          if (state is AddTouristAttractionFailure) {
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
        child: SingleChildScrollView(child: AddTouristAttractionForm()),
      ),
    );
  }
}
