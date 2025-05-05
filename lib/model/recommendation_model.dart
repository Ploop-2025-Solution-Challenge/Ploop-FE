import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ploop_fe/model/latlng_converter.dart';

part 'recommendation_model.freezed.dart';
part 'recommendation_model.g.dart';

@freezed
abstract class Recommendation with _$Recommendation {
  const factory Recommendation({
    @LatLngConverter() required List<LatLng> recommendationRoute,
    required String motivation,
  }) = _Recommendation;

  factory Recommendation.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFromJson(json);
}
