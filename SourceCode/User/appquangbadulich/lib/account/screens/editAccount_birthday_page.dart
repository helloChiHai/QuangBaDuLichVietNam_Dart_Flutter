import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class EditAccount_Birthday_Page extends StatefulWidget {
  const EditAccount_Birthday_Page({
    Key? key,
  }) : super(key: key);

  @override
  _EditAccount_Birthday_PageState createState() =>
      _EditAccount_Birthday_PageState();
}

class _EditAccount_Birthday_PageState extends State<EditAccount_Birthday_Page> {
  DateTime _selectedDate = DateTime.now();

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Ngày sinh',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 25,
        ),
        child: Column(
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
                    onPressed: () {},
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
        ),
      ),
    );
  }
}
