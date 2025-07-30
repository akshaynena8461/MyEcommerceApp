import UIKit

class LoginViewController: UIViewController, UIPointerInteractionDelegate {
    
    @IBOutlet weak var btnforgot: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBOutlet weak var btnlogin: UIButton!
    @IBOutlet weak var btnregister: UIButton!
    @IBOutlet weak var imgview: UIImageView!
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        self.title = "Log in"
        super.viewDidLoad()
        
        EditStyle.setborder(textfields: [txtEmail,txtPassword,btnlogin])
        EditStyle.setPadding(textFields: [txtEmail,txtPassword], paddingWidth: 10)
    }

    @IBAction func loginSuccess(_ sender: Any) {
        if txtEmail.text == "" && txtPassword.text == "" {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter your email and password.", viewController: self)
        }

        else  if !UIAlertController.isValidEmail(txtEmail.text ?? "") {
            UIAlertController.showAlert(
                title: "Invalid Email",
                message: "Please enter a valid email address.",
                viewController: self
            )
            return
        }
        
        else if !UIAlertController.isValidPassword(txtPassword.text ?? "") {
                UIAlertController.showAlert(
                    title: "Invalid Password",
                    message: """
                             Password must be at least 8 characters long, 
                             contain at least 1 uppercase letter, 
                             1 lowercase letter, 1 number, and 1 special character.
                             """,
                    viewController: self
                )
                return
            }
        
        else {
            print("login success")

            KeychainHelper.save(key: "LoginStatus", value: "true")

            let storyboard = UIStoryboard(
                name: "ProductStoryBoard",
                bundle: nil
            )
            if let vc = storyboard.instantiateViewController(
                withIdentifier: "ProductViewController"
            ) as? ProductViewController {
                self.navigationController?.pushViewController(
                    vc,
                    animated: true
                )
            }
        }
    }
    
    @IBAction func registeruser(_ sender: Any) {
        print("Register tapped")
        
        let userStoryboard = UIStoryboard(name: "User", bundle: nil)
        if let formVC = userStoryboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
            self.navigationController?.pushViewController(formVC, animated: true)
        }
    }
    
    @IBAction func btnforgotclick(_ sender: Any) {
        print("hello")
        
        let alert = UIAlertController(
            title: "Enter Email",
            message: "Please enter your email address",
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.placeholder = "Email"
            textField.keyboardType = .emailAddress
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            guard let email = alert.textFields?.first?.text, !email.isEmpty else {
                UIAlertController.showAlert(
                    title: "Missing Email",
                    message: "Please enter your email address.",
                    viewController: self
                )
                return
            }
            
            if !UIAlertController.isValidEmail(email) {
                UIAlertController.showAlert(
                    title: "Invalid Email",
                    message: "Please enter a valid email address.",
                    viewController: self
                )
            } else {
                UIAlertController.showAlert(title: "Success", message: "Email is Valid", viewController: self)
                print("Valid email: \(email)")
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(cancelAction)
        alert.addAction(submitAction)

        self.present(alert, animated: true)
    }
}
extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail && textField.returnKeyType == .next {
            txtEmail.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        } else {
            txtPassword.resignFirstResponder()
        }
        return true
    }
}


