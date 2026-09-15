import 'package:daryo/data/datasource/network/dto/profile/user_full/user_full_info_response.dart';
import 'package:daryo/data/datasource/network/dto/social_account/social_account_info_response.dart';
import 'package:daryo/domain/models/social_account/social_account_info.dart';

extension SocialAccountInfoResponseExtension on SocialAccountInfoResponse {
  SocialAccountInfo toMap() {
    return SocialAccountInfo(
      id: id ?? 0,
      type: type ?? "",
      link: link ?? "https://www",
      status: status ?? "",
      isLink: is_link ?? link?.isNotEmpty == true,
      tin: tin ?? 0,
      viewNote: view_note,
    );
  }
}

extension SocialResponseExtension on Socials {
  SocialAccountInfo toMap() {
    return SocialAccountInfo(
      id: id ?? 0,
      type: type ?? "",
      link: link ?? "",
      status: status ?? "",
      isLink: link?.isNotEmpty == true,
      tin: tin ?? 0,
      viewNote: viewNote,
    );
  }
}
