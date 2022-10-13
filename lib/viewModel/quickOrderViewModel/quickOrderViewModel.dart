

import '../../model/imports/generalImport.dart';

class QuickOrderViewModel extends BaseModel{
  // cart value
  int priceValue=1;

  // increment value
  increment(){
    priceValue++;
    notifyListeners();
  }

  // decrement value
  decrement(){
    if(priceValue==1){

    }
    else{
      priceValue--;
      notifyListeners();
    }
  }

   updateCurrencyDropdown(String value, BuildContext context) {
    loadedCurrencyString=value;
    notifyListeners();
   }


}