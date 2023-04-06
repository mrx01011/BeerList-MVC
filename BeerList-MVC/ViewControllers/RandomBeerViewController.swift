//
//  RandomBeerViewController.swift
//  BeerList-MVC
//
//  Created by Vladyslav Nhuien on 06.04.2023.
//

import UIKit
import Kingfisher

final class RandomBeerViewController: UIViewController {
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let randomView = BeerView()
    private let networkingApi: NetworkingService!
    private let randomButton: UIButton = {
        let randomButton = UIButton()
        randomButton.setTitle("Roll Random", for: .normal)
        randomButton.backgroundColor = UIColor.orange
        return randomButton
    }()
    
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
        getRandom()
        addTargets()
    }
    
    // MARK: Private Methods
    private func setupNavigationTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Random Beer"
        self.navigationItem.accessibilityLabel = "Random by Button"
    }
    
    private func getRandom() {
        self.activityIndicator.startAnimating()
        networkingApi.getRandomBeer(completion: { [weak self] beers in
            guard let self else { return }
            self.randomView.setupView(model: beers.first ?? Beer(id: 0, name: "", description: "", imageURL: ""))
        })
        self.activityIndicator.stopAnimating()
    }
    
    private func setupSubview() {
        view.addSubview(randomView)
        view.addSubview(activityIndicator)
        randomView.addSubview(randomButton)
        
        randomView.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide)
            make.size.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        randomButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.layoutMarginsGuide).offset(-30)
            make.width.equalTo(view.snp.width).offset(-30)
            make.height.equalTo(40)
        }
    }
    
    private func addTargets() {
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
    }
    
    @objc private func randomButtonTapped() {
        getRandom()
    }
}
