//
//  ListMoviesTableViewCell.swift
//  MoviesApp
//
//  Created by Ramiro Gutierrez on 14/07/24.
//

import UIKit

class ListShowsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageShow: UIImageView!
    @IBOutlet weak var titleShowLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        // Initialization code
    }
    
    func configureUI() {
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.gray.cgColor
    }
}
