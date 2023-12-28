import 'package:dio/dio.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flybuy/constants/currencies.dart';
import 'package:flybuy/mixins/unescape_mixin.dart';
import 'package:flybuy/models/models.dart';
import 'package:flybuy/models/post/post_suggestion.dart';
import 'package:flybuy/screens/product_list/product_list.dart';
import 'package:flybuy/screens/search/widget/product/recent_product.dart';
import 'package:flybuy/service/helpers/request_helper.dart';
import 'package:flybuy/store/search/search_store.dart';
import 'package:flybuy/store/store.dart';
import 'package:flybuy/utils/debug.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  final String? search;
  final ValueChanged<String>? onChange;

  const Search({
    Key? key,
    this.search,
    this.onChange,
  }) : super(key: key);

  @override
  State<Search> createState() => __SearchState();
}

class __SearchState extends State<Search> {
  List<PostSearch> _data = [];
  List<SuggestionPost> _suggestionData = [];
  CancelToken? _token;
  SearchStore? searchStore;

  @override
  void dispose() {
    _token?.cancel('cancelled');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    SettingStore settingStore = Provider.of<SettingStore>(context);
    searchStore = SearchStore(settingStore.persistHelper);
    super.didChangeDependencies();
  }

  Future<void> search(CancelToken? token) async {
    try {
      SettingStore settingStore = Provider.of<SettingStore>(context);
      PostStore postStore = PostStore(Provider.of<RequestHelper>(context));
      List<PostSearch>? data = await postStore.search(queryParameters: {
        'search': widget.search,
        'type': 'post',
        'subtype': 'product',
        'lang': settingStore.locale,
        CURRENCY_PARAM: settingStore.currency,
        // 'app-builder-search': widget.search,
      }, cancelToken: token);
      setState(() {
        _data = List<PostSearch>.of(data!);
      });
    } catch (e) {
      avoidPrint('Cancel fetch');
    }
  }

  Future<void> sugggestion(CancelToken? token) async {
    try {
      SettingStore settingStore = Provider.of<SettingStore>(context);
      PostStore postStore = PostStore(Provider.of<RequestHelper>(context));
      List<SuggestionPost>? data = await postStore.suggestion(queryParameters: {
        // 'search': widget.search,
        // 'type': 'post',
        // 'subtype': 'product',
        "action": "get_form_suggestions",
        "data[list_type]": "",
        'data[limit]': '10',
        "data[value]": widget.search,
        'lang': settingStore.locale,
        CURRENCY_PARAM: settingStore.currency,
        // 'app-builder-search': widget.search,
      }, cancelToken: token);
      setState(() {
        _suggestionData = List<SuggestionPost>.of(data!);
      });
    } catch (e) {
      avoidPrint('Cancel fetch');
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (_token != null) {
      _token?.cancel('cancelled');
    }

    setState(() {
      _token = CancelToken();
    });

    // search(_token);
    sugggestion(_token);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.search == '') {
      return RecentSearch(
        search: widget.search,
        // data: _data,
        data: _suggestionData,
        searchStore: searchStore,
        onChange: widget.onChange,
      );
    }
    return ListView.separated(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          Navigator.pushNamed(context, ProductListScreen.routeName,
              arguments: {'search': _suggestionData[index].name});
          // navigtion on detail page
          // Navigator.pushNamed(
          //     context, '${ProductScreen.routeName}/${_data[index].id}');
          searchStore!.addSearch(_suggestionData[index].name);
        },
        leading: const Icon(FeatherIcons.search, size: 22),
        horizontalTitleGap: 0,
        title: Text(unescape(_suggestionData[index].name),
            style: Theme.of(context).textTheme.titleSmall),
      ),
      itemCount: _suggestionData.length,
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
