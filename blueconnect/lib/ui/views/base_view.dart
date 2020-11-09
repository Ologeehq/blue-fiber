import 'package:blueconnectapp/core/veiwModels/base_model.dart';
import 'package:blueconnectapp/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;
  final Function(T) onModelDisposed;

  const BaseView({ Key key, @required this.builder, this.onModelReady, this.onModelDisposed,  }) : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {

  T model = locator<T>();

  @override
  void initState() {
    if(widget.onModelReady != null) widget.onModelReady(model);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    if(widget.onModelDisposed != null) widget.onModelDisposed(model);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }
}
