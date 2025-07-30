

import UIKit

class AddressListViewController: UIViewController {

    @IBOutlet weak var lblempty: UILabel!
    @IBOutlet weak var btnaddform: UIButton!
    @IBOutlet weak var tbladdress: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbladdress.showsVerticalScrollIndicator = false
        self.title = "Address List"
    
        EditStyle.setborder(textfields: [btnaddform])
        tbladdress.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressTableViewCell")
    
        if addresslist.isEmpty {
            lblempty.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) 
        tbladdress.reloadData()
        
        lblempty.isHidden = !addresslist.isEmpty
    }

    @IBAction func btnaddformclick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        if let Avc = storyboard.instantiateViewController(withIdentifier: "AddressViewController") as? AddressViewController {
            self.navigationController?.pushViewController(
                Avc,
                animated: true
            )
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        if let Avc = storyboard.instantiateViewController(withIdentifier: "AddressViewController") as? AddressViewController {
            Avc.objaddress = addresslist[indexPath.row]
            self.navigationController?.pushViewController(
                Avc,
                animated: true
            )
        }
    }
    
}
