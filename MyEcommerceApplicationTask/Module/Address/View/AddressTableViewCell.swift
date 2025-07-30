//
//  AddressTableViewCell.swift
//  MyEcommerceApplicationTask
//
//  Created by Akshay Nena on 17/07/25.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var btndelete: UIButton!
    @IBOutlet weak var btnedit: UIButton!
    @IBOutlet weak var lbladdressid: UILabel!
    @IBOutlet weak var lblpincode: UILabel!
    @IBOutlet weak var lbladdress2: UILabel!
    @IBOutlet weak var lbladdress1: UILabel!
    @IBOutlet weak var lblcity: UILabel!
    @IBOutlet weak var lblstate: UILabel!
    @IBOutlet weak var lbldob: UILabel!
    @IBOutlet weak var lblmobile: UILabel!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lbllastname: UILabel!
    @IBOutlet weak var lblfirstname: UILabel!
    
    var btneditclick: (() -> Void)?
    var btndeleteclick: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func btndeleteclick(_ sender: Any) {
        print("delete cell function")
        btndeleteclick?()
        
    }
    @IBAction func btneditclick(_ sender: Any) {
       
        btneditclick?()
    }
    func configurecelladdress(address:AddressModel){
        self.lblfirstname.text = address.strFirstName
        self.lbllastname.text = address.strLastName
        self.lblemail.text = address.strEmail
        self.lblmobile.text = address.strMobile
        self.lbldob.text = address.strDob
        self.lblcity.text = address.strCity
        self.lblstate.text = address.strState
        self.lbladdress1.text = address.strAddress1
        self.lbladdress2.text = address.strAddress2
        self.lblpincode.text = address.strPincode
    }
    
}
