//
//  ProductModel.swift
//  MyEcommerceApplicationTask
//
//  Created by Akshay Nena on 09/07/25.
//

import Foundation


class ProductModel: Codable {
    
    var id: Int
    var strName: String
    var doublePrice: Double
    var strCategory: String
    var strDescription: String
    var strImageName: [String] = []
    var strFullDescription:String?
    var objAddFavorite:Bool?
    var intProductQty:Int?
    var objProductCategory:String = ""
    var categoryId:Int = 0
    
    
    
    
    init(id: Int, strName: String, doublePrice: Double, strCategory: String, strDescription: String,strFullDescription:String?, strImageName: [String],objProductCategory:String) {
        self.id = id
        self.strName = strName
        self.doublePrice = doublePrice
        self.strCategory = strCategory
        self.strDescription = strDescription
        self.strFullDescription = strFullDescription
        self.strImageName = strImageName
        self.objProductCategory = objProductCategory
    }
    
    
    func showCategoryPriceDescription() -> String {
        return "Category: \(strCategory)\nPrice: \(doublePrice)\nDescription: \(strDescription)"
    }
    
    class func loadproductfromjsonfile()->[ProductModel] {
        guard let filePath = Bundle.main.url(forResource: "ProductData", withExtension: "json")else{
            print("ProductData Json file not found")
            return []
        }
        
        do{
            let data = try Data(contentsOf: filePath)
            let arrProduct = try JSONDecoder().decode([ProductModel].self, from: data)
            print(arrProduct)
            return arrProduct
        }
        catch{
            print(error.localizedDescription)
        }
        return []
    }
    
    class func loadCategoryFromJsonFile()->[CategoryViewModel] {
        guard let filePath = Bundle.main.url(forResource: "CategoryData", withExtension: "json")else{
            print("CategoryData Json file not found")
            return []
        }
        
        do{
            let data = try Data(contentsOf: filePath)
            let arrCategory = try JSONDecoder().decode([CategoryViewModel].self, from: data)
            print("arrcategoryproduct : ",arrCategory)
            return arrCategory
        }
        catch{
            print(error.localizedDescription)
        }
        return []
    }
    
   class func convertToArrayOfDictionaries<T: Encodable>(_ objects: [T]) -> [[String: Any]]? {
        do {
            let data = try JSONEncoder().encode(objects)
            let array = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            return array
        } catch {
            print("Error converting array to dictionary array: \(error)")
            return nil
        }
    }


  
    
}


class CategoryViewModel: Codable {
    var categoryId:Int = 0;
    var categoryName:String = "";
    var categoryDisplayName:String = "";
    
}

enum ProductCategory : String,CaseIterable{
    case All = "All"
    case iphone12 = "iphone12"
    case iphone13 = "iphone13"
    case iphone14 = "iphone14"
    case iphone11 = "iphone11"
    case iphoneXR = "iphoneXR"
    case iphoneSE = "iphoneSE"
    
}
