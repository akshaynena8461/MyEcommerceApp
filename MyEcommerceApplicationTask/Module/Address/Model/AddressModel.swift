
import Foundation

class AddressModel{
    
    var strFirstName:String = "";
    var strLastName:String = "";
    var strEmail:String = "";
    var strMobile:String = "";
    var strDob:String = "";
    var strState:String = "";
    var strCity:String = "";
    var strAddress1:String = "";
    var strAddress2:String = "";
    var strPincode:String = "";
    
    init(strFirstName: String, strLastName: String, strEmail: String, strMobile: String, strDob: String, strState: String, strCity: String, strAddress1: String, strAddress2: String, strPincode: String) {
        self.strFirstName = strFirstName
        self.strLastName = strLastName
        self.strEmail = strEmail
        self.strMobile = strMobile
        self.strDob = strDob
        self.strState = strState
        self.strCity = strCity
        self.strAddress1 = strAddress1
        self.strAddress2 = strAddress2
        self.strPincode = strPincode
    }
    
    
}
