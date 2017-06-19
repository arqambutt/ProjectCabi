//
//  DownloadImg.swift
//  Cabigate
//
//  Created by abdur rehman on 6/17/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation



typealias ImgOrNot = (_ msg:String)-> Void

class downloadImg {
    
    

    static var instance  = downloadImg()
    static var object :downloadImg {
        return instance
}
    
    
     let img = UIImageView()
    func DownloadImg(imgName:String , responce:ImgOrNot){
        
        
    
        
        
        
        
        if(img.image != nil){

            return responce("")
            
        }else{
            
            return responce("no")
        }
        
    }
    

}
