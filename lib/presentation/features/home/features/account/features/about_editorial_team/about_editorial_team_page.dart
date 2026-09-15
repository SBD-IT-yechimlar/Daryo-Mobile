import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/account/custom_container.dart';
import 'package:daryo/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:daryo/presentation/widgets/divider/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../../domain/models_daryo/face_behind/face_behind.dart';
import '../../../../../../widgets/dashboard/recommendation/recommendation_shimmer_list.dart';
import '../../../../../../widgets/image/rounded_cached_network_image_widget.dart';
import '../../../../../../widgets/loading/loader_state_widget.dart';
import '../../../../../../widgets_daryo/tahririyat/face_behind_list.dart';
import 'about_editorial_team_cubit.dart';

@RoutePage()
class AboutEditorialTeamPage extends BasePage<AboutEditorialTeamCubit,
    AboutEditorialTeamState, AboutEditorialTeamEvent> {
  const AboutEditorialTeamPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, AboutEditorialTeamState state) {
    List<Widget> socialMedia = [
      Assets.imagesDaryo.icTelegram.svg(),
      Assets.imagesDaryo.icInstagramm.svg(),
      Assets.imagesDaryo.icXTwitter.svg(),
    ];

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: DefaultAppBar(
          titleText: Strings.editorial,
          titleTextColor: context.textPrimary,
          backgroundColor: context.backgroundColor,
          onBackPressed: () {
            context.router.pop();
          },
          context: context),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: title()
                    .s(12)
                    .w(400)
                    .c(context.textSecondary)
                    .copyWith(overflow: TextOverflow.clip, softWrap: true),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: LoaderStateWidget(
                    onRetryClicked: () {
                      cubit(context).getSpecialists();
                    },
                    emptyBody: SizedBox(),
                    loadingState: state.specialistsState,
                    loadingBody: Column(
                      children: [
                        loadingBody(context),
                        SizedBox(height: 10),
                        loadingBody(context),
                      ],
                    ),
                    successBody: Column(
                      children: [
                        specialistsParent(context,state),
                        SizedBox(height: 15),
                        CustomDivider(),
                        SizedBox(height: 15),
                        specialistsSub(context,state)
                      ],
                    )),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 32,
                            width: 2,
                            color: context.primary,
                          ),
                          SizedBox(width: 6),
                          Strings.facesBehindContent
                              .s(16)
                              .w(500)
                              .c(context.textPrimary),
                        ],
                      ),
                      //"View all".s(12).w(400).c(context.primary)
                    ]),
              ),
              SizedBox(height: 20),
              faceBehinds(context,state),
              SizedBox(height: 30),
              Column(
                children: [
                  Assets.images.sbd.svg(
                      color: context.isDarkMode
                          ? Colors.white
                          : Color(0xFF1A1C1E)),
                  SizedBox(height: 10),
                  Strings.presentedBySbd
                      .s(14)
                      .w(700)
                      .c(context.textPrimary),
                  SizedBox(height: 20.h),
                ],
              ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard() {
    return Stack(
      children: [
        SizedBox(
          height: 244,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Assets.imagesDaryo.pngImages.img3
                .image(fit: BoxFit.fitHeight, alignment: Alignment.center),
          ),
        ),
        Positioned(
          bottom: 12,
          left: 12,
          child: "Some text".s(16).w(400).c(StaticColors.white),
        ),
      ],
    );
  }

  Widget loadingBody(BuildContext context) {
    List<Widget> socialMedia = [
      Assets.imagesDaryo.icTelegram.svg(),
      Assets.imagesDaryo.icInstagramm.svg(),
      Assets.imagesDaryo.icXTwitter.svg(),
    ];
    return GestureDetector(
      onTap: () {
        context.router.push(TeamMemberInfoRoute());
      },
      child: CustomContainer(
        backgroundColor: context.backgroundWhiteColor,
        crossAxisAlignmentCenter: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Shimmer.fromColors(
                  baseColor: context.shimmerBaseColor,
                  highlightColor: context.shimmerHighLightColor,
                  child: Container(
                    color: context.backgroundWhiteColor,
                    height: 200.h,
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: 20),
          Shimmer.fromColors(
            baseColor: context.shimmerBaseColor,
            highlightColor: context.shimmerHighLightColor,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4)),
                width: 200,
                height: 20),
          ),
          SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: context.shimmerBaseColor,
            highlightColor: context.shimmerHighLightColor,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4)),
                width: 100,
                height: 20),
          ),
          SizedBox(height: 20),
         /* Wrap(
            spacing: 10,
            runSpacing: 10,
            children: socialMedia,
          )*/
        ],
      ),
    );
  }

  Widget specialistsParent(BuildContext context,AboutEditorialTeamState state){
    return Column(children: [
      if (state.first != null)
        CustomContainer(
            backgroundColor: context.backgroundWhiteColor,
            crossAxisAlignmentCenter: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: RoundedCachedNetworkImage(
                        errorIcon: Container(
                          color: context.containerBackground,
                          child: Assets.imagesv2.aa.svg(),
                        ),
                        imageId:"https://data.daryo.uz/${state.first?.photo??""}" ,
                        width: double.infinity,
                        borderRadius: 16,
                        height: 200.h,
                      ),
                    ),
                    /*   Positioned(
                                          top: 12,
                                          right: 12,
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(74),
                                                color: Color(0x80000000)),
                                            child: Assets
                                                .imagesDaryo.icAboutTeamArrowUp
                                                .svg(),
                                          ))*/
                  ],
                ),
              ),
              SizedBox(height: 20),
              "${state.first?.fio}".s(20).w(500).c(context.textPrimary).copyWith(textAlign: TextAlign.center),
              SizedBox(height: 8),
              "${state.first?.speciality}".s(16).w(400).c(context.textSecondary).copyWith(textAlign: TextAlign.center),
              SizedBox(height: 20),
              /*Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: socialMedia,
                                )*/
            ]),
      if (state.second != null)
        CustomContainer(
            backgroundColor: context.backgroundWhiteColor,
            crossAxisAlignmentCenter: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: RoundedCachedNetworkImage(
                        errorIcon: Container(
                          color: context.containerBackground,
                          child: Assets.imagesv2.aa.svg(),
                        ),
                        imageId:"https://data.daryo.uz/${state.second?.photo??""}" ,
                        width: double.infinity,
                        borderRadius: 16,
                        height: 200.h,
                      ),
                    ),
                    /*   Positioned(
                                          top: 12,
                                          right: 12,
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(74),
                                                color: Color(0x80000000)),
                                            child: Assets
                                                .imagesDaryo.icAboutTeamArrowUp
                                                .svg(),
                                          ))*/
                  ],
                ),
              ),
              SizedBox(height: 20),
              "${state.second?.fio}".s(20).w(500).c(context.textPrimary).copyWith(textAlign: TextAlign.center),
              SizedBox(height: 8),
              "${state.second?.speciality}".s(16).w(400).c(context.textSecondary).copyWith(textAlign: TextAlign.center),
              SizedBox(height: 20),
              /*Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: socialMedia,
                                )*/
            ]),
    ],);
  }

  Widget specialistsSub(BuildContext context,AboutEditorialTeamState state){
    final subSpecialists=getSublist(state.specialists);
    return subSpecialists!=null?Column(
      children: List.generate(
          subSpecialists.length, (index) {
            final item=subSpecialists[index];
        return CustomContainer(
            backgroundColor: context.backgroundWhiteColor,
            crossAxisAlignmentCenter: true,
            children: [
              Row(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Stack(children: [
                      SizedBox(
                        height: 100,
                        width: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child:RoundedCachedNetworkImage(
                            errorIcon: Container(
                              color: context.containerBackground,
                              child: Assets.imagesv2.aa.svg(),
                            ),
                            imageId:"https://data.daryo.uz/${item.photo}" ,
                            width: double.infinity,
                            borderRadius: 16,
                            height: 200.h,
                          ),
                        ),
                      ),
                      /*Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(74),
                                color: Color(0x80000000)),
                            child: Assets.imagesDaryo.icAboutTeamArrowUp
                                .svg(height: 14, width: 14),
                          ))*/
                    ]),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        item.fio
                            .s(16)
                            .w(400)
                            .c(context.textPrimary),
                        item.speciality.s(16).w(400).c(context.textSecondary).copyWith(textAlign: TextAlign.center),
                        SizedBox(height: 10),
                    
                      ],
                    ),
                  )
                ],
              )
            ]);
      })):SizedBox();
  }

  Widget faceBehinds(BuildContext context,AboutEditorialTeamState state){
   return  LoaderStateWidget(
       onRetryClicked: () {
         cubit(context).getFaceBehinds();
       },
       emptyBody: SizedBox(),
       loadingState: state.faceBehindsState,
       loadingBody: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 24),
         child: DashboardCommonListShimmer(),
       ),
       successBody: FaceBehindListWidget(
         faceBehindList: state.faceBehinds,
         onItemClicked: (FaceBehind item) {
         },
       ));
  }

  List<T>? getSublist<T>(List<T> list) {
    if (list.length < 6) return null;
    return list.sublist(3, 7);
  }

  String title(){
    if(Strings.daryoUz=="uz"){
      return """“Daryo” internet-nashrida 50 dan ortiq tajribali, yosh taniqli jurnalistlar, shuningdek, muharrir va musahhihlar faoliyat olib bormoqda. Ijodiy jamoamizda ham yosh kadrlarni, ham katta ish tajribasiga ega jurnalistlarni uchratishingiz mumkin.
                \nBiz o‘quvchilarimizni barcha muhim voqealar va yangiliklardan xabardor qilish uchun kuniga 24 soat, yiliga 365 kun ishlaymiz.""";
    }
    if(Strings.daryoUz=="ru"){
      return """«В интернет-издании “Daryo” работают более 50 опытных и молодых известных журналистов, а также редакторы и корректоры. В нашей творческой команде вы можете встретить как молодых специалистов, так и журналистов с большим опытом работы.
      \nМы работаем 24 часа в сутки, 365 дней в году, чтобы наши читатели были в курсе всех важных событий и новостей.»""";
    }
    if(Strings.daryoUz=="en"){
      return """At the online publication ‘Daryo,’ more than 50 experienced and young well-known journalists, as well as editors and proofreaders, are working. In our creative team, you can find both young professionals and journalists with extensive work experience.
      \nWe work 24 hours a day, 365 days a year, to keep our readers informed about all important events and news.""";
    }
    if(Strings.daryoUz=="uzk"){
      return """“Дарё” интернет-нашрида 50 дан ортиқ тажрибали, ёш таниқли журналистлар, шунингдек, муҳаррир ва мусаҳҳиҳлар фаолият олиб бормоқда. Ижодий жамоамизда ҳам ёш кадрларни, ҳам катта иш тажрибасига эга журналистларни учратишингиз мумкин.
                \nБиз ўқувчиларимизни барча муҳим воқеалар ва янгиликлардан хабардор қилиш учун кунига 24 соат, йилига 365 кун ишлаймиз.""";;
    }

    return """“Daryo” internet-nashrida 50 dan ortiq tajribali, yosh taniqli jurnalistlar, shuningdek, muharrir va musahhihlar faoliyat olib bormoqda. Ijodiy jamoamizda ham yosh kadrlarni, ham katta ish tajribasiga ega jurnalistlarni uchratishingiz mumkin.
                \nBiz o‘quvchilarimizni barcha muhim voqealar va yangiliklardan xabardor qilish uchun kuniga 24 soat, yiliga 365 kun ishlaymiz.""";
  }
}
