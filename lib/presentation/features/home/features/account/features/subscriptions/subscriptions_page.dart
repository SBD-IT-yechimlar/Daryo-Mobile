import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../widgets/account/payment_widget.dart';
import '../../../../../../widgets/button/custom_elevated_button.dart';
import '../../../../../../widgets/loading/loader_state_widget.dart';
import '../../../../../common_daryo/favorites/favorites_empty.dart';
import 'subscriptions_cubit.dart';

@RoutePage()
class SubscriptionsPage extends BasePage<SubscriptionsCubit, SubscriptionsState, SubscriptionsEvent> {
  const SubscriptionsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, SubscriptionsState state) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.backgroundColor,
        elevation: 0,
        title: Strings.subscriptions.s(16).w(700).c(context.textPrimary),
        iconTheme:IconThemeData(color: context.iconPrimary),
      ),
      body: LoaderStateWidget(
        emptyBody: _emptyView(context),
        successBody: successWidget(state, context),
        errorBody: _errorView(context),
        loadingBody: _loadingView(context),
        loadingState: state.loadingState,
      ),
    );
  }

  Widget successWidget(SubscriptionsState state, BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          itemCount: state.subscriptionsList.length,
          itemBuilder: (context, index) {
            final item = state.subscriptionsList[index];
            final isOpen = state.openItems.contains(item.id);
            return PaymentWidget(
              isOpen: true,
              item: item,
              toggleItem: (id) {
                cubit(context).toggleItem(id);
              },
            );
          },
        ),
      /*  GestureDetector(
          onTap: () {
            cubit(context).getSubscriptions();
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFFDFF1FF)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.imagesDaryo.icSubscribtionsRefresh2.svg(),
                SizedBox(width: 8),
                Strings.seeMore.s(14).w(500).c(Color(0xFF0089DA)),
              ],
            ),
          ),
        )*/
      ],
    );
  }

  Widget _emptyView(BuildContext context) {
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
          Strings.noSubscriptions.s(14).w(600).c(context.textPrimary),
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
            onPressed: () {},
            text: Strings.tariffs,
            textColor: context.textPrimary,
            textSize: 14,
          )
        ],
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
            onPressed: () {
              cubit(context).getSubscriptions();
            },
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
