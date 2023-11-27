import 'package:flutter/material.dart';

class UpdateDetailContentPage extends StatefulWidget {
  final TextEditingController touristIntroductionController;
  final Function(String) onUpdate;
  final String touristIntroduction;
  const UpdateDetailContentPage({
    Key? key,
    required this.touristIntroductionController,
    required this.onUpdate,
    required this.touristIntroduction,
  }) : super(key: key);

  @override
  State<UpdateDetailContentPage> createState() =>
      _UpdateDetailContentPageState();
}

class _UpdateDetailContentPageState extends State<UpdateDetailContentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: widget.touristIntroductionController,
        onChanged: (text) {
          widget.onUpdate(text);
        },
        decoration: InputDecoration(
          hintText: widget.touristIntroduction,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        maxLines: null,
      ),
    );
  }
}
