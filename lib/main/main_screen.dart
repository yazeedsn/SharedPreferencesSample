import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences_sample/helpers/shared_preferences.dart';
import 'package:shared_preferences_sample/main/main_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    String value =
                        context.read<MainController>().controller.text;
                    SharedPreferencesHelper().set('result', value);
                  },
                  child: const Text('Set')),
              ElevatedButton(
                  onPressed: () async {
                    String? value =
                        await SharedPreferencesHelper().get('result');
                    if (context.mounted) {
                      if (value == null) {
                        MainController controller =
                            context.read<MainController>();
                        if (!controller.isSnakebarActive) {
                          controller.isSnakebarActive = true;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                                const SnackBar(
                                  content: Text('No value is stored.'),
                                ),
                              )
                              .closed
                              .then((value) =>
                                  controller.isSnakebarActive = false);
                        }
                      } else {
                        context.read<MainController>().setResult(value);
                      }
                    }
                  },
                  child: const Text('Get')),
              ElevatedButton(
                  onPressed: () {
                    SharedPreferencesHelper().remove('result');
                    context.read<MainController>().setResult('');
                  },
                  child: const Text('Delete')),
              const SizedBox(height: 30),
              TextField(
                controller: context.read<MainController>().controller,
              ),
              const SizedBox(height: 30),
              Consumer<MainController>(builder: (context, controller, child) {
                return Text(controller.result);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
