




import UIKit



class SettingViewController: UIViewController {

    @IBOutlet weak var settingtblview: UITableView!
    
    var arrSettingLabels:[Settinglabels] = Settinglabels.addsettingdata()
    var arrSettingSection:[SettingSection] = [];
    var productList:[ProductModel] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        settingtblview.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCell")
        
        arrSettingSection.append(SettingSection(strTitle: "User", arrSettingOptions: arrSettingLabels.filter{$0.objSettingCategory == .User}))
        arrSettingSection.append(SettingSection(strTitle: "Contact Us", arrSettingOptions: arrSettingLabels.filter{$0.objSettingCategory == .ContactIUs}))
        arrSettingSection.append(SettingSection(strTitle: "Logout", arrSettingOptions: arrSettingLabels.filter{$0.objSettingCategory == .Logout}))
        
        UITableView.appearance().sectionHeaderTopPadding = 0
    
        print("arrsettingsection : ",arrSettingSection)

    }
    
}
