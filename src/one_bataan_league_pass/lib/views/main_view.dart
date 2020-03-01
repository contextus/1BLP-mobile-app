import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_common/logging.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class MainView extends ModelBoundWidget<MainViewModel> {
  MainView(MainViewModel viewModel) : super(viewModel);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends ModelBoundState<MainView, MainViewModel> {
  PageController _controller;
  List<TabView> _tabs;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: viewModel.currentPageIndex);
    _tabs = [
      HomeView(viewModel.homeViewModel, 'Home', Icons.home),
      HomeView(viewModel.homeViewModel, 'Games', Icons.play_circle_filled),
      HomeView(viewModel.homeViewModel, 'Standings', Icons.insert_chart),
      HomeView(viewModel.homeViewModel, 'More', Icons.more_horiz),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<MainViewModel>(
        builder: (context, child, viewModel) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('1Bataan League', style: TextStyle(fontSize: 14)),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.account_circle), onPressed: viewModel.onOpenAccount),
              ],
            ),
            body: Stack(
              children: <Widget>[
                PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _controller,
                  itemBuilder: (context, index) => _tabs.elementAt(index),
                  itemCount: _tabs.length,
                ),
                Align(alignment: Alignment.bottomCenter, child: _buildBottomNavigationBar(floating: false)),
              ],
            ),
          );
        },
      ),
    );
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
            selectedIndex: viewModel.currentPageIndex,
            tabs: _tabs.map(_buildBottomNavigationBarButton).toList(),
            onTabChange: (i) {
              viewModel.currentPageIndex = i;
              _controller.animateToPage(
                viewModel.currentPageIndex,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
              debugInfo('Switched to ${_tabs[viewModel.currentPageIndex].text}');
            },
          ),
        ),
      ),
    );
  }

  GButton _buildBottomNavigationBarButton(TabView tab) {
    const padding = EdgeInsets.symmetric(horizontal: 12, vertical: 4);
    const gap = 30.0;
    const selectionColor = Colors.black54;
    const activeColor = Colors.white;
    const inactiveColor = Colors.white24;

    return GButton(
      gap: gap,
      padding: padding,
      icon: tab.icon,
      color: selectionColor,
      text: tab.text,
      textColor: activeColor,
      iconColor: inactiveColor,
      iconActiveColor: activeColor,
    );
  }
}

abstract class TabView<TViewModel extends ViewModelBase> extends ModelBoundWidget<TViewModel> {
  TabView(TViewModel viewModel, this.text, this.icon, {Key key}) : super(viewModel, key: key);

  final String text;
  final IconData icon;
}

class HomeView extends TabView<HomeViewModel> {
  HomeView(HomeViewModel viewModel, String text, IconData icon) : super(viewModel, text, icon);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ModelBoundState<HomeView, HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomeViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<HomeViewModel>(
        builder: (context, child, viewModel) {
          return Container(
            child: Center(child: Text(widget.text)),
          );
        },
      ),
    );
  }
}
