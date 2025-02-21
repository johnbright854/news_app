import 'package:flutter/material.dart';

class NewsArticleDetailPage extends StatelessWidget {
  final String? thumbnailImage;

  final String? title;

  final String? description;

  final String? publishedAt;

  const NewsArticleDetailPage({
    super.key,
    required this.thumbnailImage,
    required this.title,
    required this.description,
    required this.publishedAt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          title: Text('News Article',style: TextStyle(color: Colors.grey.shade200, letterSpacing: 0.5,fontSize: 25, fontWeight: FontWeight.w500),),
        centerTitle: true,
        backgroundColor: Colors.blue.shade500,
        iconTheme: IconThemeData(color: Colors.grey.shade200),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          spacing: 10,
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child:ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: thumbnailImage != null && thumbnailImage!.isNotEmpty ?
                  Image.network(
                    thumbnailImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 50,),
                  ) : Image.asset('assets/images/photo.png')
              ),
            ),
            Column(
              spacing: 15,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Flexible(
                      child: title != null && title!.isNotEmpty ?
                      Text(
                        title!,
                        softWrap: true,
                        style: TextStyle(fontSize: 17),
                      ) :
                          Text('No Title Available',style: TextStyle(fontSize: 17))
                    ),
                  ],),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Published At : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Flexible(
                      child: publishedAt != null && publishedAt!.isNotEmpty ?
                      Text(
                        publishedAt!,
                        softWrap: true,
                        style: TextStyle(fontSize: 17),
                      ) :
                          Text('No Date available',style: TextStyle(fontSize: 17))
                    ),
                  ],),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Flexible(
                      child: description != null && description!.isNotEmpty ?
                      Text(
                        description!.trim().replaceAll(RegExp(r'\s+'), ' '),
                        softWrap: true,
                        style: TextStyle(fontSize: 17),
                      ) :
                          Text('No Description Available',style: TextStyle(fontSize: 17))
                    ),
                  ],)
              ],
            )

          ],
        ),
      ),
    );
  }
}
