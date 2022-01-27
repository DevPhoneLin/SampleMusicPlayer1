import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sample_music_player_1/res/app_colors.dart' as AppColors;
import 'package:sample_music_player_1/ui/widgets/apptabs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List popularBooks = [];
  List books = [];
  late ScrollController _scrollController;
  late TabController _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/popularbooks.json")
        .then((s) {
      setState(() {
        popularBooks = json.decode(s);
      });
    });

    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((s) {
      setState(() {
        books = json.decode(s);
      });
    });

  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ImageIcon(
                      AssetImage("assets/images/menu.png"),
                      color: Colors.black,
                      size: 24,
                    ),
                    // Spacer(), Can also use this widget
                    Row(
                      children: const [
                        Icon(Icons.search),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.notifications),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: const [
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Popular Books",
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              bannerWidget(popularBooks, context),
              Expanded(
                  child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext cotext, bool isScroll) {
                  return [
                    SliverAppBar(
                      backgroundColor: AppColors.sliverBackground,
                      pinned: true,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: Container(
                          margin: const EdgeInsets.only(left: 16,bottom: 20,),
                          child: TabBar(
                            indicatorPadding: const EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: const EdgeInsets.only(right: 10),
                            controller: _tabController,
                            isScrollable: true,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 7,
                                    offset: const Offset(
                                      0,
                                      0,
                                    ),
                                  )
                                ]),
                            tabs: [
                              AppTabs(color: AppColors.menu1Color, text: "New"),
                              AppTabs(color: AppColors.menu2Color, text: "Popular"),
                              AppTabs(color: AppColors.menu3Color, text: "Trending"),
                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    tabBarView(books, context),
                    tabBarView(books, context),
                    tabBarView(books, context),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget bannerWidget(List popularBooks, BuildContext context) {
  return Container(
    height: 180,
    child: Stack(
      children: [
        Positioned(
            top: 0,
            left: -20,
            right: 0,
            child: Container(
              height: 180,
              child: PageView.builder(
                  controller: PageController(viewportFraction: 0.8),
                  itemCount: popularBooks == null ? 0 : popularBooks.length,
                  itemBuilder: (_, i) {
                    return Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                              // image: AssetImage("assets/images/pic-8.png"),
                              image: AssetImage(popularBooks[i]["img"]),
                              fit: BoxFit.fill)),
                    );
                  }),
            ))
      ],
    ),
  );
}

Widget tabBarView(List books, BuildContext context){
  return ListView.builder(
      itemCount: books==null?0:books.length,
      itemBuilder: (_,i){
        return Container(
          color: AppColors.tabVarViewColor,
          margin: EdgeInsets.only(right: 20,left: 20,top: 10,bottom: 10,),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow:[
                  BoxShadow(
                      blurRadius: 2,
                      offset: Offset(0,0),
                      color: Colors.grey.withOpacity(0.2)
                  ),
                ]
            ),
            child: Container(
              margin: EdgeInsets.all(8),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(
                              books[i]["img"],
                            )
                        )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, size: 24,color: AppColors.starColor,),
                          SizedBox(width: 5,),
                          Text(books[i]["rating"],style: TextStyle(color: AppColors.menu2Color),)
                        ],
                      ),
                      Text(books[i]["title"],style: TextStyle(color: Colors.black,fontSize: 16),),
                      Text(books[i]["writer"],style: TextStyle(color: AppColors.subTitleText,fontSize: 12),),
                      SizedBox(height: 8,),
                      Container(
                        width: 60,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)
                        ),
                        alignment: Alignment.center,
                        child: Text(books[i]["category"],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,),),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
