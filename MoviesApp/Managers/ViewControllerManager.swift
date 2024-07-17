//
//  ViewControllerManager.swift
//  MoviesApp
//
//  Created by Ramiro Gutierrez on 13/07/24.
//

import Foundation


class ViewControllerManager {
    
    static let shared = ViewControllerManager()
        
    private var homeViewController: HomeViewController?
    private var detailShowController: DetailsShowViewController?
    
    func getHomeViewController() -> HomeViewController {
        if homeViewController == nil {
            homeViewController = HomeViewController()
        }
        return homeViewController!
    }
    
    func getDetailShow() -> DetailsShowViewController {
        if detailShowController == nil {
            detailShowController = DetailsShowViewController()
        }
        return detailShowController!
    }
}
