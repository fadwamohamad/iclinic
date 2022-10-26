import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../custom_lib/animation_limiter/src/animation_limiter.dart';
import '../services/webservice.dart';
import '../widgets/empty.dart';
import '../widgets/error.dart';
import '../widgets/nointernet.dart';
import '../widgets/shimmer_widget.dart';

class ListGeneralUi extends StatefulWidget {
  IndexedWidgetBuilder? itemBuilder;
  IndexedWidgetBuilder? separatorBuilder;
  Future<bool> Function(int)? onGetData;

  Function(ScrollController)? onGetScrollController;

  // int length;
  bool? isMoreDataAvailable = true;
  Rx<dynamic>? onRest;
  LoadingStatus status;
  String? error;
  int length;
  double rateHeight;
  bool pagination;
  bool pullToRefresh;
  EdgeInsetsGeometry? padding;

  ListGeneralUi(
      {required this.status,
      this.error,
      this.isMoreDataAvailable,
      this.pagination = true,
      this.pullToRefresh = true,
      this.onGetData,
      this.onGetScrollController,
      this.itemBuilder,
      this.separatorBuilder,
      this.padding,
      this.rateHeight = 1.3,
      this.length = 0,
      this.onRest});

  @override
  _ListGeneralUiState createState() => _ListGeneralUiState();
}

class _ListGeneralUiState extends State<ListGeneralUi> {
  int page = 1;
  ScrollController? scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController = ScrollController()..addListener(_scrollListener);

    if (widget.onGetScrollController != null) {
      widget.onGetScrollController!(scrollController!);
    }
    if (widget.onRest != null) {
      widget.onRest!.listen((value) {
        if (this.mounted) {
          setState(() {
            page = 1;
            widget.status = LoadingStatus.loading;
            widget.onGetData!(page);
          });
        }
      });
    }
    widget.onGetData!(page);
  }

  void _scrollListener() async {
    if (scrollController!.offset >=
            scrollController!.position.maxScrollExtent &&
        !scrollController!.position.outOfRange) {
      try {
        if (widget.isMoreDataAvailable! && widget.pagination) {
          page++;
          widget.onGetData!(page);
        }
      } catch (err) {
        print(err);
      }
    }
  }

  Future<void> _pullRefresh() async {
    page = 1;
    await widget.onGetData!(1);
  }

  Widget itemBuilder(BuildContext context, int index) {
    print("isMoreDataAvailable:${widget.isMoreDataAvailable} ");

    bool length2 = widget.length < 12;
    if (length2) {
      /* if (index == widget.length - 1 && widget.isMoreDataAvailable == true && widget.pagination) {
        page++;
        widget.onGetData!(page);
        return const Center(child: CircularProgressIndicator());
      }*/
      return widget.itemBuilder!(context, index);
    } else {
      if (index == widget.length - 1 &&
          widget.isMoreDataAvailable == true &&
          widget.pagination) {
        return const Center(child: CircularProgressIndicator());
      }
      return widget.itemBuilder!(context, index);
    }
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return widget.separatorBuilder != null
        ? widget.separatorBuilder!(context, index)
        : SizedBox.shrink();
  }

  bool isNotEmpty() {
    return widget.length > 0;
  }

  bool isEmpty() {
    return widget.length == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //  color: CustomColors.mainColor,
        child: widget.pullToRefresh
            ? RefreshIndicator(
                onRefresh: _pullRefresh,
                // triggerMode: RefreshIndicatorTriggerMode.anywhere,
                child: getView())
            : Container(
                alignment: Alignment.center, child: Center(child: getView())));
  }

  Widget getView() {
    if (widget.status == LoadingStatus.loading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              child: Container(
                alignment: Alignment.center,
                child: const Center(
                  child: ShimmerWidget(),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (widget.status == LoadingStatus.unauthenticated) {
      return ListView(physics: NeverScrollableScrollPhysics(), children: [
        Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            child: const Text("authontcationError"))
      ]);
    } else if (widget.status == LoadingStatus.newWorkError) {
      return NoInternet(widget.rateHeight, onRefresh: () {
        setState(() {
          widget.status = LoadingStatus.loading;
        });
        _pullRefresh();
      });
    } else if (widget.status == LoadingStatus.error) {
      return ErrorView(widget.error, onRefresh: () {
        setState(() {
          widget.status = LoadingStatus.loading;
        });
        _pullRefresh();
      });
    } else if (widget.status == LoadingStatus.empty) {
      return Empty(widget.rateHeight, onRefresh: () {
        setState(() {
          widget.status = LoadingStatus.loading;
        });
        _pullRefresh();
      });
    } else if (widget.status == LoadingStatus.completed) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: AnimationLimiter(
            child: ListView.separated(
              shrinkWrap: false,
              separatorBuilder: separatorBuilder,
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              controller: scrollController,
              padding: widget.padding ??
                  EdgeInsetsDirectional.only(
                      start: 16.w, end: 16.w, top: 20.h, bottom: 20.h),
              itemBuilder: itemBuilder,
              itemCount: widget.length,
            ),
          ));
    } else {
      return ListView(children: [
        Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            child: const CircularProgressIndicator())
      ]);
    }
  }
}
