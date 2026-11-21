import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/save_it_theme.dart';

/// Every status in the app. Each one differs by fill, outline and icon,
/// so meaning never relies on colour alone.
enum SaveItStatus {
  // Orders
  reserved, collected, cancelled, expired,
  // Listings
  draft, live, soldOut, hidden,
  // Admin accounts
  active, warned, suspended, deactivated,
}

class _BadgeStyle {
  const _BadgeStyle(this.label, this.bg, this.fg, {this.border, this.dashed = false, this.icon, this.dot = false});
  final String label;
  final Color bg;
  final Color fg;
  final Color? border;
  final bool dashed;
  final IconData? icon;
  final bool dot;
}

const _styles = <SaveItStatus, _BadgeStyle>{
  SaveItStatus.reserved: _BadgeStyle('Reserved', SaveItColors.warningTint, SaveItColors.warning,
      border: SaveItColors.warning, icon: LucideIcons.clock),
  SaveItStatus.collected: _BadgeStyle('Collected', SaveItColors.success, Colors.white, icon: LucideIcons.check),
  SaveItStatus.cancelled: _BadgeStyle('Cancelled', SaveItColors.surface, SaveItColors.error,
      border: SaveItColors.error, icon: LucideIcons.x),
  SaveItStatus.expired: _BadgeStyle('Expired', SaveItColors.neutralTint, SaveItColors.neutral, icon: LucideIcons.hourglass),
  SaveItStatus.draft: _BadgeStyle('Draft', SaveItColors.surface, SaveItColors.neutral,
      border: SaveItColors.neutral, dashed: true, icon: LucideIcons.pencil),
  SaveItStatus.live: _BadgeStyle('Live', SaveItColors.successTint, SaveItColors.success,
      border: SaveItColors.success, dot: true),
  SaveItStatus.soldOut: _BadgeStyle('Sold out', SaveItColors.neutral, Colors.white, icon: LucideIcons.ban),
  SaveItStatus.hidden: _BadgeStyle('Hidden', SaveItColors.neutralTint, SaveItColors.neutral, icon: LucideIcons.eyeOff),
  SaveItStatus.active: _BadgeStyle('Active', SaveItColors.successTint, SaveItColors.success),
  SaveItStatus.warned: _BadgeStyle('Warned', SaveItColors.warningTint, SaveItColors.warning, icon: LucideIcons.triangleAlert),
  SaveItStatus.suspended: _BadgeStyle('Suspended', SaveItColors.error, Colors.white, icon: LucideIcons.lock),
  SaveItStatus.deactivated: _BadgeStyle('Deactivated', SaveItColors.neutralTint, SaveItColors.neutral),
};

/// Pill badge, 26 tall, 12/16 Bold caps with +6% tracking.
/// Pass [label] to use a localised string instead of the English default.
class StatusBadge extends StatelessWidget {
  const StatusBadge(this.status, {super.key, this.label});
  final SaveItStatus status;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final st = _styles[status]!;
    final content = Row(mainAxisSize: MainAxisSize.min, children: [
      if (st.dot)
        Container(width: 8, height: 8, decoration: BoxDecoration(color: st.fg, shape: BoxShape.circle)),
      if (st.icon != null) Icon(st.icon, size: 14, color: st.fg),
      if (st.dot || st.icon != null) const SizedBox(width: 5),
      Text((label ?? st.label).toUpperCase(), style: SaveItType.badge.copyWith(color: st.fg)),
    ]);
    final box = Container(
      constraints: const BoxConstraints(minHeight: SaveItSizes.badgeHeight),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: st.bg,
        borderRadius: BorderRadius.circular(SaveItRadius.full),
        border: st.border != null && !st.dashed ? Border.all(color: st.border!, width: 1.5) : null,
      ),
      child: content,
    );
    if (!st.dashed) return Semantics(label: label ?? st.label, child: ExcludeSemantics(child: box));
    return Semantics(
      label: label ?? st.label,
      child: ExcludeSemantics(child: CustomPaint(foregroundPainter: _DashedPill(st.border!), child: box)),
    );
  }
}

class _DashedPill extends CustomPainter {
  _DashedPill(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final r = RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(size.height / 2)).deflate(0.75);
    final path = Path()..addRRect(r);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (final m in path.computeMetrics()) {
      for (double d = 0; d < m.length; d += 6) {
        canvas.drawPath(m.extractPath(d, d + 3.5), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DashedPill old) => old.color != color;
}
