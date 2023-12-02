import 'package:flutter/material.dart';

class DetailContent extends StatefulWidget {
  final String dataIntroTourist;
  const DetailContent({Key? key, required this.dataIntroTourist})
      : super(key: key);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  late String introTourist;
  @override
  void initState() {
    super.initState();
    introTourist = widget.dataIntroTourist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              introTourist,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
