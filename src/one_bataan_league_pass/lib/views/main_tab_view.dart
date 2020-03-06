import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:one_bataan_league_pass/keys/keys.dart';
import 'package:one_bataan_league_pass/resources/resources.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_common/logging.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class MainTabView extends ModelBoundWidget<MainTabViewModel> {
  MainTabView(MainTabViewModel viewModel, this.tabs) : super(viewModel, key: MainTabViewKeys.tabNavigator);

  final List<ModelBoundTabWidget> tabs;

  @override
  MainTabViewState createState() => MainTabViewState();
}

class MainTabViewState extends ModelBoundState<MainTabView, MainTabViewModel> {
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: viewModel.currentTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainTabViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<MainTabViewModel>(
        builder: (context, child, viewModel) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: OneBataanLeagueText(),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: viewModel.onViewUserProfile,
                  tooltip: 'View your profile',
                ),
              ],
            ),
            body: Stack(
              children: <Widget>[
                PageView.builder(
                  controller: _controller,
                  itemBuilder: (context, index) => widget.tabs.elementAt(index),
                  onPageChanged: _onNavigateToTab,
                  itemCount: widget.tabs.length,
                ),
                Align(alignment: Alignment.bottomCenter, child: _buildBottomNavigationBar()),
              ],
            ),
          );
        },
      ),
    );
  }

  void navigateToTab(String tabViewName, [Map<String, Object> parameters]) {
    final index = widget.tabs.indexWhere((t) => t.tabViewName == tabViewName);
    _onNavigateToTab(index, parameters);
  }

  Widget _buildBottomNavigationBar({bool floating = false}) {
    return AnimatedContainer(
      transform: Matrix4.translation(Vector3(0, 0, 0)),
      margin: EdgeInsets.all(floating ? 8.0 : 0.0),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(floating ? 100 : 0)),
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GNav(
            selectedIndex: viewModel.currentTabIndex,
            tabs: widget.tabs.map(_buildBottomNavigationBarButton).toList(),
            onTabChange: _onNavigateToTab,
          ),
        ),
      ),
    );
  }

  GButton _buildBottomNavigationBarButton(ModelBoundTabWidget tab) {
    final customTheme = Theme.of(context).customTheme();

    return GButton(
      iconSize: 24,
      gap: 32.0,
      textStyle: Theme.of(context).textTheme.caption.apply(color: customTheme.activeIconColor),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      icon: tab.tabButtonIcon,
      color: Colors.transparent,
      text: tab.tabButtonText,
      textColor: customTheme.activeIconColor,
      iconColor: customTheme.inactiveIconColor,
      iconActiveColor: customTheme.activeIconColor,
    );
  }

  void _onNavigateToTab(int tabIndex, [Map<String, Object> parameters]) {
    if (viewModel.currentTabIndex != tabIndex) {
      setState(() => viewModel.currentTabIndex = tabIndex);
      _controller.jumpToPage(tabIndex);
      widget.tabs[tabIndex].viewModel.onTabSelected(parameters);
      debugInfo('Switched to tab: ${widget.tabs[tabIndex].tabButtonText}');
    }
  }
}
