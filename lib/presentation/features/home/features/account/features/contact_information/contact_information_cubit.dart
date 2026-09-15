import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';

import '../../../../../../../data/repositories/auth_repository.dart';

part 'contact_information_cubit.freezed.dart';
part 'contact_information_state.dart';

@Injectable()
class ContactInformationCubit
    extends BaseCubit<ContactInformationState, ContactInformationEvent> {
  ContactInformationCubit(this._authRepository)
      : super(const ContactInformationState()) {
    // getPaymentMerchantToken();
  }

  final AuthRepository _authRepository;


}
