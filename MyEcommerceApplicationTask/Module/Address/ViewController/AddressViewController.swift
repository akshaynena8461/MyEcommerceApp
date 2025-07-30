

import UIKit
var addresslist:[AddressModel] = []

class AddressViewController: UIViewController {
    
    @IBOutlet weak var AddressScrollView: UIScrollView!
    @IBOutlet weak var btnsubmit: UIButton!
    @IBOutlet weak var txtpincode: UITextField!
    @IBOutlet weak var txtaddress2: UITextField!
    @IBOutlet weak var txtaddress1: UITextField!
    @IBOutlet weak var txtcity: UITextField!
    @IBOutlet weak var txtstate: UITextField!
    @IBOutlet weak var txtdob: UITextField!
    @IBOutlet weak var txtmobile: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtlastname: UITextField!
    @IBOutlet weak var txtfirstname: UITextField!
    
    var objaddress:AddressModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Address"
        AddressScrollView.showsVerticalScrollIndicator = false
      
        if let obj = objaddress{
            self.title = "Edit Address"
            btnsubmit.setTitle("Update", for: .normal)
            txtfirstname.text = obj.strFirstName
            txtlastname.text = obj.strLastName
            txtemail.text = obj.strEmail
            txtmobile.text = obj.strMobile
            txtdob.text = obj.strDob
            txtstate.text = obj.strState
            txtcity.text = obj.strCity
            txtaddress1.text = obj.strAddress1
            txtaddress2.text = obj.strAddress2
            txtpincode.text = obj.strPincode
        }
        
        EditStyle.setborder(textfields: [txtfirstname,txtlastname,txtemail,txtmobile,txtdob,txtstate,txtcity,txtaddress1,txtaddress2,txtpincode,btnsubmit])
     
        
        EditStyle.setPadding(textFields: [txtfirstname,txtlastname,txtemail,txtmobile,txtdob,txtdob,txtstate,txtcity,txtaddress1,txtaddress2,txtpincode],paddingWidth: 10)
     
    }

    @IBAction func btnsubmitclick(_ sender: Any) {
        
        let firstName = txtfirstname.text ?? ""
        let lastName = txtlastname.text ?? ""
        let email = txtemail.text ?? ""
        let mobile = txtmobile.text ?? ""
        let dob = txtdob.text ?? ""
        let state = txtstate.text ?? ""
        let city = txtcity.text ?? ""
        let address1 = txtaddress1.text ?? ""
        let address2 = txtaddress2.text ?? ""
        let pincode = txtpincode.text ?? ""
        
        if firstName.isEmpty {
            UIAlertController.showAlert(title: "Error", message: "Please enter your first name.",viewController: self)
            return
        }
        
        if lastName.isEmpty {
            UIAlertController.showAlert(title: "Error", message: "Please enter your last name.",viewController: self)
            return
        }
        
        
        if email.isEmpty {
            UIAlertController.showAlert(title: "Error", message: "Please enter your email.",viewController: self)
            return
        }
        
        
        if mobile.isEmpty {
            UIAlertController.showAlert(title: "Error", message: "Please enter your mobile number.",viewController: self)
            return
            
        }
        if dob.isEmpty {
            UIAlertController.showAlert(title: "Error", message: "Please enter your date of birth.",viewController: self)
            return
        }
        
        if state.isEmpty {
            UIAlertController.showAlert(title: "Error", message: "Please enter your state.",viewController: self)
            return
        }
        
        if city.isEmpty {
            UIAlertController.showAlert(title: "Error", message: "Please enter your city.",viewController: self)
            return
        }
        
        if address1.isEmpty {
            UIAlertController.showAlert(title: "Error", message: "Please enter address line 1.",viewController: self)
            return
        }
        
        if address2.isEmpty {
            UIAlertController.showAlert(title: "Error", message: "Please enter address line 1.",viewController: self)
            return
        }
        
        
        
        if pincode.isEmpty {
            UIAlertController.showAlert(title: "Error", message: "Please enter your pincode.",viewController: self)
            return
        }
    
        if objaddress != nil{
            objaddress?.strFirstName = txtfirstname.text ?? ""
            objaddress?.strLastName = txtlastname.text ?? ""
            objaddress?.strEmail = txtemail.text ?? ""
            objaddress?.strMobile = txtmobile.text ?? ""
            objaddress?.strDob = txtdob.text ?? ""
            objaddress?.strState = txtstate.text ?? ""
            objaddress?.strAddress1 = txtaddress1.text ?? ""
            objaddress?.strAddress2 = txtaddress2.text ?? ""
            objaddress?.strCity = txtcity.text ?? ""
            objaddress?.strPincode = txtpincode.text ?? ""
            print("txtpincode.text : ",txtpincode.text ?? "")
    
        }
        else {
            let obj = AddressModel(strFirstName: txtfirstname.text ?? "", strLastName: txtlastname.text ?? "", strEmail: txtemail.text ?? "" , strMobile: txtmobile.text ?? "", strDob: txtdob.text ?? "", strState: txtstate.text ?? "" , strCity: txtcity.text ?? "" , strAddress1: txtaddress1.text ?? "", strAddress2: txtaddress2.text ?? "" , strPincode: txtpincode.text ?? "")
            addresslist.append(obj)

        }
        
        print("addresslist : " ,addresslist)
        print("Address count: \(addresslist.count)")
        self.navigationController?.popViewController(animated: true)

    }

}
    


