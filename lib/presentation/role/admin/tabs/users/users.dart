import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/widgets/add_hospital_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/widgets/users_info_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/hospital_title.dart';
import 'package:flutter/material.dart';
import '../../../../../core/resources/models/user_model.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';

import 'widgets/user_card.dart';
import 'widgets/user_filter_chips.dart';
import 'widgets/user_stat_chip.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  static const String _roleAll = 'all';
  static const String _roleDonor = 'donor';
  static const String _roleHospital = 'hospital';
  static const String _roleAdmin = 'admin';

  final TextEditingController _searchController = TextEditingController();

  final List<UserModel> dummyUsers = [
    UserModel(
      totalDonations: 5,
      isVerified: true,
      id: '1',
      name: 'Michael Chen',
      email: 'michael@gmail.com',
      phone: '+1 555-0101',
      role: _roleDonor,
      bloodType: 'O+',
      isActive: true,
      joinedAt: 'Jan 12, 2024',
    ),
    UserModel(
      totalDonations: 0,
      isVerified: true,
      id: '2',
      name: 'Lisa Rodriguez',
      email: 'lisa@gmail.com',
      phone: '+1 555-0102',
      role: _roleHospital,
      bloodType: 'A-',
      isActive: true,
      joinedAt: 'Feb 3, 2024',
    ),
    UserModel(
      totalDonations: 3,
      isVerified: true,
      id: '3',
      name: 'David Kim',
      email: 'david@gmail.com',
      phone: '+1 555-0103',
      role: _roleDonor,
      bloodType: 'B+',
      isActive: true,
      joinedAt: 'Mar 7, 2024',
    ),
    UserModel(
      totalDonations: 0,
      isVerified: false,
      id: '4',
      name: 'Sarah Johnson',
      email: 'sarah@gmail.com',
      phone: '+1 555-0104',
      role: _roleHospital,
      bloodType: 'O+',
      isActive: false,
      joinedAt: 'Mar 15, 2024',
    ),
    UserModel(
      totalDonations: 8,
      isVerified: true,
      id: '5',
      name: 'Emily White',
      email: 'emily@gmail.com',
      phone: '+1 555-0105',
      role: _roleDonor,
      bloodType: 'AB+',
      isActive: true,
      joinedAt: 'Apr 1, 2024',
    ),
    UserModel(
      totalDonations: 0,
      isVerified: true,
      id: '6',
      name: 'James Brown',
      email: 'james@gmail.com',
      phone: '+1 555-0106',
      role: _roleAdmin,
      bloodType: 'O-',
      isActive: true,
      joinedAt: 'Apr 18, 2024',
    ),
    UserModel(
      totalDonations: 6,
      isVerified: true,
      id: '7',
      name: 'Olivia Martinez',
      email: 'olivia@gmail.com',
      phone: '+1 555-0107',
      role: _roleDonor,
      bloodType: 'A+',
      isActive: true,
      joinedAt: 'May 2, 2024',
    ),
    UserModel(
      totalDonations: 1,
      isVerified: false,
      id: '8',
      name: 'Noah Wilson',
      email: 'noah@gmail.com',
      phone: '+1 555-0108',
      role: _roleHospital,
      bloodType: 'B-',
      isActive: false,
      joinedAt: 'May 20, 2024',
    ),
    UserModel(
      totalDonations: 4,
      isVerified: true,
      id: '9',
      name: 'Ava Thompson',
      email: 'ava@gmail.com',
      phone: '+1 555-0109',
      role: _roleDonor,
      bloodType: 'AB-',
      isActive: true,
      joinedAt: 'Jun 5, 2024',
    ),
    UserModel(
      totalDonations: 0,
      isVerified: true,
      id: '10',
      name: 'Liam Garcia',
      email: 'liam@gmail.com',
      phone: '+1 555-0110',
      role: _roleAdmin,
      bloodType: 'O+',
      isActive: true,
      joinedAt: 'Jun 22, 2024',
    ),
  ];

  late List<UserModel> _allUsers;
  late List<UserModel> _filteredUsers;

  bool _showFilter = false;
  String _searchQuery = '';
  String _selectedRole = _roleAll;

  final List<String> _roles = [_roleAll, _roleDonor, _roleHospital, _roleAdmin];

  String _roleLabel(String role, AppLocalizations appLocalization) {
    switch (role) {
      case _roleDonor:
        return appLocalization.donor;
      case _roleHospital:
        return appLocalization.hospitals;
      case _roleAdmin:
        return appLocalization.admins;
      default:
        return appLocalization.viewAll;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _allUsers = List.from(dummyUsers);
    _filteredUsers = List.from(dummyUsers);
  }

  void _applyFilters() {
    setState(() {
      _filteredUsers = _allUsers.where((user) {
        final matchesSearch =
            user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                user.email.toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesRole =
            _selectedRole == _roleAll || user.role == _selectedRole;
        return matchesSearch && matchesRole;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final verifiedCount = _allUsers.where((user) => user.isVerified).length;
    final pendingCount = _allUsers.where((user) => !user.isVerified).length;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                CustomTitle(
                  title: appLocalization.userManagement,
                  subTitle: appLocalization.manageUsersSubtitle,
                ),

                const SizedBox(height: 16),

                CustomTextFormField(
                  textEditingController: _searchController,
                  onChanged: (value) {
                    _searchQuery = value;
                    _applyFilters();
                  },
                  prefixIcon: Icon(Icons.search, color: ColorManger.slateGrey),
                  hintText: appLocalization.searchHint,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _showFilter = !_showFilter),
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      color: _showFilter
                          ? ColorManger.brightRed
                          : ColorManger.slateGrey,
                    ),
                  ),
                ),

                if (_showFilter) ...[
                  const SizedBox(height: 12),
                  UserFilterChips(
                    roles: _roles,
                    selectedRole: _selectedRole,
                    roleLabelBuilder: (role) =>
                        _roleLabel(role, appLocalization),
                    onRoleSelected: (role) {
                      setState(() => _selectedRole = role);
                      _applyFilters();
                    },
                  ),
                ],

                const SizedBox(height: 12),

                _buildStatsRow(),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: UsersInfoCard(
                        icon: Icons.group,
                        label: appLocalization.totalUsers,
                        value: _allUsers.length.toString(),
                        iconColor: ColorManger.skyBlue,
                      ),
                    ),
                    Expanded(
                      child: UsersInfoCard(
                        icon: Icons.verified_outlined,
                        label: appLocalization.verified,
                        value: verifiedCount.toString(),
                        iconColor: ColorManger.green,
                      ),
                    ),
                    Expanded(
                      child: UsersInfoCard(
                        icon: Icons.block_outlined,
                        label: appLocalization.pending,
                        value: pendingCount.toString(),
                        iconColor: ColorManger.brightRed,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                _buildRecentUsersCard(appLocalization),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentUsersCard(AppLocalizations appLocalization) {
    return Card(
      color: ColorManger.pureWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.grey100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: appLocalization.recentUsers,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontWeight: FontWeightManager.semiBold,
                    fontSize: FontSize.s16,
                  ),
                ),
                CustomElevatedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),

                  ),
                  backgroundColor: ColorManger.brightPurple,
                  foregroundColor: ColorManger.pureWhite,
                  onPressed: () {
                    showDialog(context: context, builder: (context) {
                      return const AddHospitalDialog();
                    },);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add, size: 16),
                      const SizedBox(width: 4),
                      CustomText(text: appLocalization.addHospital),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            _buildList(),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    final appLocalization = AppLocalizations.of(context)!;

    if (_filteredUsers.isEmpty) {
      return Center(
        child: CustomText(text: appLocalization.noUsersFound),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _filteredUsers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) =>
          UserCard(showMenu: true, user: _filteredUsers[i]),
    );
  }

  Widget _buildStatsRow() {
    final appLocalization = AppLocalizations.of(context)!;

    final donors = _allUsers
        .where((u) => u.role == _roleDonor)
        .length;
    final hospitals = _allUsers
        .where((u) => u.role == _roleHospital)
        .length;
    final admins = _allUsers
        .where((u) => u.role == _roleAdmin)
        .length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          UserStatChip(
            label: appLocalization.total,
            count: _allUsers.length,
            color: ColorManger.skyBlue,
          ),
          const SizedBox(width: 8),
          UserStatChip(
            label: appLocalization.donors,
            count: donors,
            color: ColorManger.brightRed,
          ),
          const SizedBox(width: 8),
          UserStatChip(
            label: appLocalization.hospitals,
            count: hospitals,
            color: ColorManger.orange,
          ),
          const SizedBox(width: 8),
          UserStatChip(
            label: appLocalization.admins,
            count: admins,
            color: ColorManger.brightPurple,
          ),
        ],
      ),
    );
  }
}