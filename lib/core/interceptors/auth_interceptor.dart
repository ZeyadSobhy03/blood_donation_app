import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';
import 'package:dio/dio.dart';


class AuthInterceptor extends Interceptor {
  final AuthHiveDataSource hiveDataSource;
  final Dio dio;
  bool _isRefreshing = false;

  AuthInterceptor({
    required this.hiveDataSource,
    required this.dio,
  });

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await hiveDataSource.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    return handler.next(options);
  }

   @override
   Future<void> onError(
       DioException err, ErrorInterceptorHandler handler) async {
     if (err.response?.statusCode == 401) {
       if (!_isRefreshing) {
         _isRefreshing = true;

         try {
           final refreshToken = await hiveDataSource.getRefreshToken();

           if (refreshToken == null || refreshToken.isEmpty) {
             _isRefreshing = false;
             await hiveDataSource.clearAllData();
             return handler.reject(err);
           }

           await _refreshToken(refreshToken);

           _isRefreshing = false;
           final accessToken = await hiveDataSource.getAccessToken();
           err.requestOptions.headers['Authorization'] =
               'Bearer $accessToken';

           final response = await dio.fetch(err.requestOptions);
           return handler.resolve(response);
         } on DioException catch (e) {
           _isRefreshing = false;
           await hiveDataSource.clearAllData();
           return handler.reject(e);
         } catch (e) {
           _isRefreshing = false;
           await hiveDataSource.clearAllData();
           return handler.reject(err);
         }
       } else {
         await Future.delayed(const Duration(milliseconds: 500));
         return handler.reject(err);
       }
     } else {
       return handler.next(err);
     }
   }

   Future<void> _refreshToken(String refreshToken) async {
     try {
       final response = await dio.post(
         ApiManger.refreshTokenEndpoint,
         data: {'refreshToken': refreshToken},
         options: Options(
           headers: {
             'Content-Type': 'application/json',
             'Accept': 'application/json',
           },
           validateStatus: (status) => status != null && status < 500,
         ),
       );

       if (response.statusCode == 200) {
         final data = response.data;
         final newAccessToken = data['data']?['accessToken'] ??
             data['accessToken'];
         final newRefreshToken = data['data']?['refreshToken'] ??
             data['refreshToken'];

         if (newAccessToken != null && newRefreshToken != null) {
           await hiveDataSource.saveTokens(
             accessToken: newAccessToken,
             refreshToken: newRefreshToken,
           );
         } else {
           throw Exception('Invalid token response format');
         }
       } else {
         throw Exception(
             'Token refresh failed with status code: ${response.statusCode}');
       }
     } catch (e) {
       rethrow;
     }
   }
}

