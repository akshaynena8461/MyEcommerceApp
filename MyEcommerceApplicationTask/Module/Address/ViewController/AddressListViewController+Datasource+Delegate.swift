

import Foundation
import UIKit

extension AddressListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresslist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
         
        tableView.allowsSelection = false

        cell.lbladdressid.text = "Address Id : \(indexPath.row + 1)"
        cell.configurecelladdress(address: addresslist[indexPath.row])
        cell.btndelete.layer.borderWidth = 1
        cell.btndelete.layer.cornerRadius = 10
        cell.btnedit.layer.borderWidth = 1
        cell.btnedit.layer.cornerRadius = 10
        cell.btneditclick = {
            let storyboard = UIStoryboard(name: "User", bundle: nil)
            if let Avc = storyboard.instantiateViewController(withIdentifier: "AddressViewController") as? AddressViewController {
                Avc.objaddress = addresslist[indexPath.row]
                self.navigationController?.pushViewController(
                    Avc,
                    animated: true
                )
            }
        }
        cell.btndeleteclick = {
            print("delete cell")
            UIAlertController.showAlert(title: "Success", message: "Address Deleted Successfully", viewController: self)
            addresslist.remove(at: indexPath.row)
            self.lblempty.isHidden = !addresslist.isEmpty
            self.tbladdress.reloadData()
        }

        return cell
    }
    
}

