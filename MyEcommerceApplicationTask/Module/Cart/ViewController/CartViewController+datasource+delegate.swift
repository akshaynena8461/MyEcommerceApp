import UIKit

extension CartViewController: UITableViewDelegate {

}

extension CartViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return app.arrCart.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "ProductTableViewCell",
                for: indexPath
            ) as! ProductTableViewCell

        cell.objproduct = app.arrCart[indexPath.row]
        cell.configureCellCart(product: app.arrCart[indexPath.row])
        cell.btnlike.isHidden = true
        cell.Descriptionlbl.isHidden = true

        cell.deletedata = {
            app.arrCart.remove(at: indexPath.row)
            self.lblstack.isHidden = app.arrCart.isEmpty
            self.lblempty.isHidden = !app.arrCart.isEmpty
            self.lblstack.reloadInputViews()
            self.calculatetotal()
            self.tblcart.reloadData()
        }

        cell.objprductqty = {
            self.calculatetotal()
        }
        return cell

    }
}
