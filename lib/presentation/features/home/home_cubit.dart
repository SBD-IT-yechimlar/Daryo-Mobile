import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@Injectable()
class HomeCubit extends BaseCubit<HomeState, HomeEvent> {

  HomeCubit() : super(HomeState()) {}

}
