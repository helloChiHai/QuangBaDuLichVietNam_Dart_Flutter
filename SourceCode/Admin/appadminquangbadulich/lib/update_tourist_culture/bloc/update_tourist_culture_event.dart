import 'package:equatable/equatable.dart';

abstract class UpdateTouristCultureEvent extends Equatable {
  const UpdateTouristCultureEvent();
  @override
  List<Object?> get props => [];
}

class UpdateTouristCultureButtonPressed extends UpdateTouristCultureEvent {
  final String idTourist;
  final String idCulture;
  final String titleCulture;
  final String contentCulture;
  final String? imgCulture;
  UpdateTouristCultureButtonPressed({
    required this.idTourist,
    required this.idCulture,
    required this.titleCulture,
    required this.contentCulture,
    required this.imgCulture,
  });
  @override
  List<Object?> get props => [
        idTourist,
        idCulture,
        titleCulture,
        contentCulture,
        imgCulture,
      ];
}
