import 'package:dogs_and_cats/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:dogs_and_cats/src/bloc/auth_bloc/auth_events.dart';
import 'package:dogs_and_cats/src/bloc/auth_bloc/auth_state.dart';
import 'package:dogs_and_cats/src/ui/widgets/buttons_widgets.dart';
import 'package:dogs_and_cats/src/ui/widgets/text_fields_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginPage extends HookWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();


    return  BlocListener<AuthBloc, AuthState>(
      listener: (context, AuthState state) {
        if (state is LoggedInState) {
          Navigator.of(context).pushNamed('home');
        }
      },
      child: Builder(
        builder: (newContext) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              centerTitle: true,
              title: const Text("Login"),
            ),
            body: InkWell(
              onTap: () => FocusScope.of(newContext).unfocus(),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  EmailTextFieldWidget(textEditingController: emailTextController),
                  const SizedBox(height: 50),
                  PasswordTextFieldWidget(textEditingController: passwordTextController),
                  const SizedBox(height: 80),
                  BlackButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      newContext.read<AuthBloc>().add(
                            LoginEvent(
                              email: emailTextController.text,
                              password: passwordTextController.text,
                            ),
                          );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(newContext).pushNamed('signup');
                    },
                    child: const Text("Don't have account yet? signup here!"),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
