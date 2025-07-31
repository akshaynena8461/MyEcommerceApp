import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var detailstack: UIStackView!
    @IBOutlet weak var detailview: UIView!
    @IBOutlet weak var reviewtblview: UITableView!
    @IBOutlet weak var collProductDetail: UICollectionView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var lblqty: UILabel!
    @IBOutlet weak var btnaddtocart: UIButton!
    @IBOutlet weak var labelprice: UILabel!
    @IBOutlet weak var labelcategory: UILabel!
    @IBOutlet weak var animate: UIActivityIndicatorView!
    @IBOutlet weak var lbldescription: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblcategory: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var scrollview: UIScrollView!

    var product: ProductModel?

    var arrImg: [String] = []

    var arrReview = ReviewModel.generateDummyReviews()

    @IBAction func stepperclick(_ sender: Any) {
        product?.intProductQty = Int(stepper.value)
        lblqty.text = "Qty: \(product?.intProductQty ?? 1)"
    }
    override func viewDidLoad() {
        scrollview.showsVerticalScrollIndicator = false
        reviewtblview.showsVerticalScrollIndicator = false
        super.viewDidLoad()
        self.title = product?.strName
        animate.startAnimating()
        animate.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        setupSegmentFont()
        
        reviewtblview.isHidden = true

        reviewtblview.register(
            UINib(nibName: "ReviewTableViewCell", bundle: nil),
            forCellReuseIdentifier: "ReviewTableViewCell"
        )

        collProductDetail.register(
            UINib(nibName: "ProductDetailCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "ProductDetailCollectionViewCell"
        )

        lblname.text = product?.strName
        lblcategory.text = product?.strCategory
        lblprice.text = String(product?.doublePrice ?? 0)
        lbldescription.text = product?.strFullDescription
        lblqty.text = "Qty: \(product?.intProductQty ?? 1)"

        detailstack.isHidden = true
        btnaddtocart.isHidden = true
        
        scrollview.isScrollEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {

            self.animate.stopAnimating()
            self.animate.isHidden = true
            
            EditStyle.setborder(textfields: [self.btnaddtocart])

            self.detailstack.isHidden = false
            self.btnaddtocart.isHidden = false
            self.lblname.text = self.product?.strName
            self.lblcategory.text = self.product?.strCategory
            self.lblprice.text = String(
                format: "₹%.2f",
                self.product?.doublePrice ?? 0.0
            )
            self.lbldescription.text = self.product?.strFullDescription
            self.lblqty.text = "Qty: \(self.product?.intProductQty ?? 1)"

            if let productImages = self.product?.strImageName {
                self.arrImg = productImages
                self.collProductDetail.reloadData()
            }
            self.detailstack.isHidden = false
    
            self.collProductDetail.isHidden = false
            self.scrollview.isScrollEnabled = true
        }
    }
    
    @IBAction func btnaddcartclick(_ sender: Any) {

        UIAlertController.showAlert(
            title: "Success",
            message: "Product added to Cart",
            viewController: self
        )

        if let objproduct = product {
            checkproduct(obj: objproduct)
        }
    }
    func setupSegmentFont() {
        let boldFont = UIFont.boldSystemFont(ofSize: 20)
        let normalFont = UIFont.systemFont(ofSize: 17)

        segmentControl.setTitleTextAttributes([.font: normalFont], for: .normal)
        segmentControl.setTitleTextAttributes([.font: boldFont], for: .selected)
    }

    @IBAction func segmentvaluechange(_ sender: UISegmentedControl) {
        animate.isHidden = true
        switch sender.selectedSegmentIndex {
        case 0:
        
            detailview.isHidden = false
            detailstack.isHidden = false
            reviewtblview.isHidden = true
            btnaddtocart.isHidden = false
            
        case 1:

            reviewtblview.isHidden = false
//            detailview.isHidden = true
            detailstack.isHidden = true
            btnaddtocart.isHidden = true
        default:
            break
        }

    }

}
