import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/earning_rules_models.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/domain/use_case/rewards_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EarningRulesCubit extends Cubit<EarningRulesState>{
  final RewardsUseCase rewardsUseCase;
  EarningRulesCubit({required this.rewardsUseCase}) : super(EarningRulesInitialState());

  Future<void>getEarningRules()async{
    try {
      emit(EarningRulesLoadingState());
      final earningRulesModels = await rewardsUseCase.getEarningRules();
      if(earningRulesModels.success == true && earningRulesModels.data != null){
        emit(EarningRulesSuccessState(earningRulesModels));
      }else{
        emit(EarningRulesErrorState('server_error'));
      }
    } on NetworkTimeoutException {
      emit(EarningRulesErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(EarningRulesErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(EarningRulesErrorState('unauthorized'));
    } on NotFoundException {
      emit(EarningRulesErrorState('not_found'));
    } on RequestCancelledException {
      emit(EarningRulesErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(EarningRulesErrorState('unknown_error'));
    } catch (e) {
      emit(EarningRulesErrorState('unknown_error'));
    }
  }


}
sealed class EarningRulesState {}
class EarningRulesInitialState extends EarningRulesState {}
class EarningRulesLoadingState extends EarningRulesState {}
class EarningRulesSuccessState extends EarningRulesState {
  final EarningRulesModels earningRulesModels;
  EarningRulesSuccessState(this.earningRulesModels);
}
class EarningRulesErrorState extends EarningRulesState {
  final String error;
  EarningRulesErrorState(this.error);
}