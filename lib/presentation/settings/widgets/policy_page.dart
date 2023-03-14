import 'package:buddy/presentation/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  late final WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('https://google.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: controller),
            if (isLoading)
              const Loading(useScaffold: false)
          ],
        ),
      ),
    );
  }
}
