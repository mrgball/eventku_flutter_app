import 'package:event_app/core/config/extension.dart';
import 'package:event_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CartBloc>().add(GetCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(child: Text('CART', style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold))),
            _buildListCart(),
          ],
        ),
      ),
    );
  }

  Widget _buildListCart() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Text('item');
        },
        itemCount: 10,
      ),
    );
  }
}
