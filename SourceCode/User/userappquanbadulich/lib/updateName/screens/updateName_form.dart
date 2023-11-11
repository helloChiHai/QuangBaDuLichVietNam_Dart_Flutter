import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/updateName_bloc.dart';
import '../bloc/updateName_event.dart';

class UpdateNameForm extends StatefulWidget {
  final String customerId;

  const UpdateNameForm({Key? key, required this.customerId}) : super(key: key);

  @override
  State<UpdateNameForm> createState() => _UpdateNameFormState();
}

class _UpdateNameFormState extends State<UpdateNameForm> {
  String ten = '';
  late String idCus;

  @override
  void initState() {
    super.initState();
    idCus = widget.customerId;
  }

  @override
  Widget build(BuildContext context) {
    final updateEmailBloc = BlocProvider.of<UpdateNameBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tên',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: ten,
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
                ten = value;
              },
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        ten.isEmpty
            ? const Text(
                'Tên không hợp lệ, vui lòng kiểm tra lại',
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
                onPressed: ten.isEmpty
                    ? null
                    : () {
                        print(ten);
                        updateEmailBloc.add(
                          UpdateNameButtonPressed(
                            idCus: idCus,
                            newName: ten,
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
