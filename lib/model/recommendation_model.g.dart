// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Recommendation _$RecommendationFromJson(Map<String, dynamic> json) =>
    _Recommendation(
      recommendationRoute: (json['recommendationRoute'] as List<dynamic>)
          .map((e) => const LatLngConverter().fromJson(e as List))
          .toList(),
      motivation: json['motivation'] as String,
    );

Map<String, dynamic> _$RecommendationToJson(_Recommendation instance) =>
    <String, dynamic>{
      'recommendationRoute': instance.recommendationRoute
          .map(const LatLngConverter().toJson)
          .toList(),
      'motivation': instance.motivation,
    };
