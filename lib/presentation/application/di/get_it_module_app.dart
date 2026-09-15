import 'package:daryo/presentation/features/common/connections/lost_connection_cubit.dart';
import 'package:daryo/presentation/features/common/onboarding/intro_cubit.dart';
import 'package:daryo/presentation/features/common/search_hash_tag/search_hashtag_cubit.dart';
import 'package:daryo/presentation/features/common_daryo/chat/features/comment/comment_cubit.dart';
import 'package:daryo/presentation/features/common_daryo/quiz_history/quiz_history_cubit.dart';
import 'package:daryo/presentation/features/home/features/account/account_cubit.dart';
import 'package:daryo/presentation/features/home/features/daryo_fm/daryo_fm_cubit.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:daryo/presentation/features/auth/registration/registration_cubit.dart';
import 'package:daryo/presentation/features/auth/reset_password/reset_password_cubit.dart';
import 'package:daryo/presentation/features/auth/start/auth_start_cubit.dart';
import 'package:daryo/presentation/features/common/language/set_language_cubit.dart';
import 'package:daryo/presentation/features/home/features/account/features/by_articles/by_articles_cubit.dart';
import 'package:daryo/presentation/features/home/features/account/features/contact_information/contact_information_cubit.dart';
import 'package:daryo/presentation/features/home/features/account/features/internet_publication/internet_publication_cubit.dart';
import 'package:daryo/presentation/features/home/features/ad_creation_chooser/ad_creation_chooser_cubit.dart';
import 'package:daryo/presentation/features/home/features/dashboard/dashboard_cubit.dart';
import 'package:daryo/presentation/features/home/home_cubit.dart';
import 'package:daryo/presentation/support/state_message/state_message_manager.dart';
import 'package:daryo/presentation/support/state_message/state_message_manager_impl.dart';

import '../../features/auth/splash/splash_cubit.dart';
import '../../features/common/category_hashtag/category_hashtag_cubit.dart';
import '../../features/common/search/search_cubit.dart';
import '../../features/common_daryo/new_history_calendar/features/news_history/news_history_cubit.dart';
import '../../features/common_daryo/new_history_calendar/news_history_calendar_cubit.dart';
import '../../features/detail/features/content_detail/content_detail_cubit.dart';
import '../../features/home/features/account/features/about_editorial_team/about_editorial_team_cubit.dart';
import '../../features/home/features/account/features/about_editorial_team/features/team_member_info/team_member_info_cubit.dart';
import '../../features/home/features/account/features/edit_profile/edit_profile_cubit.dart';
import '../../features/home/features/account/features/select_language/select_language_app_cubit.dart';
import '../../features/home/features/account/features/submit_application/submit_application_cubit.dart';
import '../../features/home/features/account/features/subscriptions/subscriptions_cubit.dart';
import '../../features/home/features/recommendations/recommendations_cubit.dart';
import '../../features/home/features/tariffs/tariffs_cubit.dart';
import '../../features/home/features/videos/videos_cubit.dart';

extension GetItModuleApp on GetIt {
  Future<void> appModule() async {
    registerLazySingleton(() => Logger());

    registerSingleton<StateMessageManager>(StateMessageManagerImpl());


    // auth
    registerFactory(() => SplashCubit(get()));
    registerFactory(() => ResetPasswordCubit(get()));
    registerFactory(() => AuthStartCubit(get(),get()));
    registerFactory(() => RegistrationCubit(get()));
    registerFactory(() => IntroCubit(get()));

    // common

    registerFactory(() => SetLanguageCubit(get()));
    registerFactory(() => SelectLanguageAppCubit(get()));
    registerFactory(() => LostConnectionCubit(get()));
    registerFactory(() => QuizHistoryCubit(get()));
    registerFactory(() => TariffsCubit(get()));
    registerFactory(() => SearchHashTagCubit(get(),get()));
    registerFactory(() => CategoryHashTagCubit(get(),get()));

    // home
    registerFactory(() => HomeCubit());
    registerFactory(() => RecommendationsCubit(get(), get(),get()));
    registerFactory(() => VideosCubit(get(),get(),get()));
    registerFactory(() => AdCreationChooserCubit(get(), get(),get(),get()));
    registerFactory(() => DashboardCubit(get(),get(),get(),get()));
    registerFactory(() => ContentDetailCubit(get(),get(),get()));


    ///
    registerFactory(() => AccountCubit(get(), get(),get(),get(),get(),get()));
    registerFactory(() => DaryoFmCubit(get(), get(),get()));
    registerFactory(() => EditProfileCubit(get(),get(),get()));
    registerFactory(() => ContactInformationCubit(get()));
    registerFactory(() => InternetPublicationCubit(get()));
    registerFactory(() => AboutEditorialTeamCubit(get(), get()));
    registerFactory(() => TeamMemberInfoCubit(get()));
    registerFactory(() => SubmitApplicationCubit(get()));
    registerFactory(() => ByArticlesCubit(get()));
    registerFactory(() => SubscriptionsCubit(get()));
    registerFactory(() => CommentCubit(get()));
    registerFactory(() => SearchCubit(get()));
    registerFactory(() => NewsHistoryCubit(get()));
    registerFactory(() => NewsHistoryCalendarCubit(get()));


    await allReady();
  }
}
