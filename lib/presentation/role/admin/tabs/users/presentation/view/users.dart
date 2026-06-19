import 'dart:async';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/presentation/view/widgets/add_admin_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/presentation/view/widgets/add_hospital_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/presentation/view/widgets/user_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/presentation/view/widgets/user_filter_chips.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/presentation/view/widgets/user_stat_chip.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/presentation/view/widgets/users_info_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/hospital_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../../../../../donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';
import '../../data/model/users_model.dart';
import '../view_model/users_view_model.dart';

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
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  bool _showFilter = false;
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
  void initState() {
    super.initState();
    context.read<UsersCubit>().getUsers();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<UsersCubit>().loadMoreUsers();
    }
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<UsersCubit>().getUsers(
        search: value.isEmpty ? null : value,
        role: _selectedRole == _roleAll ? null : _selectedRole,
      );
    });
  }

  void _onRoleSelected(String role) {
    setState(() => _selectedRole = role);
    context.read<UsersCubit>().getUsers(
      search: _searchController.text.isEmpty ? null : _searchController.text,
      role: role == _roleAll ? null : role,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, state) {
            if (state is UsersLoadingState) {
              return CustomLoadingWidget(indicatorColor: ColorManger.brightPurple);
            }

            if (state is UsersErrorState) {
              return CustomErrorWidget(
                message: state.errorMessage,
                onRetry: () => context.read<UsersCubit>().getUsers(),
              );
            }

            if (state is UsersSuccessState) {
              final stats = state.usersModel.data?.stats;

              return SingleChildScrollView(
                controller: _scrollController,
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
                        onChanged: _onSearchChanged,
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
                          onRoleSelected: _onRoleSelected,
                        ),
                      ],

                      const SizedBox(height: 12),

                      _buildStatsRow(stats),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: UsersInfoCard(
                              icon: Icons.group,
                              label: appLocalization.totalUsers,
                              value: (stats?.totalUsers ?? 0).toString(),
                              iconColor: ColorManger.skyBlue,
                            ),
                          ),
                          Expanded(
                            child: UsersInfoCard(
                              icon: Icons.verified_outlined,
                              label: appLocalization.verified,
                              value: (stats?.verifiedUsers ?? 0).toString(),
                              iconColor: ColorManger.green,
                            ),
                          ),
                          Expanded(
                            child: UsersInfoCard(
                              icon: Icons.block_outlined,
                              label: appLocalization.pending,
                              value: (stats?.unverifiedUsers ?? 0).toString(),
                              iconColor: ColorManger.brightRed,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      _buildRecentUsersCard(appLocalization, state),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildRecentUsersCard(
      AppLocalizations appLocalization,
      UsersSuccessState state,
      ) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalization.recentUsers,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontWeight: FontWeightManager.semiBold,
                fontSize: FontSize.s16,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                CustomElevatedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: ColorManger.brightPurple,
                  foregroundColor: ColorManger.pureWhite,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AddAdminDialog();
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 16),
                      const SizedBox(width: 4),
                      CustomText(text: appLocalization.addAdmin),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                CustomElevatedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: ColorManger.green,
                  foregroundColor: ColorManger.pureWhite,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AddHospitalDialog();
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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

            _buildList(appLocalization, state),
          ],
        ),
      ),
    );
  }

  Widget _buildList(AppLocalizations appLocalization, UsersSuccessState state) {
    if (state.users.isEmpty) {
      return Center(child: CustomText(text: appLocalization.noUsersFound));
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.users.length + (state.isLoadingMore ? 1 : 0),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        if (i >= state.users.length) {
          return CustomLoadingWidget(
            indicatorColor: ColorManger.brightPurple,

          );
        }
        return UserCard(showMenu: true, user: state.users[i]);
      },
    );
  }

  Widget _buildStatsRow(Stats? stats) {
    final appLocalization = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          UserStatChip(
            label: appLocalization.total,
            count: stats?.totalUsers ?? 0,
            color: ColorManger.skyBlue,
          ),
          const SizedBox(width: 8),
          UserStatChip(
            label: appLocalization.donors,
            count: stats?.totalDonors ?? 0,
            color: ColorManger.brightRed,
          ),
          const SizedBox(width: 8),
          UserStatChip(
            label: appLocalization.hospitals,
            count: stats?.totalHospitals ?? 0,
            color: ColorManger.orange,
          ),
          const SizedBox(width: 8),
          UserStatChip(
            label: appLocalization.admins,
            count: stats?.totalAdmins ?? 0,
            color: ColorManger.brightPurple,
          ),
        ],
      ),
    );
  }
}