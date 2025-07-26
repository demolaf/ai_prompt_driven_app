import 'package:flutter/cupertino.dart';
import 'package:ai_prompt_driven_app/src/config/quick_action_config.dart';
import 'package:ai_prompt_driven_app/src/utils/widget_parser.dart';

class DynamicQuickActionGrid extends StatelessWidget {
  const DynamicQuickActionGrid({
    this.config,
    this.onActionTapped,
    super.key,
  });

  final QuickActionConfig? config;
  final Function(QuickActionItem action)? onActionTapped;

  @override
  Widget build(BuildContext context) {
    // Use config values or fallback to defaults
    final title = config?.title ?? 'Quick Actions';
    final titleFontSize = config?.titleFontSize ?? 18.0;
    final titleColor = config?.titleColor ?? CupertinoColors.label;
    final titleFontWeight = config?.titleFontWeight ?? FontWeight.w600;
    final spacing = config?.spacing ?? 12.0;
    final actions = config?.actions ?? QuickActionConfig.defaultActions;

    if (actions.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: titleFontWeight,
            color: titleColor,
          ),
        ),
        SizedBox(height: spacing),
        _buildActionLayout(actions),
      ],
    );
  }

  Widget _buildActionLayout(List<QuickActionItem> actions) {
    final layout = config?.layout ?? QuickActionLayout.grid;
    
    switch (layout) {
      case QuickActionLayout.grid:
        return _buildGridLayout(actions);
      case QuickActionLayout.list:
        return _buildListLayout(actions);
    }
  }

  Widget _buildGridLayout(List<QuickActionItem> actions) {
    final crossAxisCount = config?.crossAxisCount ?? 2;
    final crossAxisSpacing = config?.crossAxisSpacing ?? 12.0;
    final mainAxisSpacing = config?.mainAxisSpacing ?? 12.0;
    final childAspectRatio = config?.childAspectRatio ?? 3.0;

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        return _buildActionTile(actions[index], isGridLayout: true);
      },
    );
  }

  Widget _buildListLayout(List<QuickActionItem> actions) {
    final mainAxisSpacing = config?.mainAxisSpacing ?? 8.0;
    
    return Column(
      children: actions.asMap().entries.map((entry) {
        final isLast = entry.key == actions.length - 1;
        return Column(
          children: [
            _buildActionTile(entry.value, isGridLayout: false),
            if (!isLast) SizedBox(height: mainAxisSpacing),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildActionTile(QuickActionItem action, {required bool isGridLayout}) {
    final defaultBackgroundColor = CupertinoColors.systemBlue.withOpacity(0.1);
    final defaultColor = CupertinoColors.systemBlue;
    final defaultBorderColor = CupertinoColors.systemBlue.withOpacity(0.3);

    final backgroundColor = action.backgroundColor ?? defaultBackgroundColor;
    final iconColor = action.color ?? defaultColor;
    final textColor = action.color ?? CupertinoColors.label;

    return GestureDetector(
      onTap: () {
        action.onTap?.call();
        onActionTapped?.call(action);
      },
      child: Container(
        padding: EdgeInsets.all(isGridLayout ? 12 : 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: action.backgroundColor != null 
                ? (action.color ?? defaultBorderColor)
                : defaultBorderColor,
          ),
        ),
        child: Row(
          children: [
            Icon(
              WidgetParser.parseIcon(action.icon),
              size: isGridLayout ? 20 : 24,
              color: iconColor,
            ),
            SizedBox(width: isGridLayout ? 8 : 12),
            Expanded(
              child: Text(
                action.title,
                style: TextStyle(
                  fontSize: isGridLayout ? 14 : 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (!isGridLayout) ...[
              SizedBox(width: 8),
              Icon(
                CupertinoIcons.chevron_right,
                size: 16,
                color: CupertinoColors.systemGrey2,
              ),
            ],
          ],
        ),
      ),
    );
  }
}