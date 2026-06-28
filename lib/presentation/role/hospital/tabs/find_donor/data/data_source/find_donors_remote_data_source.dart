import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/data/model/find_donors_model.dart';

abstract class FindDonorsRemoteDataSource {
  /// GET /hospital/find-donors
  Future<FindDonorsModel> findDonors({
    required String token,
    String? bloodType,
    double? radiusKm,
    double? lat,
    double? lng,
    bool availability,
    int page,
    int limit,
  });
}