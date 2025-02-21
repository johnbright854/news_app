import 'package:flutter/material.dart';
import 'package:project_1/screens/news_article_detail_page.dart';
import 'package:project_1/state_management/provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<NewsProvider>(context, listen: false).getDataFromApi();
    });

    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        Provider.of<NewsProvider>(context, listen: false).loadMoreData();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('News Reader App',style: TextStyle(color: Colors.grey.shade200, letterSpacing: 0.5,fontSize: 25, fontWeight: FontWeight.w500),),
          centerTitle: true,
          backgroundColor: Colors.blue.shade500,
          elevation: 0.0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today's News",style: TextStyle(color: Colors.grey.shade800,fontWeight: FontWeight.w900, letterSpacing: 0.5, fontSize: 22)),
            Consumer<NewsProvider>(builder: (context, value, child) {
              return value.isConnectedToInternet
                  ? Expanded(
                    child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                    itemCount: value.listOfNews.length + 1,
                    itemBuilder: (context, int index) {
                      if(index == value.listOfNews.length){
                        return value.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : SizedBox.shrink();
                      }
                      final newsIndex = value.listOfNews[index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return NewsArticleDetailPage(
                              thumbnailImage: newsIndex.image,
                              title: newsIndex.title,
                              description: newsIndex.description,
                              publishedAt: newsIndex.publishedAt,

                            );
                          }));
                        },
                        child: Card(
                          color: Colors.grey.shade100,
                          child: Column(
                            spacing: 8.0,
                            children: [
                              // Text('From API', style: TextStyle(fontSize: 13),),
                              SizedBox(
                                height: 200,
                                width: double.infinity,
                                child:ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: newsIndex.image != null && newsIndex.image.isNotEmpty ?
                                    Image.network(
                                      newsIndex.image,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 50,),
                                    ) : Image.asset('assets/images/photo.png')
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Text('Title: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                    Expanded(
                                        child: newsIndex.title != null && newsIndex.title.isNotEmpty ?
                                        Text(newsIndex.title, maxLines: 1,overflow: TextOverflow.ellipsis,) :
                                        Text('No title available')
                                    ),],),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Description: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                    Expanded(
                                        child: newsIndex.description != null && newsIndex.description.isNotEmpty ?
                                        Text(
                                          newsIndex.description.trim().replaceAll(RegExp(r'\s+'),' '),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,) :
                                        Text('No description available')
                                    )
                                    ,],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Text('Published At: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                    Expanded(
                                        child: newsIndex.publishedAt != null && newsIndex.publishedAt.isNotEmpty ?
                                        Text(newsIndex.publishedAt, maxLines: 1,overflow: TextOverflow.ellipsis) :
                                        Text('No published date available')
                                    ),],),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                ),
              )
                  : value.cachedNews.isEmpty
                  ? Expanded(
                child: Container(
                  height: double.infinity,
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.wifi_off, color: Colors.red.shade800),
                            SizedBox(width: 8),
                            Text(
                              'No Internet Connection',
                              style: TextStyle(color: Colors.grey.shade800, fontSize: 20),
                            ),
                          ],
                        ),
                        GestureDetector(
                            onTap: (){
                              value.getDataFromApi();
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(color: Colors.blue),
                              child: Text('Retry', style: TextStyle(fontSize: 18),),
                            ))
                      ],
                    ),
                  ),
                ),
              )
                  : Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                    itemCount: value.cachedNews.length + 1,
                    itemBuilder: (context, int index) {
                      if(index == value.cachedNews.length){
                        return value.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : SizedBox.shrink();
                      }
                      final newsIndex = value.cachedNews[index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return NewsArticleDetailPage(
                              thumbnailImage: newsIndex.image,
                              title: newsIndex.title,
                              description: newsIndex.description,
                              publishedAt: newsIndex.publishedAt,
                            );
                          }));
                        },
                        child: Card(
                          color: Colors.grey.shade100,
                          child: Column(
                            spacing: 8.0,
                            children: [
                              // Text('From cached data', style: TextStyle(fontSize:15),),
                              SizedBox(
                                height: 200,
                                width: double.infinity,
                                child:ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: newsIndex.image != null && newsIndex.image.isNotEmpty ?
                                    Image.network(
                                      newsIndex.image,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 50,),
                                    ) : Image.asset('assets/images/photo.png')
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Text('Title: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                    Expanded(
                                        child: newsIndex.title != null && newsIndex.title.isNotEmpty ?
                                        Text(newsIndex.title, maxLines: 1,overflow: TextOverflow.ellipsis,) :
                                        Text('No title available')
                                    ),],),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Description: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                    Expanded(
                                        child: newsIndex.description != null && newsIndex.description.isNotEmpty ?
                                        Text(
                                          newsIndex.description.trim().replaceAll(RegExp(r'\s+'),' '),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,) :
                                        Text('No description available')
                                    )
                                    ,],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Text('Published At: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                    Expanded(
                                        child: newsIndex.publishedAt != null && newsIndex.publishedAt.isNotEmpty ?
                                        Text(newsIndex.publishedAt, maxLines: 1,overflow: TextOverflow.ellipsis) :
                                        Text('No published date available')
                                    ),],),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                ),
              );
            },),
          ],
        ),
      )
    );
  }
}
