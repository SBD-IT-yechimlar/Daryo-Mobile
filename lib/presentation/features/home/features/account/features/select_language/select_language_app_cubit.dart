import 'package:daryo/data/repositories/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';

import '../../../../../../../data/repositories/language_repository.dart';
import '../../../../../../../domain/models/language/language.dart';

part 'select_language_app_cubit.freezed.dart';
part 'select_language_app_state.dart';

@Injectable()
class SelectLanguageAppCubit extends BaseCubit<SelectLanguageAppState, SelectLanguageAppEvent> {
  SelectLanguageAppCubit(this._languageRepository)
      : super(const SelectLanguageAppState()) {
    // getPaymentMerchantToken();
  }


  final LanguageRepository _languageRepository;



  void getLanguage() => _languageRepository.getLanguage();

  bool get isRussianSelected =>
      _languageRepository.getLanguage() == Language.russian;

  bool get isUzbekLatinSelected =>
      _languageRepository.getLanguage() == Language.uzbekLatin;

  bool get isUzbekCyrillSelected =>
      _languageRepository.getLanguage() == Language.english;

  Future<void> setLanguage(Language language) async {
    await _languageRepository.setLanguage(language);
  }

  }
