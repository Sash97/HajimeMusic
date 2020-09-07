//
//  ABNavBarView.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/23/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit

class ABNavBarView: UIView {

    //MARK: - Outlets -
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var underLeftButtonView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var underRightButtonView: UIView!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var showHideView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    //MARK: - Properties -
    
    var leftButtonTapped: (()->())?
    
    
    
    //MARK: - Init -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    //MARK: - Methods -
    
    private func configureSubviews() {
        self.setupView()
        self.configureViewStyle()
    }
    
    private func configureViewStyle() {
        self.configureLeftButton()
        self.configureRightButton()
    }
    
    
    private func configureLeftButton() {
        self.navBarButtonDesigner(underView: self.underLeftButtonView, button: self.leftButton,
                                  firstOffset: .init(width: 4, height: 4),
                                  secondOffset: .init(width: -4, height: -4))
    }
    
    private func configureRightButton() {
        self.navBarButtonDesigner(underView: self.underRightButtonView, button: self.rightButton,
                                  firstOffset: .init(width: -4, height: 4),
                                  secondOffset: .init(width: 4, height: -4))
    }
    
    private func navBarButtonDesigner(underView: UIView, button: UIButton, firstOffset: CGSize = .zero, secondOffset: CGSize = .zero) {
        underView.backgroundColor = .clear
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor.rgb(79, 24, 187)
        button.setShadow(color: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1).cgColor, radius: 3, opacity: 1)
    }
    
    
    
    //MARK: - Start Config -
    
    private func setupView() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: Nib.abNavBarView, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    
    
    //MARK: - Actions -
    
    @IBAction func leftButtonAction(_ sender: UIButton) {
        self.leftButtonTapped?()
    }
    
    @IBAction func rightButtonAction(_ sender: UIButton) {
    }
}
