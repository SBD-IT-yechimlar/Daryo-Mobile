import 'package:daryo/data/datasource/network/dto/banner/banner_response.dart';
import 'package:daryo/domain/models/banner/banner_image.dart';

extension BannerMapper on BannerResponse {
  BannerImage toBanner() {
    return BannerImage(
        id: id,
        actionType: actionType ?? "",
        actionData: actionData ?? "",
        imageId: image ?? "",
        actionTitle: actionTitle ?? "",
    );
  }
}
