import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var lblempty: UILabel!
    @IBOutlet weak var txtsearch: UITextField!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var heightforcollview: NSLayoutConstraint!

    var intIndexSelectedCategoryId: Int = 0
    var strProductTitle: PageType = .Productlist
    var arrProduct: [ProductModel] = []
    var filteredProducts: [ProductModel] = []
    var arrForCategory: [CategoryViewModel] = []
    var isLoadingMoreData = false

    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.showsVerticalScrollIndicator = false
        collView.showsHorizontalScrollIndicator = false

        tblView.register(
            UINib(nibName: "ProductTableViewCell", bundle: nil),
            forCellReuseIdentifier: "ProductTableViewCell"
        )
        collView.register(
            UINib(nibName: "CategoryCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "CategoryCollectionViewCell"
        )

        txtsearch.addTarget(
            self,
            action: #selector(textFieldDidChange(_:)),
            for: .editingChanged
        )

        EditStyle.setborder(textfields: [txtsearch])
        EditStyle.setPadding(textFields: [txtsearch], paddingWidth: 10)

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 22),
        ]
        navigationController?.navigationBar.standardAppearance = appearance

        if strProductTitle == .Wishlist {

            self.title = "Wishlist"
            heightforcollview.constant = 0

        } else {

            let ProductUrl =
                "https://mocki.io/v1/2797f85a-197c-4346-afee-f09b93d1a3b0"
            let CategoryUrl =
                "https://mocki.io/v1/b87fd5ac-33b7-4079-b384-66c9f2036a94"

            APICalls.getProductData(
                from: CategoryUrl,
                modelType: CategoryViewModel.self
            ) { categories in
                DispatchQueue.main.async {
                    self.arrForCategory = categories
                    print("arrForCategory : ", self.arrForCategory)
                    self.tblView.reloadData()
                }

            }

            APICalls.getProductData(
                from: ProductUrl,
                modelType: ProductModel.self
            ) { products in
                DispatchQueue.main.async {
                    self.arrProduct = products
                    print("Products loaded: \(self.arrProduct)")
                    self.filteredProducts = self.arrProduct
                    print("filterProducts : ", self.filteredProducts)
                    self.updateWishlistData()
                    self.tblView.reloadData()
                }
            }

            self.title = "Product List"
            self.navigationItem.hidesBackButton = true

            let btnSetting = UIButton(type: .system)
            let settingImage = UIImage(
                systemName: "gear",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 22,
                    weight: .regular
                )
            )
            btnSetting.setImage(settingImage, for: .normal)
            btnSetting.tintColor = .systemOrange

            btnSetting.addTarget(
                self,
                action: #selector(btnSettingAction),
                for: .touchUpInside
            )
            let barButtonSetting = UIBarButtonItem(customView: btnSetting)

            let btnCart = UIButton(type: .system)
            let cartImage = UIImage(
                systemName: "cart",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 22,
                    weight: .regular
                )
            )
            btnCart.setImage(cartImage, for: .normal)

            btnCart.tintColor = .systemOrange
            btnCart.setBackgroundImage(
                UIImage(systemName: "cart"),
                for: .normal
            )
            btnCart.addTarget(
                self,
                action: #selector(btncartAction),
                for: .touchUpInside
            )
            let barButtonCart = UIBarButtonItem(customView: btnCart)

            self.navigationItem.rightBarButtonItems = [
                barButtonCart, barButtonSetting,
            ]
        }
        tblView.reloadData()
    }

    func updateWishlistData() {
        for item in arrProduct {
            if app.arrWishlist.firstIndex(where: { $0.id == item.id }) != nil {
                item.objAddFavorite = true
            } else {
                item.objAddFavorite = false
            }
        }
    }

    func updateCartBadge() {
        let count = app.arrCart.reduce(0) { $0 + ($1.intProductQty ?? 1) }

        guard
            let btnCart =
                (self.navigationItem.rightBarButtonItems?.first?.customView
                    as? UIButton)
        else { return }

        btnCart.subviews.forEach {
            if $0 is UILabel && $0.tag == 999 {
                $0.removeFromSuperview()
            }
        }

        if count > 0 {
            let badge = UILabel(
                frame: CGRect(x: 18, y: -5, width: 18, height: 18)
            )
            badge.text = "\(count)"
            badge.textColor = .white
            badge.backgroundColor = .red
            badge.font = .systemFont(ofSize: 12)
            badge.textAlignment = .center
            badge.layer.cornerRadius = 9
            badge.clipsToBounds = true
            badge.tag = 999
            btnCart.addSubview(badge)
        }

    }
    func setborder(textfield: UIView) {
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.layer.cornerRadius = 10
        textfield.clipsToBounds = false
    }

    @objc func btnSettingAction() {
        let storyboard = UIStoryboard(name: "Setting", bundle: nil)
        if let pVC = storyboard.instantiateViewController(
            withIdentifier: "SettingViewController"
        ) as? SettingViewController {
            pVC.productList = self.arrProduct
            self.navigationController?.pushViewController(pVC, animated: true)
        }

    }

    @objc func btncartAction() {
        print("add to cart page")
        let storyboard = UIStoryboard(name: "ProductStoryBoard", bundle: nil)
        if let pVC = storyboard.instantiateViewController(
            withIdentifier: "CartViewController"
        ) as? CartViewController {
            self.navigationController?.pushViewController(pVC, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if strProductTitle == .Wishlist {
            if app.arrWishlist.count == 0 {
                lblempty.isHidden = false
            } else {
                lblempty.isHidden = true

            }
        } else {
            updateWishlistData()
            lblempty.isHidden = true
        }
        tblView.reloadData()
        updateCartBadge()
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        let searchText = textField.text ?? ""

        let selectedCategoryID = intIndexSelectedCategoryId

        filteredProducts = arrProduct.filter { product in
            let matchesCategory =
                (selectedCategoryID == 0)
                || (product.categoryId == selectedCategoryID)
            let matchesSearch =
                searchText.isEmpty
                || product.strName.lowercased().contains(
                    searchText.lowercased()
                )
            return matchesCategory && matchesSearch
        }
        lblempty.text = "No Product Found"
        lblempty.isHidden = !filteredProducts.isEmpty
        tblView.reloadData()
    }

}
