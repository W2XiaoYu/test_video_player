import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with SingleTickerProviderStateMixin {
  String headImg =
      'https://imgcache.qq.com/fm/photo/album/rmid_album_720/c/P/003GdX842xFLcP.jpg?time=1506509578';
  String backgroundImg =
      'https://i5.3conline.com/images/piclib/201004/23/batch/1/58539/12719788154753gm3p4mk5y.jpg';

  // 在State类顶部添加滚动控制器和参数
  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0.0;
  late TabController _tabController; // 使用 late 确保稍后初始化
  bool isExpand = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 定义 Tab 的数量
    _scrollController.addListener(() {
      final double offset = _scrollController.offset;
      // 根据滚动偏移量计算透明度（0-100范围内）
      _appBarOpacity = (offset / 100).clamp(0.0, 1.0);
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _buildDrawer(),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              // automaticallyImplyLeading: false,
              expandedHeight: 250.0,
              floating: false,
              pinned: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                )
              ],
              title: Opacity(
                opacity: _appBarOpacity,
                child: Text(
                  '个人中心',
                  style: TextStyle(color: Colors.white), // 根据背景调整颜色
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      backgroundImg,
                      fit: BoxFit.cover,
                    ),
                    // 添加半透明渐变层
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              width: 80 - (30 * _appBarOpacity), // 头像尺寸变化
                              height: 80 - (30 * _appBarOpacity),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(headImg),
                              ),
                            ),
                            SizedBox(width: 10),
                            Opacity(
                              opacity: 1 - _appBarOpacity,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '怪你过分美丽',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24 - (8 * _appBarOpacity),
                                      // 文字尺寸变化
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'ID:13221001308',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16 - (8 * _appBarOpacity),
                                    ),
                                  )
                                ],
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
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildItem(
                          num: 0,
                          title: '获赞',
                        ),
                        _buildItem(
                          num: 48,
                          title: '互关',
                        ),
                        _buildItem(
                          num: 89,
                          title: '关注',
                        ),
                        _buildItem(
                          num: 35,
                          title: '粉丝',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.grey.withValues(alpha: 0.1),
                      ),
                      foregroundColor: WidgetStateProperty.all(Colors.black),
                    ),
                    child: Text('编辑资料'),
                  )
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverTabBarDelegate(
                  TabBar(
                      // 让文字上下间距减少
                      dividerHeight: 0,
                      labelColor: Colors.blue,
                      // 选中时的字体颜色
                      unselectedLabelColor: Colors.grey,
                      // 未选中时的字体颜色
                      indicatorColor: Colors.blue,
                      // 指示器颜色
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorPadding: EdgeInsets.only(bottom: 0),
                      labelPadding: EdgeInsets.symmetric(vertical: 0),
                      // 指示器大小
                      // 指示器的厚度

                      controller: _tabController,
                      tabs: [
                        Tab(
                          text: '动态',
                        ),
                        Tab(text: '收藏'),
                        Tab(text: '关注'),
                      ]),
                  color: Colors.white),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) => ListTile(
                title: Text('这是第 $index 个内容'),
              ),
            ),
            ListView(
              children: [
                IconButton(
                  onPressed: () => setState(() => isExpand = !isExpand),
                  icon: AnimatedRotation(
                    duration: Duration(microseconds: 200),
                    turns: isExpand ? 0.5 : 1,
                    child: Icon(
                      isExpand ? Icons.expand_less : Icons.expand_more,
                      color: Colors.blue,
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: isExpand
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 6,
                          shrinkWrap: true,
                          // Prevents overflow if the list size exceeds screen height
                          itemBuilder: (context, index) => ListTile(
                            title: Text('Item $index'),
                          ),
                        )
                      : SizedBox.shrink(),
                ),
              ],
            ),
            Center(child: Text('Content for Tab 3')),
          ],
        ),
      ),
    );
  }

// 抽屉（Drawer）部分
  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          // 顶部用户信息部分
          UserAccountsDrawerHeader(
            accountName: Text("怪你过分美丽"),
            accountEmail: Text("13221001308@example.com"),
            currentAccountPicture: ClipRRect(
              child: Hero(
                tag: 'testTag',
                child: Image.network(headImg),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          // 菜单项
          ListTile(
            leading: Icon(Icons.home),
            title: Text("主页"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("收藏"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("设置"),
            onTap: () {
              context.push('/test');
              // Navigator.pop(context);
            },
          ),
          Spacer(), // 让退出按钮固定在底部
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: Text("退出登录", style: TextStyle(color: Colors.red)),
            onTap: () {
              // 在这里添加退出逻辑
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required int num,
    required String title,
  }) {
    return Column(
      children: [
        Text(
          num.toString(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        )
      ],
    );
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {required this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: color,
      child: widget,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}
