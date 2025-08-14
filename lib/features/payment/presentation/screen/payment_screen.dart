import 'package:event_app/core/config/extension.dart';
import 'package:event_app/core/shared/widget/custom_button.dart';
import 'package:event_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:event_app/features/event/domain/entity/ticket.dart';
import 'package:event_app/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentScreen extends StatelessWidget {
  final Ticket ticket;
  const PaymentScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final user = authBloc.state.user;

    return Scaffold(
      appBar: AppBar(title: const Text("Pembayaran")),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _orderRow("Customer", user?.fullname ?? '-'),
                    _orderRow("Email", user?.email ?? '-'),
                    _orderRow("Total", ticket.price.displayRupiah),
                  ],
                ),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: CustomButton(
                title: 'Bayar Sekarang',
                onPressed: () {
                  context.read<PaymentBloc>().add(
                    CreateOrderEvent(
                      idEvent: ticket.eventId,
                      qty: 1,
                      idTicket: ticket.id,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
