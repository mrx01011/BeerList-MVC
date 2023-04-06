//
//  SearchBeerViewController.swift
//  BeerList-MVC
//
//  Created by Vladyslav Nhuien on 06.04.2023.
//

import UIKit
import SnapKit

final class SearchBeerViewController: UIViewController {
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let beerView = BeerView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let networkingApi: NetworkingService!
    
    // MARK: Initialization
    init(networkingApi: NetworkingService = NetworkingAPI()) {
        self.networkingApi = networkingApi
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupNavigationTitle()
        setupSearch()
    }
    
    // MARK: Private Methods
    private func setupNavigationTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Search By ID"
        self.navigationItem.accessibilityLabel = "Search By Beer ID"
    }
    
    private func setupSearch() {
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.keyboardType = .numberPad
    }
    
    private func setupSubview() {
        view.backgroundColor = .white
        view.addSubview(beerView)
        view.addSubview(activityIndicator)
        
        beerView.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide)
            make.size.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
// MARK: UISearchResultsUpdating
extension SearchBeerViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != "" {
            self.activityIndicator.startAnimating()
            networkingApi.searchBeer(id: Int(searchController.searchBar.text!)!, completion: { [weak self] beers in
                guard let self else { return }
                self.beerView.setupView(model: beers.first!)
            })
            self.activityIndicator.stopAnimating()
        }
    }
}

