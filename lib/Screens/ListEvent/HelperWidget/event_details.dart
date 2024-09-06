import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:organizer_app/CommonWidgets/text_style.dart';
import 'package:organizer_app/Helper/api_service.dart';
import 'package:organizer_app/Model/event_data_model.dart';
import 'package:organizer_app/Screens/ListEvent/HelperWidget/video_thumnail.dart';
import 'package:organizer_app/Utils/const_color.dart';
import 'package:organizer_app/Utils/format_data.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventDataModel eventData;
  const EventDetailsScreen({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    MainEvent mainEvent = eventData.mainEvent;
    List<SubEvent> subEvents = eventData.subEvents;

    Color statusColor(String status) {
      switch (status.toLowerCase()) {
        case 'pending':
          return Colors.orange;
        case 'completed':
          return Colors.green;
        case 'canceled':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          mainEvent.name,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Event Images Carousel
              if (mainEvent.coverImg.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 250,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                    ),
                    items: mainEvent.coverImg.map((imageUrl) {
                      return GestureDetector(
                        onTap: () {
                          // showImagePopup(context, imageUrl),
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "${imageBaseUrl}ev_cover_img/$imageUrl"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              // Main Event Details
              Text(mainEvent.name,
                  style: textStyle(25, primaryColor, FontWeight.bold)),
              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.black54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Location: ${mainEvent.location.toString()}',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.category, color: Colors.black54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Category: ${mainEvent.category}',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.description, color: Colors.black54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Description: ${mainEvent.description}',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.event_available, color: Colors.black54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Registration Period: ${formatTimeStamp(mainEvent.regStart.toString())} to ${formatTimeStamp(mainEvent.regEnd.toString())}',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Row(
              //   children: [
              //     const Icon(Icons.label, color: Colors.black54),
              //     const SizedBox(width: 8),
              //     Expanded(
              //       child: Text(
              //         'Tags: ${mainEvent.tags.join(', ')}',
              //         style: const TextStyle(fontSize: 14, color: Colors.black54),
              //       ),
              //     ),
              //   ],
              // ),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: mainEvent.tags.map((tag) {
                  return Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: const Color.fromARGB(255, 26, 228, 198))),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: Center(
                      child: Text(
                        tag.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Sub Events',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Sub Events List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: subEvents.length,
                itemBuilder: (context, index) {
                  final subEvent = subEvents[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (subEvent.images.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                // showImagePopup(context, subEvent.images[0]),
                              },
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: 150,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  aspectRatio: 2.0,
                                ),
                                items: subEvent.images.map((imageUrl) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "${imageBaseUrl}ev_sub_img/$imageUrl"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          if (subEvent.videoUrl.isNotEmpty)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: VideoThumbnailPlayer(
                                videoUrl: subEvent.videoUrl,
                                eventData: eventData,
                              ),
                            ),
                          Text(
                            subEvent.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.person, color: Colors.black54),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Host: ${subEvent.hostName}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.date_range,
                                  color: Colors.black54),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Date: ${formatTimeStamp(subEvent.startDate.toString())}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: Colors.black54),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Time: ${subEvent.startTime} - ${subEvent.endTime}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.monetization_on,
                                  color: Colors.black54),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Ticket Price: ${subEvent.ticketPrice} ${mainEvent.currency}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.confirmation_number,
                                  color: Colors.black54),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Ticket Quantity: ${subEvent.ticketQty}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: statusColor(subEvent.status),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              subEvent.status.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
