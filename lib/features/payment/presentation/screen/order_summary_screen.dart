import 'package:event_app/core/config/extension.dart';
import 'package:event_app/core/shared/widget/custom_button.dart';
import 'package:event_app/features/payment/data/dto/create_order_dto.dart';
import 'package:event_app/features/payment/domain/entity/order.dart';
import 'package:event_app/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSummary extends StatelessWidget {
  final Order order;

  const OrderSummary({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade50,
        title: Text(
          "Order Summary",
          style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    /// TODO: HANDLE GUNAKAN ORDER DARI LIST
                    _buildListOrder(context, [order, order, order]),
                    SizedBox(height: 16),
                    Divider(),
                    _orderRow(
                      context,
                      child: Text(
                        'SUBTOTAL',
                        style: context.text.bodySmall?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      value: order.ticket.price.displayRupiah,
                      isSubtotal: true,
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: CustomButton(
                title: 'Bayar Sekarang',
                onPressed: () => _startPayment(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListOrder(BuildContext context, List<Order> orders) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      separatorBuilder:
          (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: const Divider(height: 1),
          ),
      itemBuilder: (context, index) {
        final order = orders[index];

        return _orderRow(
          context,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.network(order.event.banner, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.event.name,
                    style: context.text.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text('qty: ${order.quantity}', style: context.text.bodySmall),
                ],
              ),
            ],
          ),
          value: order.ticket.price.displayRupiah,
        );
      },
    );
  }

  Widget _orderRow(
    BuildContext context, {
    required Widget child,
    required String value,
    bool isSubtotal = false,
  }) {
    if (isSubtotal) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            child,
            Text(
              value,
              style: context.text.bodyLarge?.copyWith(
                fontSize: 16,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          child,
          Text(value, style: context.text.bodyLarge?.copyWith(fontSize: 14)),
        ],
      ),
    );
  }

  void _startPayment(BuildContext context) {
    context.read<PaymentBloc>().add(
      CreateOrderEvent(
        orders: [
          CreateOrderDto(
            idEvent: order.ticket.eventId,
            qty: 1,
            idTicket: order.ticket.id,
          ),
        ],
      ),
    );
  }
}
