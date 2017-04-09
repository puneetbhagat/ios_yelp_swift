//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MBProgressHUD

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersViewControllerDelegate {
    
    var businesses: [Business]!
    
    var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        // Initialize TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Get Yelp search results
        doSearch(term: "")
    }
    
    // Perform the search.
    fileprivate func doSearch(term: String) {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
//        Business.searchWithTerm(term: (self.searchBar.text)!, completion: { (businesses: [Business]?, error: Error?) -> Void in
        Business.searchWithTerm(term: term, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            
            self.tableView.reloadData()
            
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
        
        //        // Perform request to GitHub API to get the list of repositories
        //        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in
        //
        //            self.repos = (newRepos as? [GithubRepo])!
        //
        //            self.repoTableView.reloadData()
        //
        //            // Print the returned repositories to the output window
        //            for repo in newRepos {
        //                print(repo)
        //            }
        //
        //            MBProgressHUD.hide(for: self.view, animated: true)
        //        }, error: { (error) -> Void in
        //            print(error)
        //        })
    }
    
    fileprivate func doSearch(sort: YelpSortMode, categories: [String], deals: Bool) {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        // Example of Yelp search with more search options specified
        Business.searchWithTerm(term: "Restaurants", sort: sort, categories: categories, deals: deals, completion: { (businesses, error) -> Void in
            
            self.businesses = businesses
            
            self.tableView.reloadData()
            
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            MBProgressHUD.hide(for: self.view, animated: true)
        }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if businesses != nil {
            return businesses.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let navigationController = segue.destination as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        
        filtersViewController.delegate = self
    }
    
    //func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: Filters) {
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject]) {
        
        print("inside filtersViewController")
        print(filters)
        
        if  (filters["categories"] != nil  || filters["sortBy"] != nil
            || filters["deals"] != nil) {
//        if  (filters.selectedCategories != nil  || filters.sortByFilter != nil
//            || filters.hasDealFilter != nil) {
        
            let categories = filters["categories"] as? [String]
            let sortBy = filters["sortBy"] as? YelpSortMode
            let deals = filters["deals"] as? Bool
        
//            let categories = filters.selectedCategories as? [String]
//            let sortBy = filters.sortByFilter as? YelpSortMode
//            let deals = filters.hasDealFilter as? Bool
            
            //doSearch(sort: (sortBy)!, categories: (categories)!, deals: (deals)!)
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            // Example of Yelp search with more search options specified
            Business.searchWithTerm(term: "Restaurants", sort: sortBy, categories: categories, deals: deals, completion: { (businesses, error) -> Void in
                
                self.businesses = businesses
                
                self.tableView.reloadData()
                
                if let businesses = businesses {
                    for business in businesses {
                        print(business.name!)
                        print(business.address!)
                    }
                }
                
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            )
        }
    }
}

// SearchBar methods
extension BusinessesViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            searchBar.text = ""
            doSearch(term: searchBar.text!)
        }
        
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch(term: searchBar.text!)
    }
}

