import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/save_it_theme.dart';

/// Food categories (BR-11), in the order shown in the app.
enum FoodCategory { salads, savouryDishes, sweetTreats, beverages, snacks, bakery, kidsMenu }

const _categoryIcon = <FoodCategory, IconData>{
  FoodCategory.salads: LucideIcons.salad,
  FoodCategory.savouryDishes: LucideIcons.cookingPot,
  FoodCategory.sweetTreats: LucideIcons.cakeSlice,
  FoodCategory.beverages: LucideIcons.cupSoda,
  FoodCategory.snacks: LucideIcons.popcorn,
  FoodCategory.bakery: LucideIcons.wheat,
  FoodCategory.kidsMenu: LucideIcons.apple,
};

/// No-photo default: category icon on the vine tint, with the category name.
/// Shown wherever an item has no photo (C-08, C-09, C-11, B-05).
class CategoryDefaultImage extends StatelessWidget {
  const CategoryDefaultImage({super.key, required this.category, required this.label, this.size = SaveItSizes.thumb});
  final FoodCategory category;
  final String label; // localised category name
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(color: SaveItColors.primaryContainer, borderRadius: SaveItRadius.thumbAll),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(_categoryIcon[category], size: size * 0.38, color: SaveItColors.primaryText),
        const SizedBox(height: 4),
        Text(label,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: SaveItType.caption.copyWith(
                fontSize: 11, height: 13 / 11, fontWeight: FontWeight.w700, color: SaveItColors.onPrimaryContainer)),
      ]),
    );
  }
}

/// Restaurant monogram circle: fallback when a restaurant has no logo.
/// Tints rotate through neutral, amber, green and vine; terracotta stays for prices.
class RestaurantMonogram extends StatelessWidget {
  const RestaurantMonogram({super.key, required this.name, this.size = SaveItSizes.monogram, this.ring = true});
  final String name;
  final double size;
  final bool ring; // 3 px white ring when it overlaps a photo

  static const _tints = <(Color, Color)>[
    (SaveItColors.primaryContainer, SaveItColors.onPrimaryContainer),
    (SaveItColors.warningTint, SaveItColors.warning),
    (SaveItColors.neutralTint, SaveItColors.neutral),
    (SaveItColors.successTint, SaveItColors.success),
  ];

  String get _initials {
    final words = name.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return '';
    if (words.length == 1) return words.first.substring(0, 1).toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final t = _tints[name.hashCode.abs() % _tints.length];
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: t.$1,
        shape: BoxShape.circle,
        border: ring ? Border.all(color: Colors.white, width: 3) : null,
      ),
      child: Text(_initials,
          style: SaveItType.label.copyWith(fontSize: size * 0.36, fontWeight: FontWeight.w700, color: t.$2)),
    );
  }
}

/// Dark Business mode header: BUSINESS MODE badge, restaurant name or screen
/// title, optional back button and account button. Sits under the status bar.
class BusinessHeader extends StatelessWidget implements PreferredSizeWidget {
  const BusinessHeader({super.key, required this.title, this.badgeLabel = 'BUSINESS MODE', this.onBack, this.onAccount});
  final String title;
  final String badgeLabel;
  final VoidCallback? onBack;
  final VoidCallback? onAccount;

  @override
  Size get preferredSize => const Size.fromHeight(78);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SaveItColors.dark,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 6, 16, 14),
          child: Row(children: [
            if (onBack != null)
              IconButton(
                onPressed: onBack,
                icon: const Icon(LucideIcons.chevronLeft, color: Colors.white),
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              ),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                Container(
                  height: 22,
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  decoration: BoxDecoration(
                      color: SaveItColors.businessBadge, borderRadius: BorderRadius.circular(SaveItRadius.full)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(LucideIcons.store, size: 13, color: SaveItColors.textPrimary),
                    const SizedBox(width: 6),
                    Text(badgeLabel, style: SaveItType.badge.copyWith(fontSize: 11, height: 14 / 11)),
                  ]),
                ),
                const SizedBox(height: 4),
                Text(title, style: SaveItType.headline.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
              ]),
            ),
            if (onAccount != null)
              IconButton(
                onPressed: onAccount,
                icon: const Icon(LucideIcons.circleUser, color: Colors.white),
                style: IconButton.styleFrom(side: const BorderSide(color: Color(0x59FFFFFF))),
              ),
          ]),
        ),
      ),
    );
  }
}

/// Surface card with the e1 shadow and radius 20.
class SaveItCard extends StatelessWidget {
  const SaveItCard({super.key, required this.child, this.padding = const EdgeInsets.all(SaveItSpace.md)});
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        decoration: const BoxDecoration(
            color: SaveItColors.surface, borderRadius: SaveItRadius.cardAll, boxShadow: SaveItShadows.e1),
        child: child,
      );
}
