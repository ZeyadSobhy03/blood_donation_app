import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/core/utils/dio_error_handler.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/data/data_source/edit_profile_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/data/model/edit_profile_model.dart';
import 'package:dio/dio.dart';

class EditProfileApiDataSource implements EditProfileRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authHiveDataSource;

  EditProfileApiDataSource(this.dio, this.authHiveDataSource);

  @override
  Future<EditProfileModel> editProfile({
    required String name,
    required String email,
    required String phone,
    required String location,
    required String bloodType,
    required double weight,
    required String age,
    required String gender,
  }) async {
    try {
      final token = await authHiveDataSource.getAccessToken();
      final response = await dio.put(
        ApiManger.editProfileEndpoint,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'location': location,
          'bloodType': bloodType,
          'weight': weight,
          'age': age,
          'gender': gender,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return EditProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}