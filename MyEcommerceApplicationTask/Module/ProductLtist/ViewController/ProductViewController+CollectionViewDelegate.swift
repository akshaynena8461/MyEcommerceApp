

import Foundation
import UIKit

extension ProductViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        intIndexSelectedCategoryId = arrForCategory[indexPath.item].categoryId
        collectionView.reloadData()
        if ProductCategory.allCases[indexPath.item] == .All{
           filteredProducts = arrProduct
        }
        else{
            filteredProducts = arrProduct.filter { $0.categoryId == intIndexSelectedCategoryId }
        }
        
        tblView.reloadData()

    }
}
extension ProductViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130,height: 50)
    }
}
extension ProductViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.lblcategory.text = ProductCategory.allCases[indexPath.item].rawValue
       
        cell.viewMain.backgroundColor = intIndexSelectedCategoryId == indexPath.item ? .systemYellow : .clear

        return cell
    }
 
}
