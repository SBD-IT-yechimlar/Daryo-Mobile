import 'package:auto_route/auto_route.dart';
import 'package:daryo/domain/models/image/uploadable_file.dart';
import 'package:daryo/presentation/features/common/image_viewer/image_viewer_page.dart';
import 'package:daryo/presentation/features/common/image_viewer/locale_image_viewer_page.dart';
import 'package:daryo/presentation/features/common/language/set_language_page.dart';
import 'package:daryo/presentation/features/home/features/ad_creation_chooser/ad_creation_chooser_page.dart';
import 'package:daryo/presentation/features/home/features/dashboard/dashboard_page.dart';
import 'package:daryo/presentation/features/home/home_page.dart';
import 'package:flutter/material.dart';
import '../../domain/models_daryo/tariff/tariff.dart';
import '../features/auth/forget_password/forget_password_page.dart';
import '../features/auth/forget_password/forget_password_verify_page.dart';
import '../features/auth/registration/registration_image_page.dart';
import '../features/auth/registration/registration_page.dart';
import '../features/auth/reset_password/reset_password_page.dart';
import '../features/auth/splash/splash_page.dart';
import '../features/auth/start/auth_launch_type.dart';
import '../features/auth/start/auth_start_page.dart';
import '../features/common/category_hashtag/category_hashtag_page.dart';
import '../features/common/connections/lost_connection_page.dart';
import '../features/common/onboarding/intro_page.dart';
import '../features/common/onboarding/onboarding_page.dart';
import '../features/common/search/search_page.dart';
import '../features/common/search_hash_tag/search_hashtag_page.dart';
import '../features/common_daryo/chat/features/comment/comment_page.dart';
import '../features/common_daryo/new_history_calendar/features/news_history/news_history_page.dart';
import '../features/common_daryo/new_history_calendar/features/news_history_detail/news_history_detail_page.dart';
import '../features/common_daryo/new_history_calendar/news_history_calendar_page.dart';
import '../features/common_daryo/quiz_history/quiz_history_page.dart';
import '../features/detail/features/content_detail/content_detail_page.dart';
import '../features/home/features/account/account_page.dart';
import '../features/home/features/account/features/about_editorial_team/about_editorial_team_page.dart';
import '../features/home/features/account/features/about_editorial_team/features/team_member_info/team_member_info_page.dart';
import '../features/home/features/account/features/by_articles/by_articles_page.dart';
import '../features/home/features/account/features/cards/cards_page.dart';
import '../features/home/features/account/features/contact_information/contact_information_page.dart';
import '../features/home/features/account/features/edit_profile/edit_profile_page.dart';
import '../features/home/features/account/features/internet_publication/internet_publication_page.dart';
import '../features/home/features/account/features/select_language/select_language_app_page.dart';
import '../features/home/features/account/features/submit_application/submit_application_page.dart';
import '../features/home/features/account/features/subscriptions/subscriptions_page.dart';
import '../features/home/features/daryo_fm/daryo_fm_page.dart';
import '../features/home/features/recommendations/recommendations_page.dart';
import '../features/home/features/security/features/active_sessions/active_session_page.dart';
import '../features/home/features/security/features/security_change_password/security_change_password_page.dart';
import '../features/home/features/security/security_page.dart';
import '../features/home/features/tariffs/features/tariff_payment_option/tariff_payment_option_page.dart';
import '../features/home/features/tariffs/features/tariff_payment_success/tariff_payment_success_page.dart';
import '../features/home/features/tariffs/tariffs_page.dart';
import '../features/home/features/videos/videos_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// Language
        AutoRoute(
          page: SplashRoute.page,
          path: "/splash",
        ),
        AutoRoute(
          page: SetLanguageRoute.page,
          path: "/set_language",
          initial: false,
        ),

        AutoRoute(
          page: IntroRoute.page,
          path: '/onboarding',
        ),

        AutoRoute(
          page: OnboardingRoute.page,
          path: '/onboarding',
        ),

        /// Account
        AutoRoute(
          page: AccountRoute.page,
          path: '/account',
        ),
        AutoRoute(
          page: ContactInformationRoute.page,
          path: '/contact_information',
        ),
        AutoRoute(
          page: InternetPublicationRoute.page,
          path: '/internet_publication',
        ),
        AutoRoute(
          page: AboutEditorialTeamRoute.page,
          path: '/about_editorial_team',
        ),
        AutoRoute(
          page: TeamMemberInfoRoute.page,
          path: '/team_member_info',
        ),
        AutoRoute(
          page: SubmitApplicationRoute.page,
          path: '/submit_application',
        ),
        AutoRoute(
          page: SelectLanguageAppRoute.page,
          path: '/set_language_app',
        ),
        AutoRoute(
          page: ByArticlesRoute.page,
          path: '/by_article',
        ),
        AutoRoute(
          page: SubscriptionsRoute.page,
          path: '/subscriptions',
        ),
        AutoRoute(
          page: CommentRoute.page,
          path: '/comment',
        ),

        /// Auth
        AutoRoute(
          page: AuthStartRoute.page,
          path: "/auth_start",
        ),
        AutoRoute(
          page: ResetPasswordRoute.page,
          path: '/reset_password',
        ),
        AutoRoute(
          page: ForgetPasswordRoute.page,
          path: '/forget_password',
        ),
        AutoRoute(
          page: RegistrationRoute.page,
          path: '/registration',
        ),

        /// home
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
          initial: true,
          children: [
            AutoRoute(
              page: DashboardRoute.page,
              path: 'dashboard',
              maintainState: true,
              keepHistory: true,
            ),
            AutoRoute(
              page: RecommendationsRoute.page,
              path: 'recommendation',
              maintainState: true,
              keepHistory: true,
            ),
            AutoRoute(
              page: AdCreationChooserRoute.page,
              path: 'create_ad_chooser',
              maintainState: true,
              keepHistory: true,
            ),
            AutoRoute(
              page: VideosRoute.page,
              path: 'videos',
              maintainState: true,
              keepHistory: true,
            ),
            AutoRoute(
              page: DaryoFmRoute.page,
              path: 'daryo_fm',
              maintainState: true,
              keepHistory: true,
            )
          ],
        ),

        ///common
        /*  AutoRoute(
          page: SearchRoute.page,
          path: '/search',
        ),*/

        AutoRoute(
          page: SearchHashTagRoute.page,
          path: '/search_hashTag',
        ),
        AutoRoute(
          page: LostConnectionRoute.page,
          path: '/lost_connection',
        ),

        AutoRoute(
          page: SecurityRoute.page,
          path: '/security',
        ),
        AutoRoute(
          page: EditProfileRoute.page,
          path: '/edit_profile',
        ),
        AutoRoute(
          page: SecurityChangePasswordRoute.page,
          path: '/change_password',
        ),
        AutoRoute(
          page: ActiveSessionsRoute.page,
          path: '/active_sessions',
        ),

        AutoRoute(
          page: CardsRoute.page,
          path: '/cards',
        ),
        AutoRoute(
          page: TariffsRoute.page,
          path: '/tariffs',
        ),
        AutoRoute(
          page: TariffPaymentOptionRoute.page,
          path: '/tariffs_payment_option',
        ),
        AutoRoute(
          page: TariffPaymentSuccessRoute.page,
          path: '/tariffs_payment_success',
        ),
        AutoRoute(
          page: ContentDetailRoute.page,
          path: '/content_detail',
        ),
        AutoRoute(
          page: QuizHistoryRoute.page,
          path: '/quiz_history',
        ),
        AutoRoute(
          page: NewsHistoryRoute.page,
          path: '/news_history',
        ),
        AutoRoute(
          page: CategoryHashTagRoute.page,
          path: '/category_hash_tag',
        ),
        AutoRoute(
          page: NewsHistoryCalendarRoute.page,
          path: '/news_history_calendar',
        ),
        AutoRoute(
          page: NewsHistoryDetailRoute.page,
          path: '/news_history_detail',
        ),

        /// image viewer
        AutoRoute(
          page: ImageViewerRoute.page,
          path: '/image_viewer',
        ),

        /// local image viewer
        AutoRoute(
          page: LocaleImageViewerRoute.page,
          path: '/local_image_viewer',
        ),
        AutoRoute(
          page: SearchRoute.page,
          path: '/search',
        ),
      ];
}
