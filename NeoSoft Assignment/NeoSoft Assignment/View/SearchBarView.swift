//
//  SearchBarView.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 07/09/24.
//

import UIKit

protocol SearchBarViewDelegate {
    func textDidChange(searchText: String)
}

class SearchBarView: UIView, UISearchBarDelegate {
    
    var searchBar: UISearchBar!
    var delegate: SearchBarViewDelegate?
    
    func configureUI() {
        searchBar = UISearchBar(frame: CGRect(x: 30, y: 0, width: self.bounds.width, height: 50))
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.layer.cornerRadius = 10 
            searchTextField.layer.masksToBounds = true
        }
        searchBar.clipsToBounds = true
        searchBar.layer.cornerRadius = 10
        searchBar.delegate = self
        searchBar.returnKeyType = .search
        searchBar.placeholder = "Search"
        self.addSubview(searchBar)
    }
    
    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.textDidChange(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        delegate?.textDidChange(searchText: "")
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
