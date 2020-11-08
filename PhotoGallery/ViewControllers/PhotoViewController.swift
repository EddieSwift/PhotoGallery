//
//  PhotoViewController.swift
//  PhotoGallery
//
//  Created by Eduard Galchenko on 07.11.2020.
//

import UIKit

class PhotoViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var photo: Photo! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.loadImageInCache(with: photo.url)
        titleLabel.text = photo.title.capitalizingFirstLetter()
        
        perform(#selector(flipImage), with: nil, afterDelay: 0.3)
    }
    
    // MARK: - Animation
    
    @objc func flipImage() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: imageView, duration: 1.0, options: transitionOptions, animations: nil)
    }
    
}
