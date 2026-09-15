import 'dart:async';

import 'package:daryo/core/extensions/list_extensions.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/data/datasource/preference/auth_preferences.dart';
import 'package:daryo/domain/models_daryo/shorts/shorts.dart';
import 'package:daryo/presentation/stream_controllers/language_selection_stream_controller.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import 'package:logger/logger.dart';

import '../../../../../data/repositories/dashboard_repository.dart';
import '../../../../../domain/models_daryo/category/category.dart';
import '../../../../../domain/models_daryo/recommendation/caregory.dart';
import '../../../../../domain/models_daryo/recommendation/recommendation.dart';
import '../../../../../domain/models_daryo/slider/slider.dart';
import '../../../../../domain/models_daryo/tags/tag.dart';
import '../../../../../domain/models_daryo/video/video.dart';
import '../../../../support/connection/connectivity_provider.dart';

part 'dashboard_cubit.freezed.dart';

part 'dashboard_state.dart';

@Injectable()
class DashboardCubit extends BaseCubit<DashboardState, DashboardEvent> {
  final DaryoDashboardRepository _dashboardRepository;
  final ConnectivityService  _connectivityService;
  final AuthPreferences _authPreferences;
  final LanguageSelectionStreamController _languageSelectionStreamController;
  StreamSubscription? _languageSubs;
  DashboardCubit(this._dashboardRepository, this._connectivityService,this._authPreferences,this._languageSelectionStreamController) : super(DashboardState()) {
    getInitialData();
    isAuthorized();
    _languageSubs=_languageSelectionStreamController.listen((data)async{
      await Future.delayed(Duration(seconds: 1));
      getInitialData();
    });
  }



  void isAuthorized(){
    final isAuthorized =_authPreferences.isAuthorized;
    updateState((state) => state.copyWith(isRegistered: isAuthorized));

  }

  Future _checkInternetConnection() async{
    final connected= await _connectivityService.hasInternetConnection();
    if(connected==false){
      emitEvent(DashboardEvent(DashboardEventType.lostConnection));
    }
  }


  Future<void> getInitialData() async {
    updateState((state) => state.copyWith(categoryMap: {}));
    await Future.wait([
      _checkInternetConnection(),
      getSliders(),
      getRecommendations(),
      getCategories(),
      getDashboardCategoriesV2(),
      getHotNews(),
      getDunyoNews(),
    //  getTags(),
      getShorts(),
      getAutoNews(),
      getVideos(),
      getLatestNews(),
    ]);
  }

  reload() async {
    await Future.wait([
      _checkInternetConnection(),
      getSliders(),
      getRecommendations(),
      getCategories(),
      getDashboardCategoriesV2(),
      getHotNews(),
      getDunyoNews(),
    //  getTags(),
      getShorts(),
      getAutoNews(),
      getVideos(),
      getLatestNews(),
    ]);
  }


  changeIsGrid(bool value){
    updateState((state) => state.copyWith(isGrid: value));
  }

  Future<void> getSliders() async {
    _dashboardRepository
        .getSliders(limit: 5, page: 0)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(sliderState: LoadingState.loading));
        }).onSuccess((data) {
      updateState((state) => state.copyWith(
           sliders: data,
          sliderState: LoadingState.success));
    }).onError((error) {
      updateState((state) => state.copyWith(sliderState: LoadingState.error));
    }).onFinished(() {})
        .executeFuture();
  }

  Future<void> getRecommendations() async {
    _dashboardRepository
        .getRecommendations(limit: 4, page: 0)
        .initFuture()
        .onStart(() {
      updateState((state) => state.copyWith(recommendationsState: LoadingState.loading));
    }).onSuccess((data) {
      updateState((state) => state.copyWith(
          recommendations: data,
          recommendationsState: LoadingState.success));
    }).onError((error) {
      updateState((state) => state.copyWith(recommendationsState: LoadingState.error));
    }).onFinished(() {})
        .executeFuture();
  }

  Future<void> getHotNews() async {
    _dashboardRepository
        .getHotNews(limit: 4, page: 4)
        .initFuture()
        .onStart(() {
      updateState((state) => state.copyWith(hotNewsState: LoadingState.loading));
    }).onSuccess((data) {
      updateState((state) => state.copyWith(
          hotNews: data,
          hotNewsState: LoadingState.success));
    }).onError((error) {
      updateState((state) => state.copyWith(hotNewsState: LoadingState.error));
    }).onFinished(() {})
        .executeFuture();
  }


  Future<void> getDunyoNews() async {
    _dashboardRepository
        .getDunyoNews(limit: 4, page: 0)
        .initFuture()
        .onStart(() {
      updateState((state) => state.copyWith(dunyoNewsState: LoadingState.loading));
    }).onSuccess((data) {
      updateState((state) => state.copyWith(
          dunyoNews: data,
          dunyoNewsState: LoadingState.success));
    }).onError((error) {
      updateState((state) => state.copyWith(dunyoNewsState: LoadingState.error));
    }).onFinished(() {})
        .executeFuture();
  }

  Future<void> getTags() async {
    _dashboardRepository
        .getTags(limit: 20, page: 0)
        .initFuture()
        .onStart(() {
      updateState((state) => state.copyWith(tagsState: LoadingState.loading));
    }).onSuccess((data) {
      updateState((state) => state.copyWith(
          tags: data,
          tagsState: LoadingState.success));
    }).onError((error) {
      updateState((state) => state.copyWith(tagsState: LoadingState.error));
    }).onFinished(() {})
        .executeFuture();


  }

  Future<void> getShorts() async {
    _dashboardRepository
        .getShorts(limit: 6, page: 0)
        .initFuture()
        .onStart(() {
      updateState((state) => state.copyWith(shortsState: LoadingState.loading));
    }).onSuccess((data) {
      updateState((state) => state.copyWith(
          shorts: data,
          shortsState: LoadingState.success));
    }).onError((error) {
      updateState((state) => state.copyWith(shortsState: LoadingState.error));
    }).onFinished(() {})
        .executeFuture();
  }

  Future<void> getAutoNews() async {
    _dashboardRepository
        .getAutoNews(limit: 3, page: 1)
        .initFuture()
        .onStart(() {
      updateState((state) => state.copyWith(autoNewsState: LoadingState.loading));
    }).onSuccess((data) {
      updateState((state) => state.copyWith(
          autoNews: data,
          autoNewsState: LoadingState.success));
    }).onError((error) {
      updateState((state) => state.copyWith(autoNewsState: LoadingState.error));
    }).onFinished(() {})
        .executeFuture();
  }

  Future<void> getLatestNews() async {
    _dashboardRepository
        .getLatestNews(limit: 3, page: 0)
        .initFuture()
        .onStart(() {
      updateState((state) => state.copyWith(latestNewsState: LoadingState.loading));
    }).onSuccess((data) {
      updateState((state) => state.copyWith(
          latestNews: data,
          latestNewsState: LoadingState.success));
    }).onError((error) {
      updateState((state) => state.copyWith(latestNewsState: LoadingState.error));
    }).onFinished(() {})
        .executeFuture();
  }

  Future<void> getVideos() async {
    _dashboardRepository
        .getVideos(limit: 5, page: 1)
        .initFuture()
        .onStart(() {
      updateState((state) => state.copyWith(videosState: LoadingState.loading));
    }).onSuccess((data) {
      updateState((state) => state.copyWith(
          videos: data,
          videosState: LoadingState.success));
    }).onError((error) {
      updateState((state) => state.copyWith(videosState: LoadingState.error));
    }).onFinished(() {})
        .executeFuture();

  }

  Future<void> getDashboardCategoriesV2() async {
    _dashboardRepository
        .getDashboardCategories()
        .initFuture()
        .onStart(() {
      updateState((state) => state.copyWith(categoryListState: LoadingState.loading));
    }).onSuccess((data) {
      List<Category>  markaziyOsiyo= data.firstIf((e)=> e.id==40)?.children??[];
       final uzbekistanId= data.firstIf((e)=> e.id==1)?.id??0;
       final qirgizistonId= markaziyOsiyo.firstIf((e)=> e.id==41)?.id??0;
       final qozogistonId= markaziyOsiyo.firstIf((e)=> e.id==42)?.id??0;
       final turkmanistonId= markaziyOsiyo.firstIf((e)=> e.id==43)?.id??0;
       final tojikistonId= markaziyOsiyo.firstIf((e)=> e.id==44)?.id??0;
       final afghanistanId= markaziyOsiyo.firstIf((e)=> e.id==45)?.id??0;
       final slugIdMap = {
         "uzbekistan": uzbekistanId,
         "qirgiziston": qirgizistonId,
         "qozogiston": qozogistonId,
         "turkmaniston": turkmanistonId,
         "tojikiston": tojikistonId,
         "afgoniston": afghanistanId,
       };
       List<CategoryModel> categories=List.of(states.category);
       for (var item in categories) {
         if (slugIdMap.containsKey(item.slug)) {
           item.byCategoryId = slugIdMap[item.slug]??0;
         }
       }
       updateState((state) => state.copyWith(
           category: categories,
           categoryListState: LoadingState.success
       ));
      selectCategory(categories.first);
    }).onError((error) {
      updateState((state) => state.copyWith(categoryListState: LoadingState.error));
    }).onFinished(() {})
        .executeFuture();

  }



  Future<void> getCategories() async {
    List<CategoryModel> categories=[];
    categories.add(CategoryModel(id: 0, name: Strings.uzbekistan, slug: "uzbekistan", byCategoryId: 0));
    categories.add(CategoryModel(id: 1, name: Strings.kyrgyzstan, slug: "qirgiziston", byCategoryId: 0));
    categories.add(CategoryModel(id: 2, name: Strings.kazakhstan, slug: "qozogiston", byCategoryId: 0));
    categories.add(CategoryModel(id: 3, name: Strings.turkmenistan, slug: "turkmaniston", byCategoryId: 0));
    categories.add(CategoryModel(id: 4, name: Strings.tajikistan, slug: "tojikiston", byCategoryId: 0));
    categories.add(CategoryModel(id: 5, name: Strings.afghanistan, slug: "afgoniston", byCategoryId: 0));
    updateState((state) => state.copyWith(category: categories));
  }

  Future<void> getCategoriesApi(String index, int id) async {
    final oldList = states.categoryMap[index];
    if(oldList!=null && states.language==Strings.localeHeader){
      updateState((state) => state.copyWith(
        categoryList: oldList,
        categoryListState: LoadingState.success,
      ));
    }else{
      _dashboardRepository
          .getDashboardAsiaNews(id: id)
          .initFuture()
          .onStart(() {
        updateState((state) => state.copyWith(categoryListState: LoadingState.loading));
      }).onSuccess((data) {
        states = states.copyWith(
          categoryMap: {
            ...states.categoryMap,
            index: data,
          },
        );
        updateState((state) => state.copyWith(
            categoryList: data,
            categoryListState: LoadingState.success,
            language: Strings.localeHeader
        ));
      }).onError((error) {
        updateState((state) => state.copyWith(categoryListState: LoadingState.error));
      }).onFinished(() {})
          .executeFuture();
    }
  }


  void selectCategory(CategoryModel item){
    updateState((state) => state.copyWith(
        categoryId: item.id,
        categoryName: item.name,
       categorySlug: item.slug,
       byCategoryId: item.byCategoryId
    ));
    getCategoriesApi(item.slug,item.byCategoryId);

  }

  @override
  Future<void> close() {
    _languageSubs?.cancel();
    return super.close();
  }


}
