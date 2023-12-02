import 'package:flutter/material.dart';

class CommentTourist extends StatefulWidget {
  const CommentTourist({super.key});

  @override
  State<CommentTourist> createState() => _CommentTouristState();
}

class _CommentTouristState extends State<CommentTourist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: AssetImage('assets/img/img_12.png'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.black, // Màu viền
                        width: 2.0, // Độ rộng của viền
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Bạn đang nghĩ gì?',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send_rounded,
                      size: 35,
                    ),
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.amber,
              width: double.infinity,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text('adsfsdfffffffffffffffffffffffffffffffffff')
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
