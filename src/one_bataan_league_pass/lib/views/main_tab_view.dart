import 'dart:async';
import 'package:arch/arch.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:one_bataan_league_pass/keys/keys.dart';
import 'package:one_bataan_league_pass/resources/resources.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/views/views.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_common/logging.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class MainTabView extends StatefulWidget {
  MainTabView() : super(key: MainTabViewKeys.tabNavigator);

  @override
  MainTabViewState createState() => MainTabViewState();
}

class MainTabViewState extends ViewStateBase<MainTabView, MainTabViewModel> with RouteAware {
  PageController _controller;
  List<TabView> _tabs;

  @override
  void didInitViewModel() {
    _tabs = [
      HomeTabView(),
      GamesTabView(),
      StandingsTabView(),
      PlayersTabView(),
      TeamsTabView(),
    ];
    _controller = PageController(initialPage: viewModel.currentTabIndex);
  }

  @override
  void dispose() {
    AppView.routeObserver.unsubscribe(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppView.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPushNext() => _navigatedFrom();

  @override
  void didPush() => _navigateTo();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: OneBataanSportsText(),
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
          Padding(
            padding: const EdgeInsets.only(bottom: 56),
            child: PageView.builder(
              controller: _controller,
              itemBuilder: (context, index) => _tabs.elementAt(index),
              onPageChanged: _onNavigateToTab,
              itemCount: _tabs.length,
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: _buildBottomNavigationBar()),
        ],
      ),
    );
  }

  void navigateToTab(String tabViewName, [Map<String, Object> parameters]) {
    final index = _tabs.indexWhere((t) => t.tabData.tabViewName == tabViewName);
    _onNavigateToTab(index, parameters);
  }

  Widget _buildBottomNavigationBar({bool floating = false}) {
    return AnimatedContainer(
      height: 56,
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
            tabs: _tabs.map(_buildBottomNavigationBarButton).toList(),
            onTabChange: _onNavigateToTab,
          ),
        ),
      ),
    );
  }

  GButton _buildBottomNavigationBarButton(TabView tab) {
    final customTheme = Theme.of(context).customTheme();

    return GButton(
      iconSize: 24,
      gap: 32.0,
      textStyle: Theme.of(context).textTheme.caption.apply(color: customTheme.activeIconColor),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      icon: tab.tabData.tabButtonIcon,
      color: Colors.transparent,
      text: tab.tabData.tabButtonText,
      textColor: customTheme.activeIconColor,
      iconColor: customTheme.inactiveIconColor,
      iconActiveColor: customTheme.activeIconColor,
    );
  }

  void _navigatedFrom() {
    GlobalKey<TabViewStateBase> currenTabKey = _tabs?.elementAt(viewModel.currentTabIndex)?.key;
    currenTabKey?.currentState?.onTabNavigatedFrom();
  }

  void _navigateTo() {
    GlobalKey<TabViewStateBase> currenTabKey = _tabs?.elementAt(viewModel.currentTabIndex)?.key;
    currenTabKey?.currentState?.onTabNavigatedTo();
  }

  void _onNavigateToTab(int tabIndex, [Map<String, Object> parameters]) {
    if (viewModel.currentTabIndex != tabIndex) {
      GlobalKey<TabViewStateBase> currentTabKey = _tabs[viewModel.currentTabIndex].key;
      currentTabKey.currentState.onTabNavigatedFrom();

      setState(() => viewModel.currentTabIndex = tabIndex);

      _controller.jumpToPage(tabIndex);

      // When navigating to tab for the first time, this ensures that
      // the tab's state is created before interacting with it
      Future<void>.delayed(Duration(milliseconds: 100)).then((_) {
        GlobalKey<TabViewStateBase> nextTabKey = _tabs[viewModel.currentTabIndex].key;
        nextTabKey.currentState.onTabNavigatedTo(parameters);
      });

      debugInfo('Switched to tab: ${_tabs[tabIndex].tabData.tabButtonText}');
    }
  }
}
