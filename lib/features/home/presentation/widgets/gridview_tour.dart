// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';
import 'package:zest_trip/config/utils/resources/confirm_dialog.dart';
import 'package:zest_trip/config/utils/resources/formatter.dart';

import 'package:zest_trip/features/home/domain/entities/tour_entity.dart';
import 'package:zest_trip/features/home/presentation/blocs/tour_wishlist/tour_wishlist_bloc.dart';
import 'package:zest_trip/features/home/presentation/screens/tour_detail_screen.dart';

class GridViewTour extends StatefulWidget {
  final List<TourEntity> tours;
  const GridViewTour({
    Key? key,
    required this.tours,
  }) : super(key: key);

  @override
  State<GridViewTour> createState() => _GridViewTourState();
}

class _GridViewTourState extends State<GridViewTour> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          mainAxisExtent: 300,
        ),
        itemCount: widget.tours.length,
        itemBuilder: (context, index) {
          return BlocBuilder<TourWishlistBloc, TourWishlistState>(
            builder: (context, state) {
              bool isFavorited = state.tours != null &&
                  state.tours!.any((tour) => tour.id == widget.tours[index].id);
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          TourDetailScreen(tourId: widget.tours[index].id!),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: colorLightGrey!),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: widget.tours
                                    .elementAt(index)
                                    .tourImages!
                                    .first,
                                height: 150,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: colorPlaceHolder,
                                  height: 150,
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: colorPlaceHolder,
                                  height: 150,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // top: 12,
                            right: 0,
                            child: IconButton(
                              onPressed: () async {
                                bool? confirmed =
                                    await DialogUtils.showConfirmDialog(
                                  context,
                                  content:
                                      'Do you want to remove this tour from wishlist?',
                                );

                                if (confirmed == true && mounted) {
                                  context.read<TourWishlistBloc>().add(
                                        RemoveWishlist(widget.tours[index].id!),
                                      );
                                }
                              },
                              icon: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: isFavorited
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.favorite_border,
                                        color: Colors.black,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tours.elementAt(index).name ?? "Tour name",
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // if (tours.elementAt(index).avgRating != null &&
                            //     tours.elementAt(index).count?["TourReview"] != null)
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 12),
                                const SizedBox(width: 4),
                                Text(
                                  widget.tours.elementAt(index).avgRating!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Colors.yellow[700],
                                          fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " (${widget.tours.elementAt(index).count?["TourReview"]})",
                                  style: TextStyle(color: colorBoldGrey),
                                ),
                              ],
                            ),
                            Text(
                              "${widget.tours.elementAt(index).count?["Booking"]} booked",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: colorBlack),
                            ),
                            // if (tour.pricingTicket?[0].fromPrice != null)
                            Text(
                              "From ${NumberFormatter.format(num.parse(widget.tours.elementAt(index).pricingTicket![0].fromPrice!))} ₫",
                              style: Theme.of(context).textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
