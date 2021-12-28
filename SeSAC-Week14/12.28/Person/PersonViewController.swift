//
//  PersonViewController.swift
//  SeSAC-Week14
//
//  Created by AlexHwang on 2021/12/28.
//

import SnapKit
import UIKit

class PersonViewController: UIViewController {
    
    private var viewModel = PersonViewModel()
    
    fileprivate var tableView = UITableView()
    fileprivate var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(view)
        }
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        viewModel.person.bind { person in
            self.tableView.reloadData()
        }
    }
    
}
extension PersonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.fetchPerson(query: searchBar.text!, page: 1)
    }
}

extension PersonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.textLabel?.text = "\(data.name) | \(data.knownForDepartment)"
        
        return cell
    }
}
