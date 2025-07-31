

import Foundation
import UIKit

extension AddressViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return isSelectingState ? stateList.count : cityList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return isSelectingState ? stateList[row] : cityList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isSelectingState {
            selectedState = stateList[row]
            txtstate.text = selectedState

            // Load cities for the selected state
            cityList = AddressModel.cities(forState: selectedState!)
            txtcity.text = "" // reset city if state changes
            txtcity.isUserInteractionEnabled = true
        } else {
            selectedCity = cityList[row]
            txtcity.text = selectedCity
        }
    }
}

extension AddressViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtstate {
            isSelectingState = true
            pickerView.reloadAllComponents()
            if let selectedState = txtstate.text,
               let index = stateList.firstIndex(of: selectedState) {
                pickerView.selectRow(index, inComponent: 0, animated: false)
            }
        } else if textField == txtcity {
            isSelectingState = false
            if txtstate.text?.isEmpty ?? true {
                UIAlertController.showAlert(title: "Error", message: "Please select a state first.", viewController: self)
                textField.resignFirstResponder()
            } else {
                pickerView.reloadAllComponents()
                if let selectedCity = txtcity.text,
                   let index = cityList.firstIndex(of: selectedCity) {
                    pickerView.selectRow(index, inComponent: 0, animated: false)
                }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if textField == txtstate || textField == txtcity {
               return false
           }
           return true
       }

}
