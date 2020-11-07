//
//  PhotoViewController.swift
//  PhotoGallery
//
//  Created by Eduard Galchenko on 07.11.2020.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photo: Photo! = nil
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.loadImageInCache(with: photo.url)
        titleLabel.text = photo.title.capitalizingFirstLetter()
    }
    
}
