//
//  settingController.swift
//  carcabigateFinal
//
//  Created by Arqam Butt on 20/07/2017.
//  Copyright © 2017 Arqam Butt. All rights reserved.
//

import UIKit
import SDWebImage

class settingController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personBackView: UIView!
    @IBOutlet weak var currentLatLon: UILabel!
    @IBOutlet weak var Pname: UILabel!
    
    
    var labelName = ["NAME","EMAIL","MOBILE",  "HOME" , "CHANGE PROFILE PICTURE"]
    var cellImages = ["user","email","cellphone","home" , "user"]
    
   let imagePickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
  
        if(userDetail.object.fname != ""){
            Pname.text = "Mr. \(userDetail.object.fname) \(userDetail.object.lName)"
            
        }
        if(userDetail.object.profilePicUrl != ""){
            
            
           SDWebImageManager.shared().imageDownloader?.downloadImage(with: NSURL(string: "\(userDetail.object.profilePicUrl)")! as URL, options: [.highPriority , .continueInBackground , .progressiveDownload , .useNSURLCache], progress: nil, completed: { (IMG, DATA, ERR, BOLL) in
                
                self.personImage.image = IMG
                
                
            })
            
            if(booking.object.currentlocName != ""){
                
                currentLatLon.text = "\(booking.object.currentlocName)"
            }
        }
        
        
        
        viewHelper.instance.view_circle(views: personBackView)
        viewHelper.instance.border_Function(views: personImage, colorName: "white")
        
        self.personBackView.layer.borderWidth = 1.5
        self.personBackView.layer.borderColor = UIColor(red:255/255.0, green:255/255.0, blue:255/255.0, alpha: 0.5).cgColor
        
        personImage.layer.cornerRadius = personImage.frame.size.width/2
        personImage.clipsToBounds = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! myTableViewCell
        
        
        
        if(indexPath.item == 0){
            
            
            cell.fnameLabel.text = labelName[indexPath.row]
            cell.fullNameLabel.text = "Mr.\(userDetail.object.fname) \(userDetail.object.lName)"
            cell.displayImage.image = UIImage(named: cellImages[indexPath.row])
            
        }else if (indexPath.item == 1){
            
            cell.fnameLabel.text = labelName[indexPath.row]
            cell.fullNameLabel.text = "\(userDetail.object.email)"
            cell.displayImage.image = UIImage(named: cellImages[indexPath.row])
            
        }else if (indexPath.item == 2){
            
            cell.fnameLabel.text = labelName[indexPath.row]
            cell.fullNameLabel.text = "+\(userDetail.object.phone)"
            cell.displayImage.image = UIImage(named: cellImages[indexPath.row])
            
        }else if (indexPath.item == 3){
            
         
            cell.fnameLabel.text = labelName[indexPath.row]
            cell.displayImage.image = UIImage(named: cellImages[indexPath.row])
            
         
            cell.fullNameLabel.text = "Add home & Work address"
            
        }else if (indexPath.item == 4){
            
            
            cell.fnameLabel.text = labelName[indexPath.row]
            cell.displayImage.image = UIImage(named: cellImages[indexPath.row])
            cell.fullNameLabel.text = "Change your Profile picture"
            
        }
        
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0){
            //changeName
            
            
            let controller = storyboard?.instantiateViewController(withIdentifier: "changeNmae") as! changeName
            
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        
        else if (indexPath.row == 2){
            
            
            let controller = storyboard?.instantiateViewController(withIdentifier: "CM") as! changephonrnumber
            
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        else if (indexPath.row == 3){
            
            let controller = storyboard?.instantiateViewController(withIdentifier: "places") as! Addplaces
            
            self.navigationController?.pushViewController(controller, animated: true)
      
        }
        
        else if (indexPath.row == 4){
            
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        
        
    }
    
    
    
}
extension settingController :UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        var selectedimage:UIImage?
        
        
        
        if let editableImg = info["UIImagePickerControllerEditedImage"] as? UIImage{
            
            selectedimage = editableImg
            
        }else if let  orignalImg = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            
            selectedimage = orignalImg
        }
        
        if let img = selectedimage {
            
            
            personImage.image = img
            uploadFile.object.myImageUploadRequest(myImageView: personImage.image!)
            userDetail.object.cheak = false
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return UIStatusBarStyle.lightContent
    }
    
}

