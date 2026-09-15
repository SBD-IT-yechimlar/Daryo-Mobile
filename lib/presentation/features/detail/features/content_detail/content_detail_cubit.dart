import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/data/datasource/preference/user_preferences.dart';
import 'package:daryo/data/repositories/dashboard_repository.dart';
import 'package:daryo/domain/models_daryo/content_detail/content_detail.dart';
import 'package:daryo/domain/models_daryo/recommendation/recommendation.dart';
import 'package:daryo/presentation/support/connection/connectivity_provider.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import 'package:daryo/presentation/support/extensions/extension_message_exts.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../data/datasource/network/dto_daryo/content_detail/like_dislike_response.dart';

part 'content_detail_state.dart';

part 'content_detail_cubit.freezed.dart';

@Injectable()
class ContentDetailCubit extends BaseCubit<ContentDetailState, ContentDetailEvent> {
  final DaryoDashboardRepository _dashboardRepository;
  final ConnectivityService _connectivityService;
  final UserPreferences _userPreferences;
  ContentDetailCubit(this._dashboardRepository, this._connectivityService, this._userPreferences) : super(const ContentDetailState()) {}

  Future _checkInternetConnection() async{
    final connected= await _connectivityService.hasInternetConnection();
    if(connected==false){
      emitEvent(ContentDetailEvent(ContentDetailEventType.lostConnection));
    }
  }

  Future<void> getInitialData(String slug) async {
    await Future.wait([
      _checkInternetConnection(),
      getContentDetail(slug: slug),
      getRecommendations(),
      getLatestNews(),
    ]);
  }

  Future<void> reload(String slug) async {
    await Future.wait([
      _checkInternetConnection(),
      getContentDetail(slug: slug),
      getRecommendations(),
      getLatestNews(),
    ]);
  }




  Future<void> getContentDetail({required String slug}) async {
    updateState((state) => state.copyWith(
        slug: slug,
        offset: 0
    ));
   await _dashboardRepository
        .getContentDetail(slug: slug)
        .initFuture()
        .onStart(() {
         updateState((state) => state.copyWith(contentLoadingState: LoadingState.loading,),
      );
    }).onSuccess((data) {
      final firstTag = data.hashtag.split(", ").firstOrNull?.replaceAll("#", "") ?? "";
      updateState((state) => state.copyWith(
          detail: data,
          contentLoadingState: LoadingState.success,
          tag: firstTag,
          id: data.id,
          like: data.likesCount,
          dislike: data.dislikesCount
        ));
      getRelatedNews(firstTag);
    }).onError((error) {
      updateState(
            (state) => state.copyWith(
          contentLoadingState: LoadingState.error,
        ),
      );
    }).executeFuture();
  }

  /// mavzuga doir yangiliklar
  Future<void> getRelatedNews(String tag) async {
    _dashboardRepository
        .getRelatedNewsByTag(limit: 4, offset: states.offset,tag:tag)
        .initFuture()
        .onStart(() {
      updateState((state) => state.copyWith(relatedNewsState: LoadingState.loading));
    }).onSuccess((data) {
      updateState((state) => state.copyWith(
          relatedNewsList: data,
          relatedNewsState: LoadingState.success,
          offset: state.offset+4
      ));
    }).onError((error) {
      updateState((state) => state.copyWith(relatedNewsState: LoadingState.error));
    }).onFinished(() {})
        .executeFuture();

  }

  Future<void> getMoreLoadRelatedNews() async {
    _dashboardRepository
        .getRelatedNewsByTag(limit: 4, offset: states.offset,tag: states.tag)
        .initFuture()
        .onStart(() {
    }).onSuccess((data) {
      bool haveMore= data.length==4;
      List<Common> newRelatedNews= List.from(states.relatedNewsList);
      newRelatedNews.addAll(data);
      updateState((state) => state.copyWith(
          relatedNewsList: newRelatedNews,
          offset: state.offset+4,
          haveMore: haveMore
      ));
    }).onError((error) {
      emitEvent(ContentDetailEvent(ContentDetailEventType.handleError,text: error.localizedMessage));
    }).onFinished(() {})
        .executeFuture();

  }

  Future<void> getRecommendations() async {
    _dashboardRepository
        .getRecommendations(limit: 4, page: 0)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(recommendationsState: LoadingState.loading));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
              recommendations: data,
              recommendationsState: LoadingState.success));
        })
        .onError((error) {
          updateState((state) =>
              state.copyWith(recommendationsState: LoadingState.error));
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getLatestNews() async {
    _dashboardRepository
        .getLatestNews(limit: 3, page: 0)
        .initFuture()
        .onStart(() {
          updateState(
              (state) => state.copyWith(latestNewsState: LoadingState.loading));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
              latestNews: data, latestNewsState: LoadingState.success));
        })
        .onError((error) {
          updateState(
              (state) => state.copyWith(latestNewsState: LoadingState.error));
        })
        .onFinished(() {})
        .executeFuture();
  }

/*  Future<void> likeOrDislike(String action) async {
    _dashboardRepository
        .likeDislike(states.id, action)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
      updateState((state) => state.copyWith(
          like: data.likes??0,
          dislike: data.dislikes??0
      ));
    })
        .onError((error) {
      logger.d("err ; ${error.toString()}");
    }).onFinished(() {})
        .executeFuture();
  }*/


  Future<void> likeOrDislike(String action) async {
    final response = await _dashboardRepository.likeDislike(states.id, action);
    final res = LikeDislikeResponse.fromJson(response);
    if(res.error!=null){
      emitEvent(ContentDetailEvent(ContentDetailEventType.likedUnSec,text: res.error));
    }
    if(res.likes!=null){
      updateState((state) => state.copyWith(
          like: res.likes??0,
          dislike: res.dislikes??0
      ));
    }

  }




  @override
  Future<void> close() {
    return super.close();
  }
}
