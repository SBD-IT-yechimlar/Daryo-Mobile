import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/gen/localization/strings.dart';
import '../../../../../domain/models_daryo/tags/tag.dart';
import '../../../../router/app_router.dart';
import '../../../../widgets/appbar/image_app_bar.dart';
import '../../../../widgets/dashboard/tags/tags_list.dart';
import '../../../../widgets/dashboard/tags/tags_shimmer_list.dart';
import '../../../../widgets/loading/loader_state_widget.dart';
import '../../../../widgets/menu/menu_shimmer.dart';
import '../../../../widgets/ticket/ticket_widget.dart';
import '../../../../widgets_daryo/category/category_list.dart';
import 'ad_creation_chooser_cubit.dart';

@RoutePage()
class AdCreationChooserPage extends BasePage<AdCreationChooserCubit, AdCreationChooserState, AdCreationChooserEvent> {
  AdCreationChooserPage({super.key});

  final List<Map<String, dynamic>> socialMedia = [
    {
      'icon': Assets.imagesDaryo.icTelegram.svg(),
      'url': 'https://t.me/Daryo',
    },
    {
      'icon': Assets.imagesDaryo.icYoutube.svg(),
      'url': 'https://www.youtube.com/@Daryo_yangiliklari',
    },
    {
      'icon': Assets.imagesDaryo.icFacebook.svg(),
      'url': 'https://www.facebook.com/daryouz.rasmiy',
    },
    {
      'icon': Assets.imagesDaryo.icInstagramm.svg(),
      'url': 'https://www.instagram.com/daryo.rasmiy',
    },
    {
      'icon': Assets.imagesDaryo.icXTwitter.svg(),
      'url': 'https://x.com/daryo_uz',
    },
  ];

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void onEventEmitted(BuildContext context, AdCreationChooserEvent event) async {
    switch (event.type) {
      case AdCreationChooserEventType.lostConnection:
        final result = await context.router.push(LostConnectionRoute());
        if (result == true) {
          cubit(context).getInitialData();
        }
    }
  }

  @override
  void onWidgetCreated(BuildContext context) {}

  @override
  Widget onWidgetBuild(BuildContext context, AdCreationChooserState state) {
    return Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: ImageAppBar(
          context: context,
          titleText: "",
          titleTextColor: Colors.black,
          backgroundColor: context.backgroundColor,
          actions: [
            IconButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                },
                icon: Container(
                    height: 35.h,
                    width: 35.h,
                    decoration: BoxDecoration(color: context.containerBackground, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Assets.imagesv2.icSearch.svg(colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
                    ))),
            IconButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  context.router.push(AccountRoute());
                },
                icon: Container(
                    height: 35.h,
                    width: 35.h,
                    decoration: BoxDecoration(color: context.containerBackground, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Assets.imagesv2.icProfile.svg(colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
                    ))),
          ],
          onBackPressed: () => context.router.pop(),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 32,
                              width: 2,
                              color: context.primary,
                            ),
                            SizedBox(width: 6),
                            Strings.menu.s(16).w(500).c(context.textPrimary),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Strings.goodNews.s(14).w(400).c(context.textPrimary),
                        Transform.scale(
                          alignment: Alignment.center,
                          scale: 0.7,
                          child: CupertinoSwitch(
                            value: state.goodNew,
                            onChanged: (value) {
                              cubit(context).setGoodNews();
                            },
                            activeColor: const Color(0xFF0089DA),
                            trackColor: const Color(0xFFD9DDDF),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                _buildCategories(context, state),
                _buildTags(context, state),
                SizedBox(height: 16.h),
                SubscriptionCard(
                  icon: Assets.imagesDaryo.icTicketFavouriteChart.svg(),
                  title: Strings.growWithUs,
                  subtitle: Strings.advertiseOnDaryo,
                  buttonText: Strings.advertise,
                  buttonColor: context.greenColor,
                  borderColor: context.inputStrokeInactiveColor,
                  onItemClicked: () async{
                    final Uri url = Uri.parse('https://daryo.uz/reklama/');
                    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                ),
                SizedBox(height: 16.h),
                if(state.isAuthorized)
                _buildSubscription(context),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel(context,label: Strings.socialMedia),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: socialMedia.map((item) {
                        return GestureDetector(
                          onTap: () => _launchURL(item['url']),
                          child: item['icon'],
                        );
                      }).toList(),
                    )
                  ],
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ));
  }

  Widget _buildTags(BuildContext context, AdCreationChooserState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildLabel(context, label: Strings.tags, textColor: context.textPrimary),
        LoaderStateWidget(
            onRetryClicked: () {
              cubit(context).getTags();
            },
            emptyBody: SizedBox(),
            loadingState: state.tagsState,
            loadingBody: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TagsShimmer(),
            ),
            successBody: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: TagsList(
                tags: state.tags,
                onItemClicked: (Tag item) {
                  context.router.push(SearchHashTagRoute(hashTag: item.title));
                },
              ),
            )),
      ],
    );
  }

  Widget _buildCategories(BuildContext context, AdCreationChooserState state) {
    return LoaderStateWidget(
      loadingState: state.categoriesState,
      loadingBody: MenuShimmer(),
      successBody: CategoryList(
        categories: state.categories,
        onCategoryTap: (category) {
          Logger().w("slug ${category.slug}");
          context..router.push(CategoryHashTagRoute(hashTag: category.slug, title:category.slug,));
          print(category.toMap());
        },
      ),
    );
  }

  Widget _buildLabel(BuildContext context, {required String label, Widget? rightIcon, Color? textColor}) {
    return Row(
      children: [
        SizedBox(
          width: 2,
          height: 26,
          child: ColoredBox(color: context.colors.primary),
        ),
        SizedBox(width: 4),
        Expanded(child: Text(label).s(16).w(600).c(textColor ?? context.textPrimary)),
        if (rightIcon != null) rightIcon,
      ],
    );
  }

  Widget _buildSubscription(BuildContext context){
    return Column(
      children: [
        SubscriptionCard(
          icon: Assets.imagesDaryo.icTicketCrown.svg(),
          title: Strings.individualApproach,
          subtitle: Strings.adFreeReading,
          buttonText: Strings.subscribe,
          buttonColor: context.primary,
          borderColor: context.inputStrokeInactiveColor,
          price: '25 000 ${Strings.currencySom}',
          priceSubtitle: Strings.perMonth,
          onItemClicked: (){
            context.router.push(TariffsRoute());
          },
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
