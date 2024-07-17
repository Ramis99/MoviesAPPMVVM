//
//  DetailsShowViewController.swift
//  MoviesApp
//
//  Created by Ramiro Gutierrez on 14/07/24.
//

import UIKit

class DetailsShowViewController: UIViewController {
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var premieredLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var webSiteButton: PrimaryButtonClass!
    
    let viewModel = ShowsViewModel()
    var index: Int? = nil
    var delegate: FavoriteUpdateDelegate?

    
    override func viewWillAppear(_ animated: Bool) {
        configurationRightBarButton()
        setData()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setData(){
        guard let show = viewModel.showSelected else {return}
        let url = URL(string: (show.imageUrl?.imageMedium)!)
        self.title = show.name
        languageLabel.text = show.language
        genresLabel.text = show.genres?.joined(separator: ", ")
        ratingLabel.text = "\(show.rating?.average ?? 0.0)"
        premieredLabel.text = show.premiered
        summaryLabel.text = show.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
        showImage.downloadImage(url: url, defaultImage: UIImage(named: "ic_show_default_image"))
        if show.url == "" {
            webSiteButton.isHidden = true
        } else {
            webSiteButton.isHidden = false
        }
        if show.isFavorite == true {
            navigationItem.rightBarButtonItem!.image = UIImage(named: "ic_favorite _checked")
        } else {
            navigationItem.rightBarButtonItem!.image = UIImage(named: "ic_favorite_not_checked")

        }
    }
    
    private func configurationRightBarButton() {
        let rightButton =  UIBarButtonItem(image: UIImage(named: "ic_favorite_not_checked"), style: .plain, target: self, action: #selector(rightButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    @objc private func rightButtonTapped() {
        guard var show = viewModel.showSelected else {return}
        if show.isFavorite == true {
            navigationItem.rightBarButtonItem!.image = UIImage(named: "ic_favorite_not_checked")
            show.isFavorite = false
        } else {
            navigationItem.rightBarButtonItem!.image = UIImage(named: "ic_favorite _checked")
            show.isFavorite = true

        }
        self.delegate?.updateShowList(show: show, index: index!)
    }
    
    @IBAction func goToWebSiteActionButton(_ sender: Any) {
        guard let show = viewModel.showSelected else {return}
        
        guard let url = URL(string: show.url!) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("No se puede abrir la URL")
        }
    }
}
