//
//  BeerListViewController.swift
//  BeerList-MVC
//
//  Created by Vladyslav Nhuien on 06.04.2023.
//

import UIKit
import SnapKit

final class BeerListViewController: UIViewController {
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: "BeerTableViewCell")
        return tableView
    }()
    
    private var beers: [Beer] = []
    private var page = 1
    
    private let networkingApi: NetworkingService!
    
    // MARK: Initialization
    init(networkingApi: NetworkingService = NetworkingAPI()) {
        self.networkingApi = networkingApi
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupNavigationTitle()
        getBeerList()
        setupDelegates()
        addTargets()
    }
    
    // MARK: Private Methods
    private func setupSubview() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        tableView.addSubview(refreshControl)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupNavigationTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "BeerList"
        self.navigationItem.accessibilityLabel = "BeerList"
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addTargets() {
        refreshControl.addTarget(self, action: #selector(resetView), for: .valueChanged)
    }
    
    private func getBeerList() {
        self.activityIndicator.startAnimating()
        networkingApi.getBeerList(page: self.page, completion: { [weak self] beers in
            guard let self else { return }
            self.beers += beers
            DispatchQueue.main.async { // Change UI
                self.tableView.reloadData()
            }
        })
        self.activityIndicator.stopAnimating()
    }
    
    @objc private func resetView() {
        networkingApi.getBeerList(page: 1, completion: { [weak self] beers in
            guard let self else { return }
            self.beers = beers
            DispatchQueue.main.async { // Change UI
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        })
    }
}

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerTableViewCell") as? BeerTableViewCell else { return UITableViewCell() }
        cell.setupView(model: beers[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if Int(scrollView.contentOffset.y) >= 1800 * self.page { // FIXME: Not perfect
            self.page += 1
            self.getBeerList()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailBeerViewController(beer: beers[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


