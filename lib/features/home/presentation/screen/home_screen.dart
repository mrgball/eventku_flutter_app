import 'package:event_app/core/config/extension.dart';
import 'package:event_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AuthBloc _authBloc = context.read<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    print('ppp: ${_authBloc.state.user?.createdAt}');
    return Scaffold(
      body: Center(
        child: Text('ini home screen', style: context.text.headlineLarge),
      ),
    );
  }
}
