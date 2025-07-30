import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var lbldob: UILabel!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var selectdate: UIButton!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var setbtn: UIButton!
    @IBOutlet weak var registerbtn: UIButton!
    @IBOutlet weak var viewdate: UIView!

    var placeholderText = "Date of Birth"

    @IBAction func selectdateclick(_ sender: Any) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels

        let alert = UIAlertController(
            title: "Select Date of Birth",
            message: "\n\n\n\n\n\n\n\n\n",
            preferredStyle: .actionSheet
        )
        alert.isModalInPresentation = true

        datePicker.frame = CGRect(
            x: 0,
            y: 30,
            width: alert.view.bounds.width - 20,
            height: 200
        )
        alert.view.addSubview(datePicker)

        let ok = UIAlertAction(title: "Done", style: .default) { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            self.lbldob.text = formatter.string(from: datePicker.date)
            self.lbldob.textColor = .black
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            if self.lbldob.text == self.placeholderText {
                self.lbldob.textColor = .lightGray
            }
        }

        alert.addAction(ok)
        alert.addAction(cancel)

        self.present(alert, animated: true, completion: nil)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }

var strRegisterTitle: PageType = .Register

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtName.tag = 0
        txtEmail.tag = 1
        txtPassword.tag = 2
        txtConfirmPassword.tag = 3
        
        lbldob.text = placeholderText
        lbldob.textColor = .lightGray

        EditStyle.setborder(textfields: [txtName,txtEmail,viewdate,txtPassword,txtConfirmPassword,registerbtn])
        
        EditStyle.setPadding(textFields: [txtName,txtEmail,viewdate,txtPassword,txtConfirmPassword], paddingWidth: 10)
    
        if strRegisterTitle == .EditProfile {
            self.title = "Edit Profile"
            registerbtn.setTitle("Update", for: .normal)
        } else {
            self.title = "Register"
        }
    }

    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$"#
        let passwordPredicate = NSPredicate(
            format: "SELF MATCHES %@",
            passwordRegex
        )
        return passwordPredicate.evaluate(with: password)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }

    @IBAction func BtnDoneClick(_ sender: Any) {
        let name = txtName.text ?? ""
        let email = txtEmail.text ?? ""
        let password = txtPassword.text ?? ""
        let confirmPassword = txtConfirmPassword.text ?? ""

        if name.isEmpty && email.isEmpty && lbldob.text == ""
            && password.isEmpty && confirmPassword.isEmpty
        {
            UIAlertController.showAlert(
                title: "Missing Info",
                message: "Please fill the data!",
                viewController: self
            )
        } else if name.isEmpty {
            UIAlertController.showAlert(
                title: "Name Missing",
                message: "Please Enter Your Name",
                viewController: self
            )
        } else if email.isEmpty {
            UIAlertController.showAlert(
                title: "Email Missing",
                message: "Please Enter Your Email",
                viewController: self
            )
        } else if !UIAlertController.isValidEmail(txtEmail.text ?? "") {
            UIAlertController.showAlert(
                title: "Invalid Email",
                message: "Please enter a valid email address.",
                viewController: self
            )
            return
        } else if lbldob.text == "" {
            UIAlertController.showAlert(
                title: "DOB is Missing",
                message: "Please Select Your Date of Birth",
                viewController: self
            )
        }
         else if password.isEmpty {
            UIAlertController.showAlert(
                title: "Password Missing",
                message: "Please Set Your Password",
                viewController: self
            )
        } else if !UIAlertController.isValidPassword(txtPassword.text ?? "") {
            UIAlertController.showAlert(
                title: "Invalid Password",
                message:
                    "Password must be at least 8 characters long, contain at least 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character.",
                viewController: self
            )
            return
        } else if password != confirmPassword {
            UIAlertController.showAlert(
                title: "Passwords do not match",
                message:
                    "The Password and confirm password fields must be the same. Please try again?",
                viewController: self
            )
        } else {
            let storyboard = UIStoryboard(
                name: "ProductStoryBoard",
                bundle: nil
            )
            if let registervc = storyboard.instantiateViewController(
                withIdentifier: "ProductViewController"
            ) as? ProductViewController {
                self.navigationController?.pushViewController(
                    registervc,
                    animated: true
                )
            }
        }
    }
}
