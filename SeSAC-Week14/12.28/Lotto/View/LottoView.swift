//
//  LottoView.swift
//  SeSAC-Week14
//
//  Created by AlexHwang on 2021/12/28.
//

import UIKit

class LottoView: UIView, ViewRepresenable {
    
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    let label5 = UILabel()
    let label6 = UILabel()
    let label7 = UILabel()
    let label8 = UILabel()
    let label9 = UILabel()
    let datelabel = UILabel()
    let moneyLabel = UILabel()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.spacing = 0
        view.backgroundColor = .white
        view.distribution = .fillEqually
        
        return view
    }()
    
    func setupView() {
        
    }
    
    func setupConstrains() {
        addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(50)
            $0.center.equalToSuperview()
        }
        
        [label1, label2, label3, label4, label5, label6, label7].forEach {
            $0.backgroundColor = .lightGray
            stackView.addSubview($0)
        }
        
        addSubview(datelabel)
        datelabel.backgroundColor = .white
        datelabel.snp.makeConstraints{
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        addSubview(moneyLabel)
        moneyLabel.backgroundColor = .white
        moneyLabel.snp.makeConstraints{
            $0.top.equalTo(datelabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
      setupConstrains()
    }
    
    required init?(coder: NSCoder) {
      super.init(coder: coder)
    }
    
}


