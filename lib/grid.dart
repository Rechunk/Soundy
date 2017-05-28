import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';
import "config.dart";
import "soundManager.dart";

class PlayRoute<T> extends MaterialPageRoute<T> {
  PlayRoute({
    WidgetBuilder builder,
  }): super(builder: builder);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child)
  {
    if (settings.isInitialRoute)
      return child;

    return new SlideTransition(
      position: new FractionalOffsetTween(
        begin: FractionalOffset.topRight,
        end: FractionalOffset.topLeft,
      )
      .animate(
        new CurvedAnimation(
          parent: animation,
          curve: Curves.ease,
        )
      ),
      child: child,
    );
  }

  @override Duration get transitionDuration => const Duration(milliseconds: 400);
}

class Grid extends StatefulWidget {
  @override
  _Grid createState() => new _Grid();
}

enum PlayerState { stopped, playing, paused }

AudioPlayer audioPlayer;
Duration duration;
Duration position;

class _Grid extends State<Grid> {

  List<Color> colors = new List.generate(64, (i) => normalColor);

  void toggleColor(int index){
    if (colors[index] == normalColor)
      colors[index] = selectedColor;
    else
     colors[index] = normalColor;
  }

  Widget buildTile(int counter) {
    return new GestureDetector(
      onTap: (){
        setState((){
          toggleColor(counter);
        });
      },
      child: new Container(
        color: colors[counter],
        foregroundDecoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(0.0)),
          border: new Border(),
        ),
        width: 75.0,
        height: 75.0,
        margin: new EdgeInsets.all(2.0),
      )
    );
  }

  List<Widget> buildGrid(){
    Map dimensions = {"width" : 4, "height" : 6};
    List<Widget> grid = new List<Widget>(dimensions["height"]);
    List<Widget> tiles = [];

    int counter = 0;

    for (int i = 0; i < dimensions["height"]; i++){
      tiles = [];
      for (int j = 0; j < dimensions["width"]; j++){
        tiles.add(buildTile(counter));
        counter++;
      }
      grid[i] = new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: tiles,
      );
    }
    return grid;
  }

  List<Widget> copyElements(List<Widget> from){
    List<Widget> to = [];
    for (int i = 0; i < from.length; i++){
      to.add(from[i]);
    }
    return to;
  }

  List<Widget> buildPlayground(List<Widget> grid){
    List<Widget> playground = [];

    playground = copyElements(grid);

    playground.add(new Padding(
      padding: new EdgeInsets.all(20.0),
      child: new RaisedButton(
        child: new Text("Done", style: new TextStyle(fontSize: 20.0)),
        onPressed: (){
          // TRYING TO NAVIGATE TO SOUND VIEW HERE
          Navigator.push(context, new SoundRoute(
            builder: (_) => new AudioApp()
          ));
        }
      ),
    ));
    return playground;
  }

  @override
  build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Game"),
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buildPlayground(buildGrid()),
        )
      ),
    );
  }
}

/*
*/
