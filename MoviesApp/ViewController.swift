//
//  ViewController.swift
//  MoviesApp
//
//  Created by Ramiro Gutierrez on 12/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var onboardingPageControl: UIPageControl!
    @IBOutlet weak var onboardingImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nextBtn: PrimaryButtonClass!
    @IBOutlet weak var backBtn: PrimaryButtonClass!
    
    let messagesArray: [String] = [AppMessages.onboardingMessageOne.rawValue, AppMessages.onboardingMessageTwo.rawValue, AppMessages.onboardingMessageThree.rawValue]
    let imageOnboardignArray: [UIImage] = [UIImage(named: "ic_onboarding")!, UIImage(named: "ic_onboarding_2")!, UIImage(named: "ic_onboarding_3")!]
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        onboardingPageControl.pageIndicatorTintColor = .gray
        onboardingPageControl.currentPageIndicatorTintColor = .purple
        onboardingPageControl.currentPage = 0
        messageLabel.text = messagesArray[0]
        onboardingImageView.image = imageOnboardignArray[0]
        backBtn.isHidden = true
    }
    
    @IBAction func backActionBtn(_ sender: Any) {
        for _ in onboardingPageControl.numberOfPages.description {
            print("valor de count", count)
            if count == 1 {
                backBtn.isHidden = true
            }
            if count > 0{
                count -= 1
                onboardingImageView.image = imageOnboardignArray[count]
                onboardingPageControl.currentPage = count
                messageLabel.text = messagesArray[count]
            }
        }
    }
    
    @IBAction func nextActionBtn(_ sender: Any) {
        
        for _ in onboardingPageControl.numberOfPages.description {
            if count  < Int(onboardingPageControl.numberOfPages.description)! - 1 {
                count += 1
                onboardingImageView.image = imageOnboardignArray[count]
                onboardingPageControl.currentPage = count
                messageLabel.text = messagesArray[count]
                backBtn.isHidden = false
                
            } else {
                let homeVc = ViewControllerManager.shared.getHomeViewController()
                self.navigationController?.pushViewController(homeVc, animated: true)
            }
        }
    }
}

