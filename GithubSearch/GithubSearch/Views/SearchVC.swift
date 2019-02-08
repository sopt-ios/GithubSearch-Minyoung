//
//  SearchVC.swift
//  GithubSearch
//
//  Created by 구민영 on 08/02/2019.
//  Copyright © 2019 구민영. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var itemList = [Items]()
    var reposNumList = [Int]()
    var curPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func getData(input : String) {
        if curPage == 0 {
            SearchService.shared.getResultList(page: curPage, limit: 20, input: input) { (data) in
                self.curPage = 1
                self.itemList = data
                self.tableView.reloadData()
            }
        }
    }
    
    func getMoreData(input : String) {
        if curPage > 0 {
            SearchService.shared.getResultList(page: curPage, limit: 20, input: input) { (data) in
                self.itemList += data
                self.tableView.reloadData()
            }
        }
    }
}

extension SearchVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let text = searchBar.text else {return}
        if indexPath.row == itemList.count - 1 {
            self.curPage += 1
            self.getMoreData(input : text)
        }
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
        }
    }
}

extension SearchVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchResultCell
        let login = itemList[indexPath.row].login
        
        cell.nameLb.text = login
        
        SearchService.shared.getNumOfRepos(name: login ?? "") { (data) in
            cell.reposNum.text = "\(data)"
            //self.tableView.reloadData()
        }
        
        if let imageUrl = itemList[indexPath.row].avatar_url{
            let image = ImageCache.shared.image(forUrl: imageUrl)
            { (image) in
                if image != nil {
                    cell.imgView.image = image
                }
            }
            cell.imgView?.image = image ?? #imageLiteral(resourceName: "default")
        }
        
        return cell
    }
}

extension SearchVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        curPage = 0
        getData(input : searchBar.text ?? "")
    }
}
