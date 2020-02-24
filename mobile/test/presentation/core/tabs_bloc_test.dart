import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_time/presentation/core/blocs/tabs/bloc.dart';
import 'package:coffee_time/presentation/models/app_tab.dart';

void main() {
  blocTest(
    'Should emit cafeList as default',
    build: () => TabsBloc(),
    expect: [AppTabKey.cafeList],
  );

  blocTest(
    'Emits passed tab',
    build: () => TabsBloc(),
    act: (bloc) => bloc.add(SetTab(AppTabKey.settings)),
    expect: [AppTabKey.cafeList, AppTabKey.settings],
  );
}
