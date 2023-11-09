import 'package:appquangbadulich/updateBirthday/bloc/updateBirthday_bloc.dart';
import 'package:appquangbadulich/updateBirthday/bloc/updateBirthday_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class UpdateBirthdayForm extends StatefulWidget {
  final String customerId;

  const UpdateBirthdayForm({Key? key, required this.customerId})
      : super(key: key);

  @override
  State<UpdateBirthdayForm> createState() => _UpdateBirthdayFormState();
}

class _UpdateBirthdayFormState extends State<UpdateBirthdayForm> {
  late String idCus;
  DateTime _selectedDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    idCus = widget.customerId;
  }

  @override
  Widget build(BuildContext context) {
    final updateBirthdayBloc = BlocProvider.of<UpdateBirthdayBloc>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Để VietWander nhớ ngày sinh nhật bạn nè',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          width: double.infinity,
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
          ),
          child: Text(
            _dateFormat.format(_selectedDate),
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
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
                onPressed: () {
                  print(
                    _dateFormat.format(_selectedDate),
                  );
                  updateBirthdayBloc.add(
                    UpdateBirthdayButtonPressed(
                      idCus: idCus,
                      newBirthday: _dateFormat.format(_selectedDate),
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
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 48),
          child: TextButton(
            onPressed: () {
              setState(() {
                _selectedDate = DateTime.now();
              });
            },
            child: const Text(
              "Hôm nay",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          height: 250,
          child: ScrollDatePicker(
            selectedDate: _selectedDate,
            locale: Locale('vi'),
            scrollViewOptions: const DatePickerScrollViewOptions(
              year: ScrollViewDetailOptions(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
                selectedTextStyle: TextStyle(
                  fontSize: 20,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
              ),
              month: ScrollViewDetailOptions(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
                selectedTextStyle: TextStyle(
                  fontSize: 20,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
              ),
              day: ScrollViewDetailOptions(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
                selectedTextStyle: TextStyle(
                  fontSize: 20,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
              ),
            ),
            onDateTimeChanged: (DateTime value) {
              setState(
                () {
                  _selectedDate = value;
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
