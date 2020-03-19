import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:video_player/video_player.dart';

class HomeTabView extends ModelBoundTabWidget<HomeTabViewModel> {
  HomeTabView(HomeTabViewModel viewModel) : super(viewModel, const TabData('Home', Icons.home, ViewNames.homeTabView));

  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends ModelBoundTabState<HomeTabView, HomeTabViewModel> {
  ChewieController _chewieController;
  VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  void onTabNavigatedFrom() {
    super.onTabNavigatedFrom();
    _pauseVideo();
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

              return ErrorWidget('Unhandled $snapshot state');
            },
          );
        },
      ),
    );
  }

  void _pauseVideo() {
    if (_chewieController != null && !_chewieController.isFullScreen) {
      _chewieController.pause();
    }
  }

  Widget _buildLoadingBody() {
    return ExtendedColumn(
      spacing: 8.0,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: const LoadingContainer(),
        ),
        GameCardSkeleton(),
      ],
    );
  }

  Widget _buildBody(GameEntity game) {
    _videoPlayerController ??=
        VideoPlayerController.asset('assets/1bl_video.mp4'); // TODO: Change this to [game.gameVideoUrl].
    _chewieController ??= ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: true,
      isLive: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    );

    return ExtendedColumn(
      spacing: 8.0,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Chewie(controller: _chewieController),
        ),
        GameCard(
          game,
          buttons: [
            GameCardButtonData(
              'SHARE',
              Icons.share,
              viewModel.shareLiveGame,
            )
          ],
        ),
      ],
    );
  }
}
