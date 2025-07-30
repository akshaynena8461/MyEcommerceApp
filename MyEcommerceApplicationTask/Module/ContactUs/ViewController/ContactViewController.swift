import UIKit

class ContactViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var txtmsg: UITextView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var sendmsgbtn: UIButton!

    let placeholderText = "Enter your message here..."

    override func viewDidLoad() {
        super.viewDidLoad()

        sendmsgbtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21)

        self.title = "Contact Us"

        EditStyle.setborder(textfields: [txtName, txtEmail, txtmsg, sendmsgbtn])
        EditStyle.setPadding(textFields: [txtName, txtEmail], paddingWidth: 10)

        txtmsg.textContainerInset = UIEdgeInsets(
            top: 8,
            left: 5,
            bottom: 8,
            right: 10
        )

        txtmsg.text = placeholderText
        txtmsg.textColor = .lightGray

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

    @IBAction func sendmsg(_ sender: Any) {
        let name =
            txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email =
            txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let message =
            txtmsg.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if name.isEmpty && email.isEmpty && message.isEmpty {
            UIAlertController.showAlert(
                title: "All Fields Empty",
                message: "Please enter your Name, Email, and Message",
                viewController: self
            )
            return
        }

        else if name.isEmpty {
            UIAlertController.showAlert(
                title: "Name Missing",
                message: "Please enter your name",
                viewController: self
            )
            return
        }

        else if email.isEmpty {
            UIAlertController.showAlert(
                title: "Email Missing",
                message: "Please enter your email",
                viewController: self
            )
            return
        }

        else if message.isEmpty {
            UIAlertController.showAlert(
                title: "Message Missing",
                message: "Please enter your message",
                viewController: self
            )
            return
        }

    }

}
