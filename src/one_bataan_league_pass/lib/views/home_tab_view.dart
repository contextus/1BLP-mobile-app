import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:video_player/video_player.dart';

class HomeTabView extends ModelBoundTabWidget<HomeTabViewModel> {
  HomeTabView(HomeTabViewModel viewModel, String tabViewName)
      : super(viewModel, tabButtonText: 'Home', tabButtonIcon: Icons.home, tabViewName: tabViewName);

  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends ModelBoundState<HomeTabView, HomeTabViewModel>
    with AutomaticKeepAliveClientMixin<HomeTabView> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  Chewie _player;

  @override
  void initState() {
    super.initState();

    viewModel.addOnTabUnselected(pauseVideo);
    viewModel.addOnNavigatedFrom(pauseVideo);
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  void pauseVideo() {
    _chewieController?.pause();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ScopedModel<HomeTabViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<HomeTabViewModel>(
        builder: (context, child, viewModel) {
          return FutureBuilder<GameEntity>(
            future: viewModel.getLiveGame,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildLoadingBody();
              } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
                return _buildBody(snapshot.data);
              } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
                return Expanded(
                  child: Center(
                    child: Text('Could not retrieve the current live game.'),
                  ),
                );
              }

              throw UnimplementedError('Unhandled $snapshot state');
            },
          );
        },
      ),
    );
  }

  Widget _buildLoadingBody() {
    return ExtendedColumn(
      spacing: 8.0,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: LoadingContainer(),
        ),
        GameCardSkeleton(),
      ],
    );
  }

  Widget _buildBody(GameEntity game) {
    return ExtendedColumn(
      spacing: 8.0,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: _player ??= Chewie(
            controller: _chewieController ??= ChewieController(
              videoPlayerController: _videoPlayerController ??=
                  VideoPlayerController.asset('assets/1bl_video.mp4'), // TODO: Change this to [game.gameVideoUrl].
              aspectRatio: 16 / 9,
              autoInitialize: true,
              autoPlay: true,
              isLive: true,
            ),
          ),
        ),
        GameCard(
          game: game,
          actions: [
            GameCardAction(
              'SHARE',
              icon: Icons.share,
              action: viewModel.shareLiveGame,
            )
          ],
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
