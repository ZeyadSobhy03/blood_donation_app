import '../../../model/top_donor/top_donor_model.dart';

abstract class TopDonorsRemoteDataSource {
  Future<TopDonorsModel > getTopDonors();

}