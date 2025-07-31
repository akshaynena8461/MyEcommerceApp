import Foundation
import UIKit

extension SettingViewController: UITableViewDelegate {

}

extension SettingViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {

        let objSection = arrSettingSection[section]
        let objdata = objSection.arrSettingOptions.count

        return objdata

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell: SettingTableViewCell =
            tableView.dequeueReusableCell(
                withIdentifier: "SettingTableViewCell",
                for: indexPath
            ) as! SettingTableViewCell

        let sectiondata = arrSettingSection[indexPath.section]
        let sectionOption = sectiondata.arrSettingOptions[indexPath.row]

        //        cell.configureCell(product:arrSettingLabels[indexPath.row])
        cell.configureCell(product: sectionOption)

        cell.selectionStyle = .none

        print("hello")
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSettingSection.count
    }

    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {

        let width = tableView.bounds.width
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 50))

        let lblHeaderName = UILabel(frame: CGRect(x: 16, y: 0, width: width - 32, height: 50))

        lblHeaderName.text = arrSettingSection[section].strTitle
        lblHeaderName.font = UIFont.boldSystemFont(ofSize: 21)
        lblHeaderName.textAlignment = .left

        view.addSubview(lblHeaderName)

        return view

    }

    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return 50
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        let selectedItem = arrSettingSection[indexPath.section]
            .arrSettingOptions[indexPath.row].intTag

        switch selectedItem
        {

        case 0:
            print("about us")

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let aboutvc = storyboard.instantiateViewController(
                withIdentifier: "WebViewController"
            ) as? WebViewController {
                aboutvc.objPageType = .AboutUs
                self.navigationController?.pushViewController(
                    aboutvc,
                    animated: true
                )
            }

        case 1:

            print("privacy and policy")

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let privacyvc = storyboard.instantiateViewController(
                withIdentifier: "WebViewController"
            ) as? WebViewController {
                privacyvc.objPageType = .PrivacyPolicy
                self.navigationController?.pushViewController(
                    privacyvc,
                    animated: true
                )

            }

        case 2:
            print("term and condition")

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let termsAndconditionvc = storyboard.instantiateViewController(
                withIdentifier: "WebViewController"
            ) as? WebViewController {
                termsAndconditionvc.objPageType = .TermsAndConditions
                self.navigationController?.pushViewController(
                    termsAndconditionvc,
                    animated: true
                )

            }

        case 3:

            print("ContactViewController")

            let storyboard = UIStoryboard(name: "Setting", bundle: nil)
            if let ContactVc = storyboard.instantiateViewController(
                withIdentifier: "ContactViewController"
            ) as? ContactViewController {
                self.navigationController?.pushViewController(
                    ContactVc,
                    animated: true
                )

            }

        case 4:

            print("WishListViewController")
            let storyboard = UIStoryboard(
                name: "ProductStoryBoard",
                bundle: nil
            )
            if let Wishlistvc = storyboard.instantiateViewController(
                withIdentifier: "ProductViewController"
            ) as? ProductViewController {

                Wishlistvc.filteredProducts = app.arrWishlist
                Wishlistvc.arrProduct = app.arrWishlist
                Wishlistvc.strProductTitle = .Wishlist
                
                self.navigationController?.pushViewController(
                    Wishlistvc,
                    animated: true
                )

            }

        case 5:

            print("EditProfileViewController")

            let storyboard = UIStoryboard(name: "User", bundle: nil)
            if let editProfileVC = storyboard.instantiateViewController(
                withIdentifier: "RegisterViewController"
            ) as? RegisterViewController {

                editProfileVC.strRegisterTitle = .EditProfile

                self.navigationController?.pushViewController(
                    editProfileVC,
                    animated: true
                )
            }

        case 6:
            print("Logout button tapped")
 
            KeychainHelper.delete(key: "LoginStatus")
   
            let alert = UIAlertController(
                title: "Logout",
                message: "Are you sure you want to logout?",
                preferredStyle: .alert
            )

            let okaction = UIAlertAction(title: "Logout", style: .destructive) {
                (_) in
                let storyboard = UIStoryboard(name: "User", bundle: nil)
                if let vc = storyboard.instantiateViewController(
                    withIdentifier: "LoginViewController"
                ) as? LoginViewController {
                    self.navigationController?.pushViewController(
                        vc,
                        animated: true
                    )
                }
            }

            let cancelaction = UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil
            )

            alert.addAction(okaction)
            alert.addAction(cancelaction)
            self.present(alert, animated: true)

        default:
            break
        }
    }
}

enum PageType {
    case PrivacyPolicy
    case TermsAndConditions
    case AboutUs
    case ContactUs
    case Wishlist
    case EditProfile
    case Productlist
    case Register
}
