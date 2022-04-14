import 'package:bloc_news_app/ui/pages/sub_pages/web_view_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsDetailsPage extends StatelessWidget {
  const NewsDetailsPage({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.abstract,
    required this.newDetailUrl,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final String abstract;
  final String newDetailUrl;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWeidth = MediaQuery.of(context).size.width;

    double contentPadding = 10.0;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(contentPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.4 * screenHeight,
                width: screenWeidth - contentPadding,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              const Spacer(flex: 1),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(flex: 1),
              Text(
                abstract,
                style: const TextStyle(fontSize: 14),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(flex: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WebViewPage(
                        newsDetailUrl: newDetailUrl,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenWeidth - 20, 50),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
                child: const Text(
                  "View News Online",
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
