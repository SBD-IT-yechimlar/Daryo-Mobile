import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/account/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../widgets/button/custom_elevated_button.dart';
import '../../../../../../widgets/loading/loader_state_widget.dart';
import 'by_articles_cubit.dart';

@RoutePage()
class ByArticlesPage extends BasePage<ByArticlesCubit, ByArticlesState, ByArticlesEvent> {
  const ByArticlesPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, ByArticlesState state) {

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.backgroundColor,
        elevation: 0,
        title: Strings.purchasedArticles.s(16).w(700).c(context.textPrimary),
        iconTheme:IconThemeData(color: context.iconPrimary),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: LoaderStateWidget(
          emptyBody: _emptyView(context),
          successBody: successWidget(state, context),
          errorBody: _errorView(context),
          loadingBody: _loadingView(context),
          loadingState: LoadingState.empty,
        ),
      ),
    );
  }

  Widget _listWidget(BuildContext context) {
    return CustomContainer(crossAxisAlignmentCenter: true, backgroundColor: context.containerBackground, children: [
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "ID 123456".s(12).w(500).c(context.primary),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(74), color: context.textPrimary),
              child:
                  Assets.imagesDaryo.icAboutTeamArrowUp.svg(height: 14, width: 14, colorFilter: ColorFilter.mode(context.iconColor, BlendMode.srcIn)),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Row(
          children: [
            SizedBox(
              height: 100,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Assets.imagesDaryo.pngImages.img2.image(fit: BoxFit.cover, alignment: Alignment.topCenter),
              ),
            ),
            SizedBox(width: 6),
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Prezident farmoni bilan mahalla yoshlar yetakchilarining asosiy vazifalari belgilandi"
                      .s(14)
                      .w(500)
                      .c(context.textPrimary)
                      .copyWith(overflow: TextOverflow.ellipsis, maxLines: 3, softWrap: true),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Feb 28, 2025".s(12).w(400).c(context.textSecondary),
                      "20:00:00".s(12).w(400).c(context.textSecondary),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )
    ]);
  }

  Widget successWidget(ByArticlesState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return _listWidget(context);
          }),
    );
  }

  Widget _emptyView(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.imagesDaryo.icByArticlesNoteRemove.svg(height: 80, width: 80),
            SizedBox(height: 24),
            Strings.noPurchasedArticles.s(14).w(600).c(context.textPrimary),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Strings.subscribePremiumText
                  .s(12)
                  .w(500)
                  .c(context.textSecondary)
                  .a(TextAlign.center)
                  .copyWith(overflow: TextOverflow.clip, softWrap: true),
            ),
            SizedBox(height: 24),
            CustomElevatedButton(
              onPressed: () {
                context.router.pop();
              },
              text: Strings.closeTitle,
              textColor: context.textPrimary,
              textSize: 14,
            )
          ],
        ),
      ),
    );
  }

  Widget _errorView(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.imagesDaryo.icByArticlesNoteRemove.svg(height: 80, width: 80),
          SizedBox(height: 24),
          Strings.errorOccurredTryAgain.s(14).w(600).a(TextAlign.center).c(context.textPrimary),
          SizedBox(height: 24),
          CustomElevatedButton(
            onPressed: () {},
            text: Strings.commonRefresh,
            textSize: 14,
          )
        ],
      ),
    );
  }

  Widget _loadingView(BuildContext context) {
    return Container(
      color: context.backgroundColor,
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFDFF1FF).withOpacity(0.6),
            ),
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(context.primary),
            ),
          ),
          SizedBox(height: 24),
          Strings.dataLoading.s(14).w(500).c(context.textSecondary).a(TextAlign.center),
        ],
      ),
    );
  }
}
