import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/data/data_source/find_donors_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/data/model/find_donors_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/data/repositories/find_donors_repository.dart';

class FindDonorsRepositoryImp implements FindDonorsRepository {
  final FindDonorsRemoteDataSource findDonorsRemoteDataSource;

  FindDonorsRepositoryImp({required this.findDonorsRemoteDataSource});

  @override
  Future<FindDonorsModel> findDonors({
    required String token,
    String? bloodType,
    double? radiusKm,
    double? lat,
    double? lng,
    bool availability = true,
    int page = 1,
    int limit = 20,
  }) {
    return findDonorsRemoteDataSource.findDonors(
      token: token,
      bloodType: bloodType,
      radiusKm: radiusKm,
      lat: lat,
      lng: lng,
      availability: availability,
      page: page,
      limit: limit,
    );
  }
}