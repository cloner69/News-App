//
//  LiveNewsTableViewCell.swift
//  LiveNewsTableViewCell
//
//  Created by Adrian Suryo Abiyoga on 23/08/21.
//

import UIKit

import UIKit

class LiveNewsListTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var NewsImage: UIImageView!
    
    // MARK:- Methods
    func setCell(title: String, author: String, description: String) {
        titleLabel.text = title
        authorLabel.text = author
        descriptionLabel.text = description
    }
    
}
