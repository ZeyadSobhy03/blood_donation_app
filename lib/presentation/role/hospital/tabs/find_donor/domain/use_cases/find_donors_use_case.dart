import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/data/model/find_donors_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/data/repositories/find_donors_repository.dart';

class FindDonorsUseCase {
  final FindDonorsRepository findDonorsRepository;

  FindDonorsUseCase({required this.findDonorsRepository});

  Future<FindDonorsModel> call({
    required String token,
    String? bloodType,
    double? radiusKm,
    double? lat,
    double? lng,
    bool availability = true,
    int page = 1,
    int limit = 20,
  }) {
    return findDonorsRepository.findDonors(
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