import 'package:event_app/core/config/enum.dart';
import 'package:event_app/core/config/extension.dart';
import 'package:event_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:event_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/entity/user.dart';
import '../../domain/entity/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartBloc _cartBloc = context.read<CartBloc>();
  late final User? _user = context.read<AuthBloc>().state.user;

  final ValueNotifier<Map<String, List<CartItem>>?> _listDeleteItems = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _cartBloc.add(GetCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.chevron_left_outlined, size: 30, color: context.onBackground),
                  ),
                  Center(child: Text('CART', style: context.text.titleLarge?.copyWith(fontWeight: FontWeight.bold))),
                  ValueListenableBuilder(
                    valueListenable: _listDeleteItems,
                    builder: (context, value, child) {
                      return InkWell(
                        onTap:
                            (value == null)
                                ? null
                                : () {
                                  print('gak masuk wle');
                                },
                        child: Icon(
                          Icons.delete_outlined,
                          size: 25,
                          color: (value == null) ? context.disableColor : context.onBackground,
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 32),
              BlocSelector<CartBloc, CartState, CartState>(
                selector: (state) => state,
                builder: (context, state) {
                  if (state.status == BlocStatus.loading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state.status == BlocStatus.error) {
                    return Center(child: Text('no item in your cart'));
                  }

                  return _buildListCart(state.groupedCart);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListCart(Map<String, List<CartItem>> groupedCart) {
    final entries = groupedCart.entries.toList();

    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 24),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        final eventName = entry.key;
        final items = entry.value;

        return Container(
          decoration: BoxDecoration(
            border: Border.all(strokeAlign: 2, color: Colors.black38),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header - Event Name
              Row(
                children: [
                  Expanded(
                    child: Text(
                      eventName,
                      style: context.text.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${items.length} items',
                      style: context.text.bodySmall?.copyWith(color: Colors.deepPurple.shade700),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Divider
              Divider(height: 1, color: Colors.grey.shade300),
              SizedBox(height: 16),

              // Items List
              ...items.asMap().entries.map((itemEntry) {
                final index = itemEntry.key;
                final item = itemEntry.value;
                return _buildTicketItem(items, index, item);
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTicketItem(List<CartItem> items, int index, CartItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: index < items.length - 1 ? 12 : 0),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.ticketName,
              style: context.text.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: context.onBackground),
            ),
          ),
          SizedBox(width: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap:
                      () => _cartBloc.add(
                        UpdateTicketQtyEvent(
                          isIncrement: false,
                          userId: _user?.id ?? '',
                          ticketId: item.idTicket,
                          quantity: item.quantity,
                        ),
                      ),
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.remove, size: 20, color: Colors.grey.shade700),
                  ),
                ),
                SizedBox(width: 8),
                Text(item.quantity.toString(), style: context.text.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(width: 8),
                InkWell(
                  onTap:
                      () => _cartBloc.add(
                        UpdateTicketQtyEvent(
                          isIncrement: true,
                          userId: _user?.id ?? '',
                          ticketId: item.idTicket,
                          quantity: item.quantity,
                        ),
                      ),
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.add, size: 20, color: context.primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
