//
//  LoadingView.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/24/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    private var textLogo = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateLoading() {
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: [.repeat, .calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3, animations: { 
                self.textLogo.transform = CGAffineTransform.init(rotationAngle: 6.28 / 3)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.3, animations: {
                self.textLogo.transform = CGAffineTransform.init(rotationAngle: 6.28 / 3 * 2)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 0.3, animations: {
                self.textLogo.transform = CGAffineTransform.init(rotationAngle: 6.28)
            })
        })
    }
    
    private func setupSubview() {
        textLogo = UILabel(frame: CGRect(x: frame.width * 0.25,
                                         y: frame.height * 0.35,
                                         width: frame.width * 0.5,
                                         height: frame.width * 0.5))
        addSubview(textLogo)
        textLogo.font = UIFont(name: "Palatino-Italic", size: frame.height / 6)
        textLogo.textAlignment = .center
        textLogo.textColor = UIColor.cyan
        textLogo.text = "P"
        textLogo.layer.borderWidth = 4
        textLogo.layer.borderColor = UIColor.cyan.cgColor
        textLogo.layer.cornerRadius = textLogo.frame.width / 2
    }
    
}
