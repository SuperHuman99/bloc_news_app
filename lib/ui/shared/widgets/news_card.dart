import 'package:bloc_news_app/core/blocs/news_bloc/news_bloc.dart';
import 'package:bloc_news_app/core/models/news_model.dart';
import 'package:bloc_news_app/ui/pages/sub_pages/news_detail_page.dart';
import 'package:bloc_news_app/ui/shared/constants.dart';
import 'package:bloc_news_app/ui/shared/widgets/custom_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCard extends StatefulWidget {
  const NewsCard({
    Key? key,
    required this.cardHeight,
    required this.screenWidth,
    required this.contentPadding,
    required this.news,
  }) : super(key: key);

  final double cardHeight;
  final double screenWidth;
  final double contentPadding;
  final News news;

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  late TextEditingController _titleFieldController;

  @override
  void initState() {
    super.initState();

    _titleFieldController = TextEditingController(text: widget.news.title);
  }

  @override
  void dispose() {
    _titleFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showAnimatedDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ClassicGeneralDialogWidget(
              titleText: "delete".toUpperCase(),
              contentText: "Are you sure you want to delete the selected item?",
              positiveText: "Delete",
              negativeTextStyle: const TextStyle(color: Colors.red),
              negativeText: "Cancel",
              onPositiveClick: () {
                Navigator.of(context).pop();
                BlocProvider.of<NewsBloc>(context)
                    .add(DeleteNews(newsItem: widget.news));
              },
              onNegativeClick: () {
                Navigator.of(context).pop();
              },
            );
          },
          animationType: DialogTransitionType.size,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(seconds: 1),
        );
      },
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Update News".toUpperCase(),
                style: const TextStyle(fontSize: 20),
              ),
              content: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextField(
                  controller: _titleFieldController,
                  decoration: InputDecoration(
                    hintText: "News Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              actions: [
                CustomButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    label: "Cancel"),
                CustomButton(
                    onPressed: () {
                      BlocProvider.of<NewsBloc>(context).add(
                        UpdateNews(
                          newsItem: widget.news,
                          newTitle: _titleFieldController.text,
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    label: "Update"),
              ],
            );
          },
        );
      },
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewsDetailsPage(
              imageUrl: widget.news.mediaImageUrl,
              title: widget.news.title,
              abstract: widget.news.abstract,
              newDetailUrl: widget.news.newsDetailUrl,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: widget.cardHeight,
          width: widget.screenWidth - widget.contentPadding,
          child: Row(
            children: [
              SizedBox(
                height: widget.cardHeight,
                width: 0.3 * widget.screenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.news.mediaImageUrl == "empty"
                        ? noImageUrl
                        : widget.news.mediaImageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.news.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.news.abstract,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
