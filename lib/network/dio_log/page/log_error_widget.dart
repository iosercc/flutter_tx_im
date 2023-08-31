import 'package:flutter/material.dart';
import 'package:tencent_cloud_chat_demo/network/dio_log/bean/net_options.dart';

///错误信息展示页面
class LogErrorWidget extends StatefulWidget {
  final NetOptions netOptions;

  LogErrorWidget(this.netOptions);

  @override
  _LogErrorWidgetState createState() => _LogErrorWidgetState();
}

class _LogErrorWidgetState extends State<LogErrorWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      height: double.infinity,
      child: Center(
        child: Text(widget.netOptions.errOptions?.errorMsg ?? 'no error'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
