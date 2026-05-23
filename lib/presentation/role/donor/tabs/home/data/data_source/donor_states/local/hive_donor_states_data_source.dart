import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/donor_states/local/local_donor_states_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donor_states/donor_state_model.dart';
import 'package:hive_ce/hive.dart';

class HiveDonorStatesDataSource implements LocalDonorStatesDataSource {
  static const String _donorStatesBoxName = 'donor_states_box';
  static const String _donorStatesKey = 'donor_states';

  late Box _donorStatesBox;

  @override
  Future<void> init() async {
    try {
      _donorStatesBox = await Hive.openBox(_donorStatesBoxName);
    } catch (e) {
      throw Exception('Failed to initialize donor states box: $e');
    }
  }

  @override
  Future<void> saveDonorStates(DonorStateModel donorStateModel) async {
    try {
      await _donorStatesBox.put(
        _donorStatesKey,
        donorStateModel.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to save donor states: $e');
    }
  }

  @override
  Future<DonorStateModel?> getDonorStates() async {
    try {
      final data = _donorStatesBox.get(_donorStatesKey);
      if (data == null) return null;
      return DonorStateModel.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get donor states: $e');
    }
  }

  @override
  Future<void> clearDonorStates() async {
    try {
      await _donorStatesBox.delete(_donorStatesKey);
    } catch (e) {
      throw Exception('Failed to clear donor states: $e');
    }
  }
}

