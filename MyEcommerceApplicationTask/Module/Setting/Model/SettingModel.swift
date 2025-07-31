

import Foundation

class Settinglabels: NSObject {
    var strTitle:String = "";
    var intTag:Int = 0
    var strImage:String = ""
    var objSettingCategory:SettingCategory = .User

   
    init( strTitle: String,intTag: Int, strImage: String,objSettingCategory:SettingCategory = .User) {
        self.strTitle = strTitle
        self.intTag = intTag
        self.strImage = strImage
        self.objSettingCategory = objSettingCategory
    }
    
    
    class func addsettingdata() -> [Settinglabels] {
        return [
            Settinglabels(strTitle: "Push Notification",
                          intTag:7 ,
                          strImage: "bell.badge"),
            Settinglabels(strTitle: "About Us",
                          intTag: 0,
                          strImage: "info.circle",
                               objSettingCategory: .ContactIUs),
                 Settinglabels(strTitle: "Privacy Policy", intTag: 1, strImage: "lock.shield",objSettingCategory: .ContactIUs),
                 Settinglabels(strTitle: "Terms & Conditions", intTag: 2, strImage: "doc.plaintext",objSettingCategory: .ContactIUs),
                 Settinglabels(strTitle: "Contact Us", intTag: 3, strImage: "phone",objSettingCategory: .ContactIUs),
                 Settinglabels(strTitle: "Wishlist", intTag: 4, strImage: "heart"),
                 Settinglabels(strTitle: "Edit Profile", intTag: 5, strImage:"person.crop.circle"),
                 Settinglabels(strTitle: "Logout", intTag: 6, strImage: "arrow.backward.square",objSettingCategory: .Logout)
        ]
    }
    
    func printData() -> String{
        return strTitle
    }
}

enum SettingCategory: String {
    case User = "User"
    case ContactIUs = "Contact IUs"
    case Logout = "Logout"
}

class SettingSection: NSObject {
    var strTitle:String = "";
    var arrSettingOptions:[Settinglabels] = [];
    
    init( strTitle: String,arrSettingOptions: [Settinglabels]) {
        self.strTitle = strTitle
        self.arrSettingOptions = arrSettingOptions
    }
}
