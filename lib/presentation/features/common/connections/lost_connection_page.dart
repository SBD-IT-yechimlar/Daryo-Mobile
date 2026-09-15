import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../widgets/common/sending_toast.dart';
import 'lost_connection_cubit.dart';

@RoutePage()
class LostConnectionPage extends BasePage<LostConnectionCubit, LostConnectionState, LostConnectionEvent> {
  const LostConnectionPage({super.key});

  @override
  void onEventEmitted(BuildContext context, LostConnectionEvent event) {
    switch(event.type){
      case LostConnectionEventType.lostConnection:
        showAppToast(
          context,
          "Ma'lomotlarni olish uchun internet tagmogiga ulangan bo'lishingz zarru!",
        );
      case LostConnectionEventType.connected:
        Navigator.of(context).pop(true);
    }
  }
  @override
  Widget onWidgetBuild(BuildContext context, LostConnectionState state) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Assets.images.noConnection.svg(),
                SizedBox(height: 10.h),
                "Ops! Ulanish uzilib qoldi".s(24).w(600),
                SizedBox(height: 10.h),
                "Internetingizda kichik muammo bo‘lishi mumkin. Tekshirib, qayta urinib ko‘ring.".s(14).w(400).c(Color(0xFF6C7278)).copyWith(textAlign: TextAlign.center),
                 SizedBox(height: 40.h),
                 CustomElevatedButton(text: "Ulanishni tekshirish", onPressed: (){
                   HapticFeedback.lightImpact();
                   cubit(context).checkInternetConnection();
                 }),
            ],),
          ),
        ),
      ),
    );
  }
}
