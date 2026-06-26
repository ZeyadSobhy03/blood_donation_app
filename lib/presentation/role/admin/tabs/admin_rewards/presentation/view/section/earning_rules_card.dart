import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/earning_rule_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/add_earning_rule_dialog.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view_model/admin_rewards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class EarningRulesCard extends StatefulWidget {
  const EarningRulesCard({super.key, required this.rules});

  final List<Data> rules;

  @override
  State<EarningRulesCard> createState() => _EarningRulesCardState();
}

class _EarningRulesCardState extends State<EarningRulesCard> {
  final Map<String, TextEditingController> _controllers = {};
  final Set<String> _editingIds = {};

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  TextEditingController _controllerFor(Data rule) {
    final id = rule.id ?? '';
    return _controllers.putIfAbsent(
      id,
      () => TextEditingController(text: (rule.points ?? 0).toString()),
    );
  }

  void _startEdit(String id) => setState(() => _editingIds.add(id));

  void _cancelEdit(String id, Data rule) {
    final id0 = rule.id ?? '';
    _controllers[id0]?.text = (rule.points ?? 0).toString();
    setState(() => _editingIds.remove(id));
  }

  void _saveEdit(String id) {
    final controller = _controllers[id];
    final parsed = int.tryParse(controller?.text ?? '');
    if (parsed == null) return;
    context.read<AdminRewardsCubit>().updateEarningRule(id: id, points: parsed);
    setState(() => _editingIds.remove(id));
  }

  void _deleteRule(String id, AppLocalizations loc) {
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorManger.pureWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: CustomText(
          text: loc.deleteEarningRuleTitle,
          textStyle: TextStyle(
            color: ColorManger.black,
            fontSize: FontSize.s16,
            fontWeight: FontWeightManager.bold,
          ),
        ),
        content: CustomText(
          text: loc.deleteEarningRuleConfirmation,
          textStyle: TextStyle(
            color: ColorManger.slateGrey,
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(loc.cancel,
                style: TextStyle(color: ColorManger.slateGrey)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(loc.delete,
                style: TextStyle(
                    color: ColorManger.brightRed,
                    fontWeight: FontWeightManager.bold)),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true) {
        context.read<AdminRewardsCubit>().deleteEarningRule(id: id);
      }
    });
  }

  Future<void> _openAddDialog() async {
    final result = await showDialog<NewEarningRuleResult>(
      context: context,
      builder: (_) => const AddEarningRuleDialog(),
    );
    if (result == null || !mounted) return;
    context.read<AdminRewardsCubit>().createEarningRule(
          type: result.type,
          title: result.title,
          points: result.points,
          category: result.category,
          isActive: result.isActive,
        );
  }

  IconData _categoryIcon(String? category) {
    switch (category?.toLowerCase()) {
      case 'donation':
        return Icons.bloodtype;
      case 'referral':
        return Icons.people_alt_outlined;
      case 'registration':
        return Icons.how_to_reg_outlined;
      case 'other':
        return Icons.star_outline;
      default:
        return Icons.emoji_events_outlined;
    }
  }

  Color _categoryColor(String? category) {
    switch (category?.toLowerCase()) {
      case 'donation':
        return ColorManger.brightRed;
      case 'referral':
        return ColorManger.royalBlue;
      case 'registration':
        return ColorManger.green;
      case 'other':
        return ColorManger.brightPurple;
      default:
        return ColorManger.brightPurple;
    }
  }

  Color _categoryBgColor(String? category) {
    switch (category?.toLowerCase()) {
      case 'donation':
        return ColorManger.softRed;
      case 'referral':
        return ColorManger.lightBlue;
      case 'registration':
        return ColorManger.lightGreen;
      case 'other':
        return ColorManger.lightPurple;
      default:
        return ColorManger.lightPurple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocListener<AdminRewardsCubit, AdminRewardsState>(
      listener: (context, state) {
        if (state is EarningRuleCreateSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(loc.operationSuccessful),
              backgroundColor: ColorManger.successColor,
            ),
          );
          context.read<AdminRewardsCubit>().getEarningRules();
        } else if (state is EarningRuleDeletedSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(loc.operationSuccessful),
              backgroundColor: ColorManger.successColor,
            ),
          );
          context.read<AdminRewardsCubit>().getEarningRules();
        } else if (state is EarningRuleUpdatedSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(loc.updateSuccess),
              backgroundColor: ColorManger.successColor,
            ),
          );
          context.read<AdminRewardsCubit>().getEarningRules();
        } else if (state is AdminRewardsErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(localizeError(state.error, loc)),
              backgroundColor: ColorManger.brightRed,
            ),
          );
        }
      },
      child: Card(
        color: ColorManger.pureWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: ColorManger.lightPurple.withValues(alpha: 0.9),
            width: 1.2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: loc.earningRulesTitle,
                          textStyle: TextStyle(
                            color: ColorManger.black,
                            fontSize: FontSize.s18,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        CustomText(
                          text: loc.earningRulesSubtitle,
                          textStyle: TextStyle(
                            color: ColorManger.slateGrey,
                            fontSize: FontSize.s13,
                            fontWeight: FontWeightManager.regular,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  CustomElevatedButton(
                    backgroundColor: ColorManger.brightPurple,
                    foregroundColor: ColorManger.pureWhite,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: _openAddDialog,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add, size: 16,
                            color: ColorManger.pureWhite),
                        const SizedBox(width: 6),
                        CustomText(
                          text: loc.addRule,
                          textStyle: TextStyle(
                            color: ColorManger.pureWhite,
                            fontSize: FontSize.s13,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),


              _StatsRow(rules: widget.rules, loc: loc),
              const SizedBox(height: 16),

              // ─── Rules list ────────────────────────────────────────────
              if (widget.rules.isEmpty)
                _EmptyState(loc: loc)
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.rules.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: ColorManger.lightPurple.withValues(alpha: 0.6),
                  ),
                  itemBuilder: (context, index) {
                    final rule = widget.rules[index];
                    final id = rule.id ?? '';
                    final isEditing = _editingIds.contains(id);
                    final controller = _controllerFor(rule);

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: _EarningRuleTile(
                        rule: rule,
                        isEditing: isEditing,
                        pointsController: controller,
                        categoryIcon: _categoryIcon(rule.category),
                        categoryColor: _categoryColor(rule.category),
                        categoryBgColor: _categoryBgColor(rule.category),
                        onEdit: () => _startEdit(id),
                        onCancelEdit: () => _cancelEdit(id, rule),
                        onSaveEdit: () => _saveEdit(id),
                        onDelete: () => _deleteRule(id, loc),
                        loc: loc,
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Stats Row
// ──────────────────────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.rules, required this.loc});
  final List<Data> rules;
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final active = rules.where((r) => r.isActive == true).length;
    final inactive = rules.length - active;

    return Row(
      children: [
        _StatChip(
          label: loc.totalRules,
          value: '${rules.length}',
          color: ColorManger.brightPurple,
          bgColor: ColorManger.lightPurple,
          icon: Icons.list_alt_outlined,
        ),
        const SizedBox(width: 8),
        _StatChip(
          label: loc.activeRules,
          value: '$active',
          color: ColorManger.successColor,
          bgColor: ColorManger.successBackground,
          icon: Icons.check_circle_outline,
        ),
        const SizedBox(width: 8),
        _StatChip(
          label: loc.inactiveRules,
          value: '$inactive',
          color: ColorManger.slateGrey,
          bgColor: ColorManger.lightGrey,
          icon: Icons.cancel_outlined,
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
    required this.bgColor,
    required this.icon,
  });

  final String label;
  final String value;
  final Color color;
  final Color bgColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      color: color,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      color: color.withValues(alpha: 0.8),
                      fontSize: FontSize.s10,
                      fontWeight: FontWeightManager.regular,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Empty State
// ──────────────────────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.loc});
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorManger.lightPurple,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.emoji_events_outlined,
              color: ColorManger.brightPurple,
              size: 36,
            ),
          ),
          const SizedBox(height: 12),
          CustomText(
            text: loc.noEarningRules,
            textStyle: TextStyle(
              color: ColorManger.black,
              fontSize: FontSize.s15,
              fontWeight: FontWeightManager.semiBold,
            ),
          ),
          const SizedBox(height: 6),
          CustomText(
            text: loc.noEarningRulesSubtitle,
            textStyle: TextStyle(
              color: ColorManger.slateGrey,
              fontSize: FontSize.s13,
              fontWeight: FontWeightManager.regular,
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Individual Rule Tile
// ──────────────────────────────────────────────────────────────────────────────

class _EarningRuleTile extends StatelessWidget {
  const _EarningRuleTile({
    required this.rule,
    required this.isEditing,
    required this.pointsController,
    required this.categoryIcon,
    required this.categoryColor,
    required this.categoryBgColor,
    required this.onEdit,
    required this.onCancelEdit,
    required this.onSaveEdit,
    required this.onDelete,
    required this.loc,
  });

  final Data rule;
  final bool isEditing;
  final TextEditingController pointsController;
  final IconData categoryIcon;
  final Color categoryColor;
  final Color categoryBgColor;
  final VoidCallback onEdit;
  final VoidCallback onCancelEdit;
  final VoidCallback onSaveEdit;
  final VoidCallback onDelete;
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final isActive = rule.isActive ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Category icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: categoryBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(categoryIcon, color: categoryColor, size: 20),
            ),
            const SizedBox(width: 12),

            // Title / type / status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: rule.title ?? '',
                          textStyle: TextStyle(
                            color: ColorManger.black,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ),
                      // Active badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: isActive
                              ? ColorManger.successBackground
                              : ColorManger.lightGrey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isActive ? loc.active : loc.inactive,
                          style: TextStyle(
                            color: isActive
                                ? ColorManger.successColor
                                : ColorManger.slateGrey,
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${loc.type}: ${rule.type ?? ''}  •  ${loc.earningRuleCategory}: ${rule.category ?? ''}',
                    style: TextStyle(
                      color: ColorManger.slateGrey,
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Points display / edit field
            if (isEditing)
              SizedBox(
                width: 84,
                height: 38,
                child: TextField(
                  controller: pointsController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorManger.black,
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.medium,
                  ),
                  decoration: InputDecoration(
                    suffixText: 'pts',
                    suffixStyle: TextStyle(
                      color: ColorManger.slateGrey,
                      fontSize: FontSize.s12,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color:
                              ColorManger.lightPurple.withValues(alpha: 0.8)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color:
                              ColorManger.lightPurple.withValues(alpha: 0.8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: ColorManger.brightPurple, width: 1.5),
                    ),
                  ),
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${rule.points ?? 0}',
                    style: TextStyle(
                      color: ColorManger.brightPurple,
                      fontSize: FontSize.s16,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                  Text(
                    loc.points,
                    style: TextStyle(
                      color: ColorManger.slateGrey,
                      fontSize: FontSize.s10,
                    ),
                  ),
                ],
              ),
          ],
        ),

        // ── Action buttons row ──────────────────────────────────────────
        const SizedBox(height: 10),
        if (isEditing)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _ActionButton(
                label: loc.cancel,
                icon: Icons.close,
                color: ColorManger.slateGrey,
                bgColor: ColorManger.lightGrey,
                onTap: onCancelEdit,
              ),
              const SizedBox(width: 8),
              _ActionButton(
                label: loc.save,
                icon: Icons.check,
                color: ColorManger.successColor,
                bgColor: ColorManger.successBackground,
                onTap: onSaveEdit,
              ),
            ],
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _ActionButton(
                label: loc.editPoints,
                icon: Icons.edit_outlined,
                color: ColorManger.brightPurple,
                bgColor: ColorManger.lightPurple,
                onTap: onEdit,
              ),
              const SizedBox(width: 8),
              _ActionButton(
                label: loc.delete,
                icon: Icons.delete_outline,
                color: ColorManger.brightRed,
                bgColor: ColorManger.softRed,
                onTap: onDelete,
              ),
            ],
          ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
