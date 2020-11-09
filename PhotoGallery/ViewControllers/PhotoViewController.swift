//
//  PhotoViewController.swift
//  PhotoGallery
//
//  Created by Eduard Galchenko on 07.11.2020.
//

import UIKit

class PhotoViewController: UIViewController, UINavigationBarDelegate {
    
    // MARK: - Properties
    
    var photo: Photo! = nil
    
    private let imageView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.image = UIImage()
        
        return theImageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        perform(#selector(flipImage), with: nil, afterDelay: 0.3)
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .white
        
        titleLabel.text = photo.title.capitalizingFirstLetter()
        imageView.loadImageInCache(with: photo.url)
        
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    // MARK: - Animation
    
    @objc private func flipImage() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: imageView, duration: 1.0, options: transitionOptions, animations: nil)
    }
    
}
