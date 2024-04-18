//
//  SecondVC.swift
//  PlatePalace
//
//  Created by PHN MAC 1 on 18/04/24.
//

import UIKit

class MessListCell: UITableViewCell{
    
}

class SecondVC: UIViewController {

    @IBOutlet weak var messList: UITableView!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSearchBarConfig()
    }
    
    private func uiSearchBarConfig(){
        // Create a UISearchController instance
        searchController = UISearchController(searchResultsController: nil)
        
        // Configure the search bar
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = .systemOrange
        
        // Assign the searchController to the navigationItem
        navigationItem.searchController = searchController
        
        // Ensure the search bar does not remain on the screen if the user navigates to another view controller while the UISearchController is active
        definesPresentationContext = true
    }
}

extension SecondVC: UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension SecondVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messList.dequeueReusableCell(withIdentifier: MessListCell.id, for: indexPath) as! MessListCell
        return cell
    }
}


extension SecondVC: UITableViewDelegate{
    
}
