import 'package:flutter/material.dart';

class OptionsRoute<T> extends MaterialPageRoute<T> {
  OptionsRoute({
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
        begin: new FractionalOffset(-1.0, 0.0),
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

class Options extends StatefulWidget {
  @override
  _Options createState() => new _Options();
}

class _Options extends State<Options> {
  @override
  build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Options"),
        leading: new Container(),
        actions: [ new IconButton( icon: new Icon( Theme.of(context).platform == TargetPlatform.iOS ? Icons.arrow_forward_ios : Icons.arrow_forward), onPressed: () { Navigator.pop(context); })],
      ),
      body: new Center(
        child: new Text("Options go here..."),
      ),
    );
  }
}
