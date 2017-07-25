//
//  promotion.swift
//  Cabigate
//
//  Created by abdur rehman on 7/17/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit

class promotion: UIViewController , UICollectionViewDataSource  {

    @IBOutlet weak var CVP: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        PromoController.object.FetchHistory { (result) in
            
            
            if(result == true){
                
            self.CVP.reloadData()
            
            }else {
                
                
            }
        }
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Pro", for: indexPath) as! PromotionCell
        
        cell.layer.shadowColor = UIColor(displayP3Red: 6/255, green: 191/255, blue: 195/255, alpha: 1).cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 30
          cell.configration(object: PromoController.PromotionArray[indexPath.item])
        
        
        return cell
        
    
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PromoController.PromotionArray.count
    }

}
