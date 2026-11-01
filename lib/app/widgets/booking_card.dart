import 'package:flutter/material.dart';

import '../data/models/booking_model.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;

  const BookingCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage(
            booking.image,
          ),
        ),
        title: Text(
          booking.workerName,
        ),
        subtitle: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(booking.profession),
            Text(booking.date),
            Text(booking.time),
            Text(
              booking.status,
              style: TextStyle(
                color: booking.status == "Completed"
                    ? Colors.green
                    : Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}