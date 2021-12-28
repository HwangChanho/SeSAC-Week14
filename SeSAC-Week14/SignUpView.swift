//
//  SignInView.swift
//  SeSAC-Week14
//
//  Created by AlexHwang on 2021/12/27.
//

import UIKit

protocol ViewRepresentable {
    func setUpView()
    func setUpConstraints()
}

class SignInView: UIView, ViewRepresentable {
    
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let signInButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpView() {
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(signInButton)
        
        usernameTextField.backgroundColor = .white
    }
    
    func setUpConstraints() {
        
    }
}
