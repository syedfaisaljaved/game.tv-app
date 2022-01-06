
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:game_tv/model/game_tournament.dart';
import 'package:game_tv/repo/tournament_repo.dart';

class TournamentBloc extends Bloc<TournamentEvent, TournamentState> {
  final TournamentRepo tournamentRepo;

  TournamentBloc({this.tournamentRepo}) : super(InitTournamentState());

  @override
  Stream<TournamentState> mapEventToState(TournamentEvent event) async* {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!(connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi)) {
      /// not connected to internet
      Fluttertoast.showToast(msg: "No Internet Connection", toastLength: Toast.LENGTH_SHORT);
      return;
    }

    if(event is GetTournamentData){
      yield LoadingTournamentState();
      var data = await tournamentRepo.getTournaments(10, event.cursor);
      if(data.success)
        yield SuccessTournamentData(data.data);
      else
        yield ErrorTournamentState();
    }
    
  }
}


abstract class TournamentEvent extends Equatable {
  const TournamentEvent();
}

class GetTournamentData extends TournamentEvent {
  final String cursor;
  GetTournamentData(this.cursor);

  @override
  List<Object> get props {}
}

abstract class TournamentState extends Equatable {
  const TournamentState();
}

class InitTournamentState extends TournamentState {
  const InitTournamentState();

  @override
  List<Object> get props => [];
}

class LoadingTournamentState extends TournamentState {
  const LoadingTournamentState();

  @override
  List<Object> get props => [];
}

class ErrorTournamentState extends TournamentState {
  const ErrorTournamentState();

  @override
  List<Object> get props => [];
}

class SuccessTournamentData extends TournamentState {
  final Data data;
  const SuccessTournamentData(this.data);

  @override
  List<Object> get props {}
}
