//
//  CartViewController.swift
//  MyEcommerceApplicationTask
//
//  Created by Akshay Nena on 17/07/25.
//

import UIKit

var taxpersentage: Double = 0.075
var totalprice: Double = 0.0
var isValidateCoupan: Bool = false
var selectedCoupon: Coupon?

var arrcoupan = Coupon.generateCoupons().map{$0.code}

class CartViewController: UIViewController {
    
    @IBOutlet weak var btnplaceorders: UIButton!
    @IBOutlet weak var lbltotal: UILabel!
    @IBOutlet weak var tblcart: UITableView!
    
    @IBOutlet weak var discountstack: UIStackView!
    @IBOutlet weak var lblcgst: UILabel!
    @IBOutlet weak var lblsgst: UILabel!
    @IBOutlet weak var lblDiscountedPrice: UILabel!
    @IBOutlet weak var lblActualPrice: UILabel!
    
    @IBOutlet weak var btnapply: UIButton!
    @IBOutlet weak var txtCoupan: UITextField!
    
    @IBOutlet weak var lblempty: UILabel!
    @IBOutlet weak var lblstack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblcart.showsVerticalScrollIndicator = false
        
        print("arrcoupons : ",arrcoupan)
        self.title = "Cart"
        setborder(textfield: btnplaceorders)
        tblcart.register(
            UINib(nibName: "ProductTableViewCell", bundle: nil),
            forCellReuseIdentifier: "ProductTableViewCell"
        )
        
        lblstack.isLayoutMarginsRelativeArrangement = true
        lblstack.layoutMargins = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10
        )
        
        lblstack.layer.borderWidth = 0.3
        lblstack.layer.cornerRadius = 10
        lblstack.clipsToBounds = true
        
        lblstack.layer.shadowColor = UIColor.black.cgColor
        lblstack.layer.shadowOpacity = 0.9
        lblstack.layer.shadowOffset = CGSize(width: 0, height: 2)
        lblstack.layer.shadowRadius = 4
        
        if app.arrCart.count > 0 {
            
            lblstack.isHidden = false
            lblempty.isHidden = true
            
        } else {
            
            btnplaceorders.isHidden = true
            lblstack.isHidden = true
        }
        EditStyle.setborder(textfields: [txtCoupan,btnapply,btnplaceorders])
        EditStyle.setPadding(textFields: [txtCoupan,btnapply,btnplaceorders], paddingWidth: 10)
        


//        )
        calculatetotal()
    }
    
    func setPadding(textField: UITextField) {
        let paddingView = UIView(
            frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height)
        )
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    func setborder(textfield: UIView) {
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.layer.cornerRadius = 10
        textfield.clipsToBounds = false
    }
    
    func calculatetotal() {
        totalprice = 0.0
        
        for item in app.arrCart {
            totalprice += Double(item.intProductQty ?? 1) * item.doublePrice
        }
        
        lblActualPrice.text = "₹\(String(format: "%.2f", totalprice))"
        
        var discountedPrice = totalprice
        
        if isValidateCoupan, let code = txtCoupan.text?.uppercased() {
            discountstack.isHidden = false
            
            switch code {
            case "WELCOME10":
                discountedPrice = totalprice * 0.90
            case "DISCOUNT20":
                discountedPrice = totalprice * 0.80
            case "FESTIVE50":
                discountedPrice = totalprice * 0.50
            case "OFF40":
                discountedPrice = totalprice * 0.60
            case "SAVE20":
                discountedPrice = totalprice * 0.80
            case "NEWUSER25":
                discountedPrice = totalprice * 0.75
            case "SUMMER15":
                discountedPrice = totalprice * 0.85
            case "TRY5":
                discountedPrice = totalprice * 0.95
            case "SHOP75":
                discountedPrice = totalprice * 0.25
            case "BIGSALE30":
                discountedPrice = totalprice * 0.70
            case "EXTRA15":
                discountedPrice = totalprice * 0.85
            default:
                discountedPrice = totalprice
            }
            
            lblDiscountedPrice.text = "₹\(String(format: "%.2f", discountedPrice))"
        }
        else {
            lblDiscountedPrice.text = "₹0.00"
            discountstack.isHidden = true
        }
    
        
        let taxAmount = discountedPrice * taxpersentage
        lblsgst.text = "₹\(String(format: "%.2f", taxAmount))"
        lblcgst.text = "₹\(String(format: "%.2f", taxAmount))"
        
        let finalTotal = discountedPrice + (taxAmount * 2)
        lbltotal.text = "Total: ₹\(String(format: "%.2f", finalTotal))"
    }
    
    @IBAction func btnapplyclick(_ sender: Any) {
        
        if let enteredCode = txtCoupan.text, !arrcoupan.contains(enteredCode) {
            UIAlertController.showAlert(title: "Error", message: "Invalid Coupon", viewController: self)
        }
     
        if !isValidateCoupan && txtCoupan.text == "WELCOME10" {
            isValidateCoupan = true
            btnapply.setTitle("Remove", for: .normal)
            txtCoupan.isUserInteractionEnabled = false
        }
        else if !isValidateCoupan && txtCoupan.text == "FESTIVE50" {
            isValidateCoupan = true
            btnapply.setTitle("Remove", for: .normal)
            txtCoupan.isUserInteractionEnabled = false
        }
        
        else if !isValidateCoupan && txtCoupan.text == "SAVE20" {
            isValidateCoupan = true
            btnapply.setTitle("Remove", for: .normal)
            txtCoupan.isUserInteractionEnabled = false
        }
       else if !isValidateCoupan && txtCoupan.text == "NEWUSER25" {
            isValidateCoupan = true
            btnapply.setTitle("Remove", for: .normal)
            txtCoupan.isUserInteractionEnabled = false
        }
        else if !isValidateCoupan && txtCoupan.text == "SUMMER15" {
            isValidateCoupan = true
            btnapply.setTitle("Remove", for: .normal)
            txtCoupan.isUserInteractionEnabled = false
        }
        else if !isValidateCoupan && txtCoupan.text == "OFF40" {
            isValidateCoupan = true
            btnapply.setTitle("Remove", for: .normal)
            txtCoupan.isUserInteractionEnabled = false
        }
        else if !isValidateCoupan && txtCoupan.text == "TRY5" {
            isValidateCoupan = true
            btnapply.setTitle("Remove", for: .normal)
            txtCoupan.isUserInteractionEnabled = false
        }
        
        else if !isValidateCoupan && txtCoupan.text == "SHOP75" {
            isValidateCoupan = true
            btnapply.setTitle("Remove", for: .normal)
            txtCoupan.isUserInteractionEnabled = false
        }
        
        else if !isValidateCoupan && txtCoupan.text == "BIGSALE30" {
            isValidateCoupan = true
            btnapply.setTitle("Remove", for: .normal)
            txtCoupan.isUserInteractionEnabled = false
        }
        
        else if !isValidateCoupan && txtCoupan.text == "EXTRA15" {
            isValidateCoupan = true
            btnapply.setTitle("Remove", for: .normal)
            txtCoupan.isUserInteractionEnabled = false
        }
    
        else {
            isValidateCoupan = false
            txtCoupan.text = ""
            btnapply.setTitle("Apply", for: .normal)
            txtCoupan.isUserInteractionEnabled = true

        }

        calculatetotal()

    }

    @IBAction func btnaddressformclick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        if let Avc = storyboard.instantiateViewController(
            withIdentifier: "AddressListViewController"
        ) as? AddressListViewController {

            //            editProfileVC.strRegisterTitle = .EditProfile

            self.navigationController?.pushViewController(
                Avc,
                animated: true
            )
        }

    }

}
