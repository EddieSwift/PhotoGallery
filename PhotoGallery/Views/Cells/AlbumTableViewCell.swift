//
//  AlbumTableViewCell.swift
//  PhotoGallery
//
//  Created by Eduard Galchenko on 07.11.2020.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    public static let identifier = "AlbumTableViewCell"
    private static let nibName   = "AlbumTableViewCell"
    
    @IBOutlet weak var albumNumLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    public static func register(in tableView: UITableView) {
        let nib = UINib.init(nibName: nibName, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func configureWith(_ album: Album) {
        albumNumLabel.text = "Album \(album.id)"
        titleLabel.text = album.title.capitalizingFirstLetter()
        accessoryType = .disclosureIndicator
    }
    
}
