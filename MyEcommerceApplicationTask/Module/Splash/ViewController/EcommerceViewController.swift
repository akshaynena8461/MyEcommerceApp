
import UIKit

class EcommerceViewController: UIViewController {

        override func viewDidLoad() {
            super.viewDidLoad()

        }

        override func viewDidAppear(_ animated: Bool) {
            sleep(3)
            if KeychainHelper.get(key: "LoginStatus") == "true" {
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
            else {
                let storyboard = UIStoryboard(name: "User", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }
    }
