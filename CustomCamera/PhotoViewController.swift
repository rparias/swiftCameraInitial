//
//  PhotoViewController.swift
//  CustomCamera
//
//  Created by Ronald Arias on 11/5/19.
//  Copyright © 2019 Ronald Arias. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var takenPhoto:UIImage?

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //si takenPhoto es diferente de nil pongo la imagen en el imageView
        if let avaliableImage = takenPhoto {
            imageView.image = avaliableImage
        }
        
    }
    

    @IBAction func backPressed(_ sender: UIButton) {
        
        
        
    }

}
