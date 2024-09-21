import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_app/consts/vars.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/articles_widget.dart';
import 'package:news_app/widgets/empty_screen.dart';
import 'package:news_app/widgets/vertical_spacing_widget.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }
 List<NewsModel>? seaechList = [];

 bool isSearching = false;
  @override
  void dispose() {
    // TODO: implement dispose
    If(mounted) {
      _searchController.dispose();
      _searchFocusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    Color color = Colors.black;
        final newsProvider = Provider.of<NewsProvider>(context,);

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusNode().unfocus();
        },
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        FocusNode().unfocus();
                        Navigator.pop(context);
                      },
                      child: Icon(
                        IconlyLight.arrowLeft2,
        
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(color: Colors.black),
                        autofocus: true,
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.text,
                        onEditingComplete: ()async {
                       seaechList =   await newsProvider.searchNewProvider(query: _searchController.text);
                       isSearching = true;
                         FocusNode().unfocus();
                          setState(() {
                            
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            bottom: 8/5, 
                          ),
                          hintText: 'Search',
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          suffix: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                FocusNode().unfocus();
                                isSearching  = false;
                                seaechList!.clear();
                                setState(() {
                               
                                });
                              },
                              child: Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              VerticalSpacing(10), 
              if(!isSearching && seaechList!.isEmpty)

              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MasonryGridView.count(
                    itemCount: searchKeyWords.length,
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          seaechList = await newsProvider.searchNewProvider(query: searchKeyWords[index]);
                          isSearching = true;
                          _searchController.text = searchKeyWords[index];
                          setState(() {
                            
                          });
                        },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center( 
                          child: FittedBox(
                            child: Text(
                              searchKeyWords[index],
                              style: smallTextStyle,
                            ),
                          ),
                        ),
                      ),
                      ),
                  );
                    },
                  ),
                ),
              ),
              if(isSearching && seaechList!.isEmpty)
              Expanded(child: EmptyNewsWidget(text: "Ops!! No Result found ", imagePath: 'assets/images/search.png'), 
              ),
              if(seaechList != null && seaechList!.isNotEmpty)
              Expanded(
                          child: ListView.builder(
                              itemCount: seaechList!.length,
                              itemBuilder: (ctx, index) {
                                return ChangeNotifierProvider.value(
                                  value: seaechList![index],
                                  child: const ArticlesWidget(
                                      ),
                                );
                              }),
                        ) 
            ],
          ),
        ),
      ),
    );
  }
}
