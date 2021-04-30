//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Admin1 on 2/10/20.
//  Copyright © 2020 Admin1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = ""
        copyrigthLabel.text = ""
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
            }
        }
    }
    
    // MARK: - Model
    let photoInfoController = PhotoInfoController()
    
    // MARK: - Outlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrigthLabel: UILabel!
    @IBOutlet weak var spaceImage: UIImageView!
    
    
    // MARK: - Updating UI
    func updateUI(with photoInfo: PhotoInfo){
        guard let url = photoInfo.url.withHTTPS() else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.title = photoInfo.title
                    self?.descriptionLabel.text = photoInfo.description
                    self?.spaceImage.image = image
                    
                    if let copyright = photoInfo.copyright {
                        self?.copyrigthLabel.text = "Copyright \(copyright)"
                    }
                }
            } else{
                print("Maybe the url is a video")
            }
        }
        task.resume()
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

