



import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchView extends StatelessWidget {

  final String initialState;
  final Map<String, Widget> views;
  const SwitchView({
    required this.views, required this.initialState, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SwitchViewCubit>(
        create: (context) { return SwitchViewCubit(initialState); },
      child: BlocBuilder<SwitchViewCubit, String>(
        builder: (context, currentView){
          return views[currentView]!;
        }
      ),

    );
  }
}


class SwitchViewCubit extends Cubit<String> {

  SwitchViewCubit(super.initialState);


  switchView(String newView) {
    emit(newView);
  }
}
