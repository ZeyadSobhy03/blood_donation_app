import 'dart:developer';

import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/data_source/admin_rewards_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/admin_rewards_data_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/earning_rule_create_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/earning_rule_deleted_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/earning_rule_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/earning_rule_updated_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/points_adjusted_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/reward_create_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/rewards_points_update_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/rewards_status_update_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../core/resources/api_manger/api_constants.dart';
import '../../../../../../../core/utils/dio_error_handler.dart';

class AdminRewardsApiDataSource implements AdminRewardsRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;

  AdminRewardsApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<AdminRewardsDataModel> getAdminRewardsData({
    String? query,
    int? limit,
    int? adjustments,
  }) async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.adminRewardsEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        queryParameters: {
          'query': query,
          'limit': limit,
          'adjustments': adjustments,
        },
      );
      return AdminRewardsDataModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PointsAdjustedModel> adjustPoints({required String email, required int amount, required String reason}) async{
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.manuallyUpdateRewardPointsEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'email': email,
          'amount': amount,
          'reason': reason,
        },
      );
      return PointsAdjustedModel.fromJson(response.data);

    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
  }}

  @override
  Future<RewardCreateModel> createReward({required String rewardName, required String rewardSubtitle, required String category, required String status, required int pointsRequired}) async{
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.createAdminReward,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'rewardName': rewardName,
          'rewardSubtitle': rewardSubtitle,
          'category': category,
          'status': status,
          'pointsRequired': pointsRequired,
        },
      );
      return RewardCreateModel.fromJson(response.data);
    } on DioException catch (e) {
      log("Error creating reward: ${e.response?.data  ?? e}");
      handleDioError(e);
      rethrow;
    } catch (e) {
      log("Unexpected error creating reward: $e");
      rethrow;
    }
  }

  @override
  Future<RewardsPointsUpdateModel> updateRewardPoints({required List<Map<String, dynamic>> updates}) async{
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.patch(
        ApiManger.updatePointsForMultipleRewardsEndpoint  ,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'updates': updates,
        },
      );
      return RewardsPointsUpdateModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }

  }

  @override
  Future<RewardsStatusUpdateModel> updateRewardStatus({required String rewardId, required String status}) async{

    try {
      final token = await adminHiveDataSource.getAccessToken();
        final response = await dio.patch(
          ApiManger.updateRewardStatusEndpoint(rewardId),
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {
            'status': status,
          },
        );
        return RewardsStatusUpdateModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<EarningRuleCreateModel> createEarningRule({required String type, required String title, required int points, required String category, required bool isActive})async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.createNewEarningRuleEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'type': type,
          'title': title,
          'points': points,
          'category': category,
          'isActive': isActive,
        },
      );
      return EarningRuleCreateModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<EarningRuleDeletedModel> deleteEarningRule({required String id}) async{
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.delete(
        ApiManger.deleteEarningRuleEndpoint(id),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return EarningRuleDeletedModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<EarningRuleModel> getEarningRules()async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.getEarningRuleEndPoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return EarningRuleModel.fromJson(response.data);

    }
    on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<EarningRuleUpdatedModel> updateEarningRule({required String id, required int points}) async{
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.patch(
        ApiManger.updateEarningRuleEndpoint(id),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'points': points,
        },
      );
      return EarningRuleUpdatedModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
