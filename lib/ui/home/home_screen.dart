import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_tv/bloc/tournament_bloc.dart';
import 'package:game_tv/db/hive_provider.dart';
import 'package:game_tv/model/game_tournament.dart';
import 'package:game_tv/repo/tournament_repo.dart';
import 'package:game_tv/ui/login/login_screen.dart';
import 'package:game_tv/utils/constants/color_const.dart';
import 'package:game_tv/utils/constants/img_constants.dart';
import 'package:game_tv/utils/constants/string_const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool _langEng = true;
  List<Tournaments> _tournamentsList = [];
  TournamentBloc _tournamentBloc;
  String _cursor;
  bool fetchedApi = true;
  ScrollController _scrollController;

  @override
  void initState() {
    _tournamentBloc = TournamentBloc(tournamentRepo: TournamentRepo());
    _tournamentBloc.add(GetTournamentData(null));
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _tournamentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: colorWhite,
      drawer: _drawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorWhite,
        leading: InkWell(
          onTap: () => _key.currentState.openDrawer(),
          child: Icon(
            Icons.menu,
            color: colorBlack,
          ),
        ),
        title: Text(
          appName,
          style: TextStyle(
            color: colorBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          if (_scrollController.offset ==
              notification.metrics.maxScrollExtent && fetchedApi) {
            setState(() {
              fetchedApi = false;
            });
            _tournamentBloc.add(GetTournamentData(_cursor));
            return true;
          }
          return false;
        },
        child: ListView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            _header(),
            _leaderBoard(),
            Text(
              _langEng ? recommended_en : recommended_jp,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: colorBlack, fontSize: 20),
            ),
            _listView(),
          ],
        ),
      ),
    );
  }

  Widget _listView() => BlocProvider(
        create: (context) => _tournamentBloc,
        child: BlocConsumer(
            cubit: _tournamentBloc,
            listener: (context, state) {
              if (state is SuccessTournamentData) {
                setState(() {
                  _tournamentsList.addAll(state.data.tournaments);
                  _cursor = state.data.cursor;
                  fetchedApi = true;
                });
              }
            },
            builder: (context, state) {
              if (_tournamentsList.isEmpty)
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(colorBlack),),
                  ),
                );

              return Column(
                children: [
                  ListView(
                    primary: false,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 20),
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(_tournamentsList.length,
                        (index) => _listItem(_tournamentsList[index])),
                  ),
                  if (state is LoadingTournamentState)
                    SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(colorBlack),),
                      ),
                    ),
                ],
              );
            }),
      );

  Widget _listItem(Tournaments tournament) => Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: colorWhite,
      boxShadow: [
        BoxShadow(offset: Offset(2,2), color: Colors.grey[300], blurRadius: 20),
      ]
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(20), bottom: Radius.zero),
          child: Image.network(
            tournament.coverUrl,
            fit: BoxFit.cover,
            height: 80,
            width: double.maxFinite,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text(
                    tournament.gameName,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text(
                    tournament.gameFormat,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.chevron_right, color: colorBlack,),
            ),
          ],
        )
      ],
    ),
  );

  Widget _leaderBoard() => Container(
        height: 80,
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(20), right: Radius.zero),
                    gradient: LinearGradient(
                      colors: [gradOrangeOne, gradOrangeTwo],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "34",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _langEng ? tnP_en : tnP_jp,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorWhite,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              color: colorWhite,
              thickness: 1,
              width: 1,
            ),
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [gradPurpleOne, gradPurpleTwo],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "09",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _langEng ? tnW_en : tnW_jp,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorWhite,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              color: colorWhite,
              thickness: 1,
              width: 1,
            ),
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.zero, right: Radius.circular(20)),
                  gradient: LinearGradient(
                    colors: [gradPeachOne, gradPeachTwo],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "26%",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _langEng ? WinP_en : WinP_jp,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorWhite,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Widget _header() => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
                child: Image.asset(
              personImage,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            )),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _langEng ? name_en : name_jp,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: colorBlack,
                      fontSize: 20),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: colorBlue),
                  ),
                  padding:
                      EdgeInsets.only(left: 12, right: 30, top: 6, bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        score,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: colorBlue,
                            fontSize: 18),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        _langEng ? rating_en : rating_jp,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: colorBlack,
                            fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _drawer() => Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                    color: colorBlack,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Choose Language",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorBlack,
                    fontSize: 16),
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  _langEng = true;
                });
                Navigator.pop(context);
              },
              contentPadding: EdgeInsets.only(left: 40),
              dense: true,
              title: Text(
                "English",
                style: TextStyle(
                  fontSize: 14,
                  color: colorBlack,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                setState(() {
                  _langEng = false;
                });

                Navigator.pop(context);
              },
              contentPadding: EdgeInsets.only(left: 40),
              dense: true,
              title: Text(
                "Japanese",
                style: TextStyle(
                  fontSize: 14,
                  color: colorBlack,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Spacer(),
            ListTile(
              onTap: () async {
                await HiveProvider.setUserLoggedOut();
                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginScreen(),));
              },
              contentPadding: EdgeInsets.only(left: 20),
              leading: Icon(
                Icons.logout,
                color: colorBlack,
                size: 20,
              ),
              title: Text(
                "Sign Out",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorBlack,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
}
