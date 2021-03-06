// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVariable _$ProductVariableFromJson(Map<String, dynamic> json) {
  return ProductVariable(
    ids: (json['attribute_ids'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
    labels: (json['attribute_labels'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    terms: (json['attribute_terms'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
    ),
    variations: (json['variations'] as List<dynamic>?)?.map((e) => e as Map<String, dynamic>).toList(),
  )
    ..termsLabels = (json['attribute_terms_labels'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    )
    ..values = (json['attribute_terms_values'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
    );
}

Map<String, dynamic> _$ProductVariableToJson(ProductVariable instance) => <String, dynamic>{
      'attribute_ids': instance.ids,
      'attribute_labels': instance.labels,
      'attribute_terms': instance.terms,
      'attribute_terms_labels': instance.termsLabels,
      'attribute_terms_values': instance.values,
      'variations': instance.variations,
    };
