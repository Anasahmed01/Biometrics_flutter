import 'package:bio_matrixx/models/biometricx_viewmodel.dart';
import 'package:bio_matrixx/services/local_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => BioMetricViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              shadowColor: Colors.amberAccent,
              backgroundColor: Colors.amberAccent,
              title: const Text('Finger Print'),
              centerTitle: true,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (viewModel.authenticated == false)
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.amberAccent,
                        ),
                      ),
                      onPressed: () async {
                        final authenticate = await LocalAuth.authenticate();
                        viewModel.authenticated = authenticate;
                        viewModel.notifyListeners();
                      },
                      child: const Text('Authenticate'),
                    ),
                  if (viewModel.authenticated == true)
                    SizedBox(
                      child: Column(
                        children: [
                          if (viewModel.authenticated == true)
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/anas.png'),
                              radius: 100,
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (viewModel.authenticated)
                            const Text(
                              'You are Authenticated',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                        ],
                      ),
                    ),
                  if (viewModel.authenticated)
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.amberAccent,
                        ),
                      ),
                      onPressed: () {
                        viewModel.authenticated = false;
                        viewModel.notifyListeners();
                      },
                      child: const Text('Log Out'),
                    ),
                ],
              ),
            ),
          );
        });
  }
}
