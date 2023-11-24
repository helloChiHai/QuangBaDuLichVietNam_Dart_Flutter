import 'dart:convert';
import 'dart:typed_data';

import 'package:appadminquangbadulich/detailTouristAttraction/widgets/displayVideoWidget.dart';
import 'package:appadminquangbadulich/model/cultureModel.dart';
import 'package:flutter/material.dart';
import '../widgets/playVideo_widget.dart';

class DetailCulture extends StatefulWidget {
  final List<CultureModel> dataCulture;

  const DetailCulture({Key? key, required this.dataCulture}) : super(key: key);

  @override
  State<DetailCulture> createState() => _DetailCultureState();
}

class _DetailCultureState extends State<DetailCulture> {
  late List<CultureModel> cultures;

  @override
  void initState() {
    super.initState();
    cultures = widget.dataCulture;
  }

  bool isAsset(String url) {
    // Kiểm tra xem đường dẫn có bắt đầu bằng "assets/" hay không
    RegExp regExp = RegExp(r'^assets/');
    return regExp.hasMatch(url);
  }

  Future<Widget> _buildImage(String? img) async {
    if (img != null && img.isNotEmpty) {
      try {
        List<int> imageBytes = Base64Decoder().convert(img);
        return SizedBox(
          height: 250,
          child: Image.memory(
            Uint8List.fromList(imageBytes),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      } catch (e) {
        return SizedBox(
          height: 250,
          child: Image.asset(
            'assets/img/${img}',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      }
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cultures.length,
        itemBuilder: (context, index) {
          final culture = cultures[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                culture.titleCulture,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                culture.contentCulture,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              FutureBuilder<Widget>(
                future: _buildImage(culture.imgCulture),
                builder:
                    (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data ?? Container();
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              // culture.imgCulture!.isEmpty
              //     ? const SizedBox()
              //     : Container(
              //         width: double.infinity,
              //         height: 250,
              //         child: Image.asset(
              //           'assets/img/${culture.imgCulture}',
              //           width: double.infinity,
              //           height: double.infinity,
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              if (culture.videoCulture != null &&
                  culture.videoCulture!.isNotEmpty)
                isAsset(culture.videoCulture!)
                    ? PlayVideoWidget(
                        videoPath: 'assets/img/${culture.videoCulture}')
                    : YouTubePlayerWidget(
                        youtubeVideoUrl: culture.videoCulture!,
                      )
              else
                Container(),
            ],
          );
        },
      ),
    );
  }
}
