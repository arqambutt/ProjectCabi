//
//  HistoryView.swift
//  Cabigate
//
//  Created by abdur rehman on 6/9/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import UIKit
import GoogleMaps

class HistoryView: UIViewController {

  
   
    @IBOutlet weak var backButtonImg: UIImageView!
    @IBOutlet weak var c: UIImageView!
    @IBOutlet weak var b: UILabel!
    @IBOutlet weak var a: UILabel!
    @IBOutlet weak var CV: UICollectionView!
    @IBOutlet weak var NoHistory: UIView!
    
  
    
    deinit {
        
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("Memory warning remove")
    }
   
  
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
     

        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonPress))
        backButtonImg.isUserInteractionEnabled = true
        backButtonImg.addGestureRecognizer(tap)
      
        
    }



    func backButtonPress(){
        
        let storyBoad = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoad.instantiateViewController(withIdentifier: "Map")
        self.present(controller, animated: true, completion: nil)
        
    }

}

extension HistoryView :UICollectionViewDelegate , UICollectionViewDataSource {
    
    
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return ImportHistory.historyArray.count
    }
    
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HistoryCell
        
        cell.configurationofCell(object: ImportHistory.historyArray[indexPath.item])
        
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
let controller = storyboard?.instantiateViewController(withIdentifier: "detailViewForCell") as! HistoryDetail
        
        controller.object = ImportHistory.historyArray[indexPath.item]
        Send.object.object = ImportHistory.historyArray[indexPath.item]
        self.navigationController?.pushViewController(controller, animated: true)
        
        
        
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}
