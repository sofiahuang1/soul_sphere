import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';

class HomeCardGridView extends StatefulWidget {
  final int visibleItems;
  final VoidCallback loadMoreItems;

  const HomeCardGridView({
    super.key,
    required this.visibleItems,
    required this.loadMoreItems,
  });

  @override
  HomeCardGridViewState createState() => HomeCardGridViewState();
}

class HomeCardGridViewState extends State<HomeCardGridView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              widget.loadMoreItems();
            }
            return true;
          },
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 3 / 2,
            ),
            itemCount: widget.visibleItems,
            itemBuilder: (context, index) {
              final cardItem = AppConstants.cardItems[index];
              return GestureDetector(
                onTap: () {
                  context.push(cardItem.route);
                },
                child: Card(
                  color: cardItem.color,
                  elevation: 4.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        cardItem.imageUrl,
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(height: 8.0),
                      Text(cardItem.text),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
