//
//  AlbumsTableViewController.swift
//  PhotoGallery
//
//  Created by Eduard Galchenko on 07.11.2020.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var albums = [Album]()
    private let albumsURL = "/albums"
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let networkService: NetworkService!
    
    // MARK: - Lifecycle Methods
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        title = "Albums"
        
        setupActivityIndicator()
        getAlbums()
    }
    
    // MARK: - Network Method
    
    private func getAlbums() {
        startAnimation()
        networkService.getItems(albumsURL) { [weak self] (state: NetworkResponse<Album>) in
            guard let `self` = self else { return }
            switch state {
            case .success(let albums):
                self.albums = albums
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error.localizedDescription)
            }
            self.stopAnimation()
        }
    }
    
    // MARK: - SetupUI
    
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

extension AlbumsTableViewController {
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("AlbumTableViewCell", owner: self, options: nil)?.first as! AlbumTableViewCell
        
        let album = albums[indexPath.row]
        cell.configureWith(album)
        cell.backgroundColor = indexPath.row % 2 == 0 ? .white : .systemGray5
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let photosCollectionViewController = PhotosCollectionViewController(collectionViewLayout: layout)
        photosCollectionViewController.page = albums[indexPath.row].id
        navigationController?.pushViewController(photosCollectionViewController, animated: true)
    }
    
}
