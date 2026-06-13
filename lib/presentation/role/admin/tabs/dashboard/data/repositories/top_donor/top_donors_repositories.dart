import '../../model/top_donor/top_donor_model.dart';

abstract class TopDonorsRepositories {

  Future<TopDonorsModel > getTopDonors();

}