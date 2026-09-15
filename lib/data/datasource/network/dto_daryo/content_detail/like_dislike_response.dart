import 'package:freezed_annotation/freezed_annotation.dart';

part 'like_dislike_response.freezed.dart';
part 'like_dislike_response.g.dart';

@freezed
abstract class LikeDislikeResponse with _$LikeDislikeResponse {
  const factory LikeDislikeResponse({
    int? dislikes,
    int? likes,
    int? post_id,
    bool? success,
    String? error,
  }) = _LikeDislikeResponse;

  factory LikeDislikeResponse.fromJson(Map<String, Object?> json) => _$LikeDislikeResponseFromJson(json);
}



