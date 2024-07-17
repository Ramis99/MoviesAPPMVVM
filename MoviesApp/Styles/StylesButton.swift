//
//  StylesButton.swift
//  MoviesApp
//
//  Created by Ramiro Gutierrez on 13/07/24.
//

import Foundation
import UIKit

class PrimaryButtonClass: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .systemBlue
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        layer.cornerRadius = 10
    }
}
