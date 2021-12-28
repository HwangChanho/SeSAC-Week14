//
//  LottoViewController.swift
//  SeSAC-Week14
//
//  Created by AlexHwang on 2021/12/28.
//
// MVVM 의 V
import UIKit
import SnapKit

class LottoViewController: UIViewController {
    
    let viewModel = LottoViewModel()
    let mainView = LottoView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.lotto1.bind { num in
            print(num)
            self.mainView.label1.text = "\(num)"
        }
        
        viewModel.lotto2.bind { num in
            self.mainView.label2.text = "\(num)"
        }
        
        viewModel.lotto3.bind { num in
            self.mainView.label3.text = "\(num)"
        }
        
        viewModel.lotto4.bind { num in
            self.mainView.label4.text = "\(num)"
        }
        
        viewModel.lotto5.bind { num in
            self.mainView.label5.text = "\(num)"
        }
        
        viewModel.lotto6.bind { num in
            self.mainView.label6.text = "\(num)"
        }
        
        viewModel.lotto7.bind { num in
            self.mainView.label7.text = "\(num)"
        }
        
        viewModel.lottoMoney.bind {
            self.mainView.moneyLabel.text = "\($0)"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.fetchLottoAPI(678)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            self.viewModel.fetchLottoAPI(676)
        }
    }
}
