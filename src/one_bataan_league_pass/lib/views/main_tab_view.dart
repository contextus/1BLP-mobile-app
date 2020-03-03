import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_common/logging.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class MainTabView extends ModelBoundWidget<MainTabViewModel> {
  MainTabView(MainTabViewModel viewModel, this.tabs) : super(viewModel);

  final List<ModelBoundTabWidget> tabs;

  @override
  _MainTabViewState createState() => _MainTabViewState();
}

class _MainTabViewState extends ModelBoundState<MainTabView, MainTabViewModel> {
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: viewModel.currentPageIndex);
    viewModel.addOnModelChanged(_onViewModelChanged);
  }

  @override
  Widget build(BuildContext context) {
    final primaryColorGreen = Color.fromARGB(255, 130, 203, 4);
    final primaryColorBlue = Color.fromARGB(255, 2, 122, 224);
    final primaryColorRed = Color.fromARGB(255, 223, 54, 2);

    return ScopedModel<MainTabViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<MainTabViewModel>(
        builder: (context, child, viewModel) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '1', style: TextStyle(color: primaryColorBlue)),
                    TextSpan(text: 'Bataan ', style: TextStyle(color: primaryColorGreen)),
                    TextSpan(text: 'League', style: TextStyle(color: primaryColorRed)),
                  ],
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.account_circle), onPressed: viewModel.onOpenAccount),
              ],
            ),
            body: Stack(
              children: <Widget>[
                PageView.builder(
                  pageSnapping: false,
                  controller: _controller,
                  itemBuilder: (context, index) => widget.tabs.elementAt(index),
                  onPageChanged: (i) => viewModel.currentPageIndex = i,
                  itemCount: widget.tabs.length,
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
            tabs: widget.tabs.map(_buildBottomNavigationBarButton).toList(),
            onTabChange: (i) => viewModel.currentPageIndex = i,
          ),
        ),
      ),
    );
  }

  GButton _buildBottomNavigationBarButton(ModelBoundTabWidget tab) {
    final currentTheme = Theme.of(context);
    Color selectionColor;
    Color activeColor;
    Color inactiveColor;

    switch (currentTheme.brightness) {
      case Brightness.dark:
        throw UnimplementedError('Dark theme not yet handled.');

      case Brightness.light:
        selectionColor = Colors.white;
        activeColor = Color.fromARGB(255, 81, 81, 84);
        inactiveColor = Color.fromARGB(155, 156, 156, 158);
        break;
    }

    return GButton(
      iconSize: 24,
      gap: 30.0,
      textStyle: currentTheme.textTheme.caption.apply(color: activeColor),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      icon: tab.icon,
      color: selectionColor,
      text: tab.text,
      textColor: activeColor,
      iconColor: inactiveColor,
      iconActiveColor: activeColor,
    );
  }

  void _onViewModelChanged(String propertyName) {
    _controller.jumpToPage(
      viewModel.currentPageIndex,
    );
    widget.tabs[viewModel.currentPageIndex].viewModel.init(); // TODO: Add Navigation init for tab view models
    debugInfo('Switched to tab: ${widget.tabs[viewModel.currentPageIndex].text}');
  }
}
