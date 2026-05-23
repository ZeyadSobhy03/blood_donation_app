import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/data_source/rewards_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/badges_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/earning_rules_models.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/points_history.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/points_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/redeem_reward.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/rewards_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';

class RewardsApiDataSource implements RewardsRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authLocalDataSource;

  RewardsApiDataSource(this.dio, this.authLocalDataSource);

  @override
  Future<BadgesModel> getBadges() async {
    try {
      final token = await authLocalDataSource.getAccessToken();

      final response = await dio.get(
        ApiManger.badgesEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return BadgesModel.fromJson(response.data);
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw Exception('Failed to load badges: $e');
    }
  }

  void _handleDioError(DioException e) {
    final _ = switch (e.type) {
      DioExceptionType.connectionTimeout =>
        'Connection timeout - please check your internet',
      DioExceptionType.sendTimeout => 'Send timeout - please try again',
      DioExceptionType.receiveTimeout => 'Receive timeout - please try again',
      DioExceptionType.badResponse => 'Server error: ${e.response?.statusCode}',
      DioExceptionType.cancel => 'Request cancelled',
      DioExceptionType.unknown => 'Network error: ${e.message}',
      _ => 'Unknown error occurred',
    };
  }

  @override
  Future<RewardsModel> getRewards() async{
    try{
      final token = await authLocalDataSource.getAccessToken();

      final response = await dio.get(
        ApiManger.rewardsEndpoint,
        queryParameters: {
          'sort_by': 'COST_ASC',
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return RewardsModel.fromJson(response.data);
    }
    on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw Exception('Failed to load rewards: $e');
    }
  }

  @override
  Future<RedeemReward> redeemReward({required String rewardId}) async{
    try{
      final token = await authLocalDataSource.getAccessToken();

      final response = await dio.post(
        ApiManger.redeemRewardEndpoint(rewardId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return RedeemReward.fromJson(response.data);
    }
    on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw Exception('Failed to redeem reward: $e');
    }
  }

  @override
  Future<PointsModel> getUserPoints() async{
    try{
      final token = await authLocalDataSource.getAccessToken();

      final response = await dio.get(
        ApiManger.userPointsEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return PointsModel.fromJson(response.data);
    }
    on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw Exception('Failed to load user points: $e');
    }


  }

  @override
  Future<PointsHistory> getPointsHistory() async{
    try{
      final token = await authLocalDataSource.getAccessToken();

      final response = await dio.get(
        ApiManger.pointsHistoryEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return PointsHistory.fromJson(response.data);
    }
    on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw Exception('Failed to load points history: $e');
    }
  }

  @override
  Future<EarningRulesModels> getEarningRules() async{
    try{
      final token = await authLocalDataSource.getAccessToken();

      final response = await dio.get(
        ApiManger.earningRulesEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return EarningRulesModels.fromJson(response.data);
    }
    on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw Exception('Failed to load earning rules: $e');
    }
  }


}


