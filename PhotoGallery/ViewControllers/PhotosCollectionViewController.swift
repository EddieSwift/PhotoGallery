//
//  PhotosCollectionViewController.swift
//  PhotoGallery
//
//  Created by Eduard Galchenko on 07.11.2020.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let reuseIdentifier = "photoCell"
    private var photos = [Photo]()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var photoUrl = ""
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupActivityIndicator()
        
        PhotoCollectionViewCell.register(in: collectionView)
        
        photoUrl = "/albums/\(page)/photos"
        collectionView.dataSource = self
        collectionView.delegate = self
        
        getPhotos()
    }
    
    // MARK: - Network Method
    
    private func getPhotos() {
        startAnimation()
        NetworkService.shared.getItems(photoUrl) { [weak self] (state: NetworkResponse<Photo>) in
            guard let `self` = self else { return }
            switch state {
            case .success(let photos):
                self.photos = photos
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .error(let error):
                print(error.localizedDescription)
            }
            self.stopAnimation()
        }
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        title = "Photos from Album \(page)"
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
    }
    
    private func setupActivityIndicator() {
        activityIndicator.color = UIColor .blue
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    // MARK: - Indicator Methods
    
    private func startAnimation() {
        activityIndicator.startAnimating()
    }
    
    private func stopAnimation() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
}

extension PhotosCollectionViewController {
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        let photo = photos[indexPath.row]
        cell.configureWith(photo)
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoViewController(nibName: "PhotoViewController", bundle: nil)
        vc.photo = photos[indexPath.row]
        present(vc, animated: true, completion: nil)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let paddingWidth = layout.minimumInteritemSpacing * (itemsPerRow - 1) + CGFloat(16*2)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
}
