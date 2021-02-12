//
//  GRTitleLabel.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 11/02/2021.
//

import UIKit

class GRTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, textColor: UIColor) {
        self.init(frame: .zero)
        self.textColor      = textColor
        self.textAlignment  = textAlignment
        self.font           = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    
    private func configure() {
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        numberOfLines               = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
}
