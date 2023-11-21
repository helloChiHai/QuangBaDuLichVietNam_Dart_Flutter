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
              culture.imgCulture!.isEmpty
                  ? const SizedBox()
                  : Container(
                      width: double.infinity,
                      height: 250,
                      child: Image.asset(
                        'assets/img/${culture.imgCulture}',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
              if (culture.videoCulture != null &&
                  culture.videoCulture!.isNotEmpty)
                PlayVideoWidget(videoPath: 'assets/img/${culture.videoCulture}')
              else
                Container(),
            ],
          );
        },
      ),
    );
  }
}