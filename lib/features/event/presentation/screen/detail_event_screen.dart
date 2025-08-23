import 'package:event_app/core/config/constant.dart';
import 'package:event_app/core/config/extension.dart';
import 'package:event_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:event_app/features/cart/domain/entity/cart_item.dart';
import 'package:event_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:event_app/features/event/domain/entity/event.dart';
import 'package:event_app/features/event/domain/entity/ticket.dart';
import 'package:event_app/features/event/presentation/widget/ticket_container.dart';
import 'package:event_app/features/payment/domain/entity/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/entity/user.dart';

class DetailEventScreen extends StatefulWidget {
  final Event event;

  const DetailEventScreen({super.key, required this.event});

  @override
  State<DetailEventScreen> createState() => _DetailEventScreenState();
}

class _DetailEventScreenState extends State<DetailEventScreen> {
  final ValueNotifier<bool> _isExpandText = ValueNotifier(false);
  late final User? _user = context.read<AuthBloc>().state.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: SafeArea(
                child: Stack(
                  children: [
                    ClipRRect(
                      child: Image.network(widget.event.banner, width: double.infinity, height: 250, fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.5),
                        child: Icon(Icons.chevron_left, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.event.name, style: context.text.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 32),
                  Text('About This Event', style: context.text.titleMedium?.copyWith(fontWeight: FontWeight.w500)),
                  SizedBox(height: 12),

                  _buildExpandText(widget.event.description),
                  SizedBox(height: 12),

                  _buildTicket(widget.event.tickets),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicket(List<Ticket> listTicket) {
    if (listTicket.isEmpty) {
      return Center(child: Text('belum ada ticket yang dijual'));
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listTicket.length,
      itemBuilder: (context, index) {
        final ticket = listTicket[index];

        return TicketContainer(
          height: 150,
          topChild: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ticket.name,
                style: context.text.headlineSmall?.copyWith(color: context.onBackground, fontWeight: FontWeight.bold),
              ),
              Text(ticket.price.displayRupiah, style: context.text.titleMedium?.copyWith(color: context.onBackground)),
            ],
          ),
          bottomChild: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(
                onPressed:
                    () => context.read<CartBloc>().add(
                      AddToCartEvent(
                        CartItem(
                          idUser: _user?.id ?? '',
                          quantity: 1,
                          idEvent: widget.event.id,
                          idTicket: ticket.id,
                          name: widget.event.name,
                          price: ticket.price,
                          ticketName: ticket.name,
                        ),
                      ),
                    ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  side: const BorderSide(color: Colors.deepPurple, width: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.shopping_bag_outlined, color: Colors.deepPurple, size: 18),
                label: Text(
                  'Add to cart',
                  style: context.text.bodyMedium?.copyWith(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),

              ElevatedButton.icon(
                onPressed:
                    () => Navigator.of(context).pushNamed(
                      Constant.routeOrderSummary,
                      arguments: {'order': Order(event: widget.event, ticket: ticket, quantity: 1)},
                    ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.flash_on, size: 18, color: Colors.white),
                label: Text(
                  'Buy Now',
                  style: context.text.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),

          dashColor: context.disableColor,
        );
      },
    );
  }

  Widget _buildExpandText(String text) {
    return ValueListenableBuilder(
      valueListenable: _isExpandText,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              maxLines: value ? null : 3,
              overflow: value ? TextOverflow.visible : TextOverflow.ellipsis,
              style: context.text.bodyMedium?.copyWith(color: context.disableColor),
            ),
            SizedBox(height: 4),

            if (text.length > 50 && !value)
              GestureDetector(
                onTap: () {
                  _isExpandText.value = !_isExpandText.value;
                },
                child: const Text('Show More', style: TextStyle(color: Colors.deepPurple)),
              ),
            SizedBox(height: 4),

            if (_isExpandText.value)
              GestureDetector(
                onTap: () {
                  _isExpandText.value = false;
                },
                child: const Text('Show Less', style: TextStyle(color: Colors.deepPurple)),
              ),
          ],
        );
      },
    );
  }
}
