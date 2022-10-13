import 'package:ecommerce/model/imports/generalImport.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
        viewModelBuilder: () => SplashScreenViewModel(),
    onModelReady: (model) async {
    model.future(context);
    },
    disposeViewModel: false,
    builder: (context, model, child) =>baseUi(children: [
      Center(
        child:  S(
                h:200,w:200,
                child: Hero(
                    tag: "appLogo",
                    child: Image.asset("assets/appLogo.jpeg"))),

        ),

  ], allowBackButton: false));
  }
}
