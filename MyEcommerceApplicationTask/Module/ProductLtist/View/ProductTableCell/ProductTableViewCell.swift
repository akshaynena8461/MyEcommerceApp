import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var lblqty: UILabel!
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var btnaddtocart: UIButton!
    @IBOutlet weak var Descriptionlbl: UILabel!
    @IBOutlet weak var Pricelbl: UILabel!
    @IBOutlet weak var Catagorylbl: UILabel!
    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var btnlike: UIButton!
    @IBOutlet weak var btndelete: UIButton!
    var onshowalert: (() -> Void)?
    var objproduct: ProductModel?
    var objprductqty: (() -> Void)?
    var updatebedge: (() -> Void)?
    var getproductdata: (() -> Void)?
    var deletedata: (() -> Void)?

    @IBAction func btndeleteclick(_ sender: Any) {
        deletedata?()
    }
    override func awakeFromNib() {
        super.awakeFromNib()

        EditStyle.setborder(textfields: [btnaddtocart])

        btnlike.setImage(UIImage(systemName: "heart"), for: .normal)
        btnlike.tintColor = .red

    }
    @IBAction func stepperclick(_ sender: Any) {
        print(stepper.value)
        objproduct?.intProductQty = Int(stepper.value)
        lblqty.text = "Qty: \(objproduct?.intProductQty ?? 1)"
        objprductqty?()
    }

    @IBAction func btnaddtocartclick(_ sender: Any) {
        onshowalert?()

        if let product = objproduct {
            checkproduct(obj: product)
        }
        updatebedge?()
    }

    @IBAction func btnlikeclick(_ sender: AnyObject) {
        print("click")
        objproduct?.objAddFavorite = !(objproduct?.objAddFavorite ?? false)
        let imageName =
            (objproduct?.objAddFavorite ?? false) ? "heart.fill" : "heart"
        btnlike.setImage(UIImage(systemName: imageName), for: .normal)

        if let index = app.arrWishlist.firstIndex(where: {
            $0.id == objproduct?.id
        }) {
            app.arrWishlist.remove(at: index)
        } else {
            app.arrWishlist.append(objproduct!)
        }
        deletedata?()

    }

    func configureCell(product: ProductModel) {
        if let firstImage = product.strImageName.first {
            imgview.image = UIImage(named: firstImage)
        }

        self.lblProductTitle.text = product.strName
        self.Catagorylbl.text = product.strCategory
        self.Pricelbl.text = "\(product.doublePrice)"
        self.Descriptionlbl.text = product.strDescription
        self.lblqty.text = "Qty: \(product.intProductQty ?? 1)"
        let imageName = product.objAddFavorite ?? false ? "heart.fill" : "heart"
        btnlike.setImage(UIImage(systemName: imageName), for: .normal)
        self.stepper.value = Double(product.intProductQty ?? 1)
    }

    func configureCellCart(product: ProductModel) {

        if let firstImage = product.strImageName.first {
            imgview.image = UIImage(named: firstImage)
        }
        self.lblProductTitle.text = product.strName
        self.Catagorylbl.text = product.strCategory
        self.Pricelbl.text = "\(product.doublePrice)"
        self.Descriptionlbl.text = product.strDescription
        self.lblqty.text = "Qty: \(product.intProductQty ?? 1)"
        let imageName = product.objAddFavorite ?? false ? "heart.fill" : "heart"
        self.stepper.value = Double(product.intProductQty ?? 1)
        self.stepper.maximumValue = 100
        btnaddtocart.isHidden = true
        btnlike.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

func checkproduct(obj: ProductModel) {
    var isItemAlreadyAdded: Bool = false
    for item in app.arrCart {
        if item.id == obj.id {
            item.intProductQty =
                (item.intProductQty ?? 1) + (obj.intProductQty ?? 1)
            isItemAlreadyAdded = true

        }
    }
    if !(isItemAlreadyAdded) {
        let objProductModel = ProductModel(
            id: obj.id,
            strName: obj.strName,
            doublePrice: obj.doublePrice,
            strCategory: obj.strCategory,
            strDescription: obj.strDescription,
            strFullDescription: obj.strFullDescription,
            strImageName: obj.strImageName,
            objProductCategory: obj.objProductCategory
        )

        objProductModel.intProductQty = obj.intProductQty
        app.arrCart.append(objProductModel)
    }
}
