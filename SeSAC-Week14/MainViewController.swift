//
//  MainViewController.swift
//  SeSAC_AuthPractice
//
//  Created by hoseung Lee on 2021/12/27.
//

import UIKit

class MainViewController: UIViewController {
  let label = UILabel()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    label.text = "Welcome"
    
    label.frame = .init(x: view.bounds.midX, y: view.bounds.midY, width: 100, height: 100)
    label.textColor = .white
    view.addSubview(label)
  }
}
