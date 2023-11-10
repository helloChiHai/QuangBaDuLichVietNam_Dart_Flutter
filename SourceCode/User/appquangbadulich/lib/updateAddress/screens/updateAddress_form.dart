import 'package:appquangbadulich/updateAddress/bloc/updateAddress_bloc.dart';
import 'package:appquangbadulich/updateAddress/bloc/updateAddress_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateAddressForm extends StatefulWidget {
  final String customerId;

  const UpdateAddressForm({Key? key, required this.customerId})
      : super(key: key);

  @override
  State<UpdateAddressForm> createState() => _UpdateAddressFormState();
}

class _UpdateAddressFormState extends State<UpdateAddressForm> {
  String diaChi = '';
  late String idCus;
  @override
  void initState() {
    super.initState();
    idCus = widget.customerId;
  }

  @override
  Widget build(BuildContext context) {
    final updateAddressBloc = BlocProvider.of<UpdateAddressBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Địa chỉ',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: diaChi,
            hintStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          onChanged: (value) {
            setState(
              () {
                diaChi = value;
              },
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        diaChi.isEmpty
            ? const Text(
                'Địa chỉ không hợp lệ, vui lòng kiểm tra lại',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              )
            : const SizedBox(),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: diaChi.isEmpty
                    ? null
                    : () {
                        print(diaChi);
                        updateAddressBloc.add(
                          UpdateAddressButtonPressed(
                            idCus: idCus,
                            newAddress: diaChi,
                          ),
                        );
                      },
                child: const Text(
                  'Lưu',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
