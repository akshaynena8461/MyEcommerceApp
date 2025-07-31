import UIKit

extension ProductViewController : UITableViewDelegate{
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        if let productdetailvc = storyboard.instantiateViewController(
            withIdentifier: "ProductDetailViewController"
        ) as? ProductDetailViewController {
            productdetailvc.product = filteredProducts[indexPath.row]

            self.navigationController?.pushViewController(
                productdetailvc,
                animated: true
            )
        }
    }
}

extension ProductViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "ProductTableViewCell",
                for: indexPath
            ) as! ProductTableViewCell

        cell.objproduct = filteredProducts[indexPath.row]

        cell.onshowalert = {
            UIAlertController.showAlert(
                title: "Success",
                message: "Product added to cart",
                viewController: self
            )
        }
        cell.btndelete.isHidden = true

        cell.updatebedge = {
            self.updateCartBadge()
        }

        let product = filteredProducts[indexPath.row]
        cell.objproduct = product
        cell.configureCell(product: product)

        if strProductTitle == .Wishlist {
            cell.deletedata = {
                if let indexInAppWishlist = app.arrWishlist.firstIndex(where: {
                    $0.id == product.id
                }) {
                    app.arrWishlist.remove(at: indexInAppWishlist)
                }
                self.filteredProducts.remove(at: indexPath.row)
                self.tblView.reloadData()
                self.lblempty.isHidden = !self.filteredProducts.isEmpty
            }
        }

        cell.configureCell(product: filteredProducts[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return filteredProducts.count
    }

}
