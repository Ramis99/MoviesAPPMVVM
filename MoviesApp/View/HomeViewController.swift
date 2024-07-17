//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Ramiro Gutierrez on 13/07/24.
//

import UIKit
import Reachability

protocol FavoriteUpdateDelegate: AnyObject {
    func updateShowList(show: ShowsModel, index: Int)
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var listShowsTableViewCell: UITableView!
    
    @IBOutlet weak var emptyView: EmptyView!
    
    var viewModel = ShowsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Ya estas en el home")
        configureDelegate()
        configureUI()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func fetchData() {
        if viewModel.connectivityChecker.hasInternetConnection() {
            viewModel.fetchAllShows {
                DispatchQueue.main.async {
                    let data = self.viewModel.coreDataManager.getShows(entity: "TvShows").sorted { (show1, show2) -> Bool in
                        return show1.idShow < show2.idShow
                    }
                    for (index, show) in self.viewModel.showData.enumerated() {
                        if index < data.count {
                            let showCore = data[index]
                            
                            if show.idShow == showCore.idShow {
                                self.viewModel.showData[index].isFavorite = showCore.isFavorite
                                print("Datos coinciden en el índice \(index) y se ha actupualizado showFavorite")
                            } else {
                                print("Los idShow no coinciden en el índice \(index)")
                            }
                        } else {
                            print("El índice \(index) está fuera del rango del arreglo de Core Data")
                        }
                    }                  
                    self.viewModel.coreDataManager.deleteShows(entity: "TvShows")
                    self.viewModel.coreDataManager.addShows(shows: self.viewModel.showData, entity: "TvShows")
                    self.listShowsTableViewCell.reloadData()

                }
            }
        } else {
            DispatchQueue.main.async {
                if !self.viewModel.connectivityChecker.hasInternetConnection() {
                    self.viewModel.alert.alertWithTwOptions(viewController: self, title: AlertTitles.internetConnectionFailed.rawValue, message: AlertsMessage.internetConnection.rawValue, buttonOneTitle: TitleButton.retry.rawValue , buttonOneActionHandler: {
                        self.fetchData()
                    })
                }
                let data = self.viewModel.coreDataManager.getShows(entity: "TvShows")
                self.viewModel.showData = data
                self.listShowsTableViewCell.reloadData()
            }
        }
    }
    
    private func configureDelegate() {
        listShowsTableViewCell.delegate = self
        listShowsTableViewCell.dataSource = self
        listShowsTableViewCell.register(UINib(nibName: "ListShowsTableViewCell", bundle: nil), forCellReuseIdentifier: "ListShowsTableViewCell")
        tabBar.delegate = self
    }
    
    private func configureUI() {
        if let items = tabBar.items, items.count > 0 {
            tabBar.selectedItem = items[0]
        }
        emptyView.messageLabel.text = EmptyMessage.emptyFavorite.rawValue
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let showsArray = tabBar.selectedItem == tabBar.items?[1] ? viewModel.favoriteShow.count : viewModel.showData.count
        if showsArray == 0 {
            emptyView.show()
        } else {
            emptyView.hide()
        }
        return showsArray
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexRow = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListShowsTableViewCell", for: indexPath) as! ListShowsTableViewCell
        cell.titleShowLabel.text =  tabBar.selectedItem == tabBar.items?[1] ? viewModel.favoriteShow[indexRow].name : viewModel.showData[indexRow].name
        let urlImage =  tabBar.selectedItem == tabBar.items?[1] ? viewModel.favoriteShow[indexRow].imageUrl?.imageMedium :  viewModel.showData[indexRow].imageUrl?.imageMedium
        cell.imageShow.downloadImage(url: URL(string: urlImage!), defaultImage: UIImage(named: "ic_show_default_image"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexRow = indexPath.row
        let detailShowVc = ViewControllerManager.shared.getDetailShow()
        detailShowVc.viewModel.showSelected =  tabBar.selectedItem == tabBar.items?[1] ? viewModel.favoriteShow[indexRow] :  viewModel.showData[indexRow]
        detailShowVc.index = indexRow
        detailShowVc.delegate = self
        self.navigationController?.pushViewController(detailShowVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let indexRow = indexPath.row
        print("index seleccionado", indexRow)
        let markFavorite: UIContextualAction
        let isFavoriteTab = tabBar.selectedItem == tabBar.items?[1]
        let isFavorite = isFavoriteTab ? viewModel.favoriteShow[indexRow].isFavorite : viewModel.showData[indexRow].isFavorite
        
        if isFavorite == true {
            markFavorite = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
                self.viewModel.alert.alertWithTwOptions(viewController: self, title: AlertTitles.deleteFavorite.rawValue, message: AlertTitles.deleteFavorite.rawValue, buttonOneTitle: "Aceptar", buttonOneActionHandler: {
                    if isFavoriteTab {
                        if let showIndex = self.viewModel.showData.firstIndex(where: { $0.idShow == self.viewModel.favoriteShow[indexRow].idShow }) {
                            self.viewModel.showData[showIndex].isFavorite = false
                            self.viewModel.coreDataManager.updateShow(show: self.viewModel.showData[showIndex], entity: "TvShows")
                        }
                    } else {
                        self.viewModel.showData[indexRow].isFavorite = false
                    }
                    self.viewModel.filterFavoriteShows()
                    self.listShowsTableViewCell.reloadData()
                }, buttonTwoActionHandler: {
                    print("cancelo accion")
                })
                completionHandler(true)
            }
            markFavorite.backgroundColor = .red
        } else {
            markFavorite = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completionHandler) in
                self.viewModel.alert.alertWithTwOptions(viewController: self, title: AlertTitles.addFavorite.rawValue, message: AlertsMessage.addFavorite.rawValue, buttonOneTitle: "Aceptar", buttonOneActionHandler: {
                    if isFavoriteTab {
                    } else {
                        self.viewModel.showData[indexRow].isFavorite = true
                        self.viewModel.coreDataManager.updateShow(show: self.viewModel.showData[indexRow], entity: "TvShows")
                        let data = self.viewModel.coreDataManager.getShows(entity: "TvShows")
                        print("xd", data)
                    }
                    self.viewModel.filterFavoriteShows()
                    self.listShowsTableViewCell.reloadData()
                }, buttonTwoActionHandler: {
                    print("cancelo accion")
                })
                completionHandler(true)
            }
            markFavorite.backgroundColor = .systemGreen
        }
         
        let configuration = UISwipeActionsConfiguration(actions: [markFavorite])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}

extension HomeViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item == tabBar.items?[0] {
            print("indice 0")
            listShowsTableViewCell.reloadData()
        } else if item == tabBar.items?[1]{
            print("indice 1")
            viewModel.filterFavoriteShows()
            listShowsTableViewCell.reloadData()
        }
    }
}
extension HomeViewController: FavoriteUpdateDelegate {
    func updateShowList(show: ShowsModel, index: Int) {
        for (index,shows) in viewModel.showData.enumerated() {
            if shows.idShow == show.idShow {
                self.viewModel.showData[index] = show
            }
        }
        self.viewModel.coreDataManager.updateShow(show: show, entity: "TvShows")
        self.viewModel.filterFavoriteShows()
        self.listShowsTableViewCell.reloadData()
    }
}
