
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
    required String fullName,
    required String email,
    required String phoneNumber,
    required String gender,
    required int weight,
    required String bloodType,
    required String dateOfBirth,

    required String city,
    required String governorate,

    required double lat,
    required double lng,

  }) async {
    try {
      final token = await authHiveDataSource.getAccessToken();

      final Map<String, dynamic> data = {
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'bloodType': bloodType,
        'weight': weight,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        "location": {
          "city": city,
          "governorate": governorate,
          "coordinates": {
            "lat": lat,
            "lng": lng,
          }
        }
      };


      final response = await dio.put(
        ApiManger.editProfileEndpoint,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      try {
        return EditProfileModel.fromJson(response.data);
      } catch (e) {

        rethrow;
      }
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {

      rethrow;
    }
  }
}