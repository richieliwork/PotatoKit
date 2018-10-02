//
//  ViewController.swift
//  PerosnalExample
//
//  Created by IT on 28/09/2018.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

import PotatoKit

class ViewController: UIViewController {

    
    var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image1 = UIImageView(image: UIImage(named: "invite_mimi"))
        self.view.addSubview(image1)
        
        let image = UIImageView(image: UIImage.imageFromURL(url: "https://www.baidu.com", size: 131))
        image.translatesAutoresizingMaskIntoConstraints = false
        image1.addSubview(image)
        
        image1.center = self.view.center
        
        self.image = image1
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(saveImage)))
    }

    @objc func saveImage() -> Void {
        guard let image = self.image.saveContentAsImage() else {
            print("error")
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }

}

