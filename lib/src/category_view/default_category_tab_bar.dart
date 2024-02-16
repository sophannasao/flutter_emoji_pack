import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

/// Default category tab bar
class DefaultCategoryTabBar extends StatefulWidget {
  /// Constructor
  const DefaultCategoryTabBar(
    this.config,
    this.tabController,
    this.pageController,
    this.categoryEmojis,
    this.closeSkinToneOverlay, {
    Key? key,
  }) : super(key: key);

  /// Config
  final Config config;

  /// Tab controller
  final TabController tabController;

  /// Page controller
  final PageController pageController;

  /// Category emojis
  final List<CategoryEmoji> categoryEmojis;

  /// Close skin tone overlay callback
  final VoidCallback closeSkinToneOverlay;

  @override
  State<DefaultCategoryTabBar> createState() => _DefaultCategoryTabBarState();
}

class _DefaultCategoryTabBarState extends State<DefaultCategoryTabBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.config.categoryViewConfig.tabBarHeight,
      child: TabBar(
        labelColor: widget.config.categoryViewConfig.iconColorSelected,
        unselectedLabelColor: widget.config.categoryViewConfig.iconColor,
        // dividerColor: widget.config.categoryViewConfig.dividerColor,
        controller: widget.tabController,
        labelPadding: EdgeInsets.zero,
        onTap: (index) {
          widget.closeSkinToneOverlay();
          widget.pageController.jumpToPage(index);
          setState(() {});
        },

        indicator: BoxDecoration(
          color: const Color(0xFF7F96DA).withOpacity(0.2),
          borderRadius: BorderRadius.circular(100),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        padding: const EdgeInsets.all(5),
        dividerHeight: 0,
        tabs: widget.categoryEmojis
            .asMap()
            .entries
            .map<Widget>(
                (item) => _buildCategoryTab(item.key, item.value.category))
            .toList(),
      ),
    );
  }

  Widget _buildCategoryTab(int index, Category category) {
    return Tab(
      icon: Icon(
        getIconForCategory(
            widget.config.categoryViewConfig.categoryIcons, category),
        color: index == widget.tabController.index
            ? const Color(0xFF7F96DA)
            : null,
      ),
    );
  }
}
