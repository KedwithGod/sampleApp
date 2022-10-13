import 'package:ecommerce/model/imports/generalImport.dart';

// get new thhings

class AccountViewModel extends BaseModel {
  // transaction list
  List transactionList = [];
  // order list
  List orderList = [];
  // wallet data
  WalletBalanceResponse? walletData;
  // user data
  UserResponse? userData;
  // fetch user data,transaction and wallet
  userDetails(BuildContext context) async {
    try {
      // loading
      SchedulerBinding.instance?.addPostFrameCallback((_) => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return dialogBox(
              context,
              "Fetching account data",
              'Profile page',
              DialogType.processing,
              function: () {},
              dismissText: "",
            );
          }));
      // get wooCommerce id
      String? wooCommerceIds = await LocalStorage.getString(wooCommerceId);

      // fetch user data
      userData =
          await WooCommerceUser.fetchNewWooCommerceUser(id: wooCommerceIds);
      notifyListeners();
      // fetch wallet balance
      walletData = await WooCommerceCustomerBalance.fetchCustomerWalletBalance(
          email: userData!.email);
      notifyListeners();
      // fetch transaction list
      transactionList =
          await WooCommerceCustomerTransaction.fetchCustomerTransaction(
                  email: userData!.email)
              .catchError((onError) {
        Navigator.pop(context);
        // show dialog for login Error
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return dialogBox(
                context,
                onError,
                'Profile',
                DialogType.error,
                dismissText: "try again",
                function: () {
                  Navigator.pop(context);
                },
              );
            });
      });
      notifyListeners();
      Navigator.pop(context);
    } catch (loginError) {
      Navigator.pop(context);
      // show dialog for login Error
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return dialogBox(
              context,
              "Error occur while setting up account, try again",
              'Profile',
              DialogType.error,
              dismissText: "try again",
              function: () {
                Navigator.pop(context);
              },
            );
          });
    }
  }

  // fetch all order function

  fetchAllOrderFunction(BuildContext context) async {
    try {
      await AllOrder.fetchAllOrderService().then((value) {
        if (value is List) {
          orderList =
              value.where((element) => element['customer_id'] == 0).toList();
          notifyListeners();
        } else if (value is Map) {
          final snackBar = SnackBar(
            content: GeneralTextDisplay('Unable to fetch currency List',
                primary, 1, 12, FontWeight.w400, 'error'),
          );
          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } catch (error) {
      if (error is SocketException) {
        final snackBar = SnackBar(
          content: GeneralTextDisplay(
              'Unable to connect, kindly check your internet connection',
              primary,
              1,
              12,
              FontWeight.w400,
              'error'),
        );
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: GeneralTextDisplay(
              error.toString(), primary, 1, 12, FontWeight.w400, 'error'),
        );
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
