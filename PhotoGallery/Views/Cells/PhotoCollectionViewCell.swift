//
//  PhotoCollectionViewCell.swift
//  PhotoGallery
//
//  Created by Eduard Galchenko on 07.11.2020.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    public static let identifier = "photoCell"
    private static let nibName   = "PhotoCollectionViewCell"
    
    public static func register(in collectionView: UICollectionView) {
        let nib = UINib.init(nibName: nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func configureWith(_ photo: Photo) {
        imageView.loadImageInCache(with: photo.url)
    }
    
}
