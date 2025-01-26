import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  String channel = '';
  String oaid = '';

  @override
  void initState() {
    initApp();
    super.initState();
  }

  void initApp() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('闪屏页'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("appName:${_packageInfo.appName}"),
            Text("packageName:${_packageInfo.packageName}"),
            Text("version:${_packageInfo.version}"),
            Text("buildNumber:${_packageInfo.buildNumber}"),
            Text("buildSignature:${_packageInfo.buildSignature}"),
            Text("installerStore:${_packageInfo.installerStore}"),
            Text("渠道是:$channel"),
            Text("安卓设备oaid:$oaid"),
            TextButton(
              onPressed: () {},
              child: Text('文字按钮'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/play');
              },
              child: Text("Play Video"),
            )
          ],
        ),
      ),
    );
  }
}
