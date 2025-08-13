import 'package:event_app/core/config/extension.dart';
import 'package:event_app/features/event/domain/entity/event.dart';
import 'package:event_app/features/event/domain/entity/ticket.dart';
import 'package:event_app/features/event/presentation/widget/ticket_container.dart';
import 'package:flutter/material.dart';

class DetailEventScreen extends StatefulWidget {
  final Event event;

  const DetailEventScreen({super.key, required this.event});

  @override
  State<DetailEventScreen> createState() => _DetailEventScreenState();
}

class _DetailEventScreenState extends State<DetailEventScreen> {
  final ValueNotifier<bool> _isExpandText = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Stack(
                children: [
                  ClipRRect(
                    child: Image.network(
                      widget.event.banner,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      child: IconButton(
                        icon: Icon(Icons.chevron_left, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event.name,
                    style: context.text.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'About This Event',
                    style: context.text.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
                style: context.text.headlineSmall?.copyWith(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ticket.price.displayRupiah,
                style: context.text.titleMedium?.copyWith(
                  color: context.onBackground,
                ),
              ),
            ],
          ),
          bottomChild: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SISA ${ticket.quantity} TICKET',
                style: context.text.titleSmall?.copyWith(
                  color: context.disableColor,
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  side: BorderSide(color: Colors.deepPurple, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Buy Now',
                      style: context.text.bodyMedium?.copyWith(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 18),
                    const Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: Colors.deepPurple,
                    ),
                  ],
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
              style: context.text.bodyMedium?.copyWith(
                color: context.disableColor,
              ),
            ),
            SizedBox(height: 4),

            if (text.length > 50 && !value)
              GestureDetector(
                onTap: () {
                  _isExpandText.value = !_isExpandText.value;
                },
                child: const Text(
                  'Show More',
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ),
            SizedBox(height: 4),

            if (_isExpandText.value)
              GestureDetector(
                onTap: () {
                  _isExpandText.value = false;
                },
                child: const Text(
                  'Show Less',
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ),
          ],
        );
      },
    );
  }
}
