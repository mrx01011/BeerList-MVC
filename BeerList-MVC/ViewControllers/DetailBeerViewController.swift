//
//  DetailBeerViewController.swift
//  BeerList-MVC
//
//  Created by Vladyslav Nhuien on 06.04.2023.
//

import UIKit
import SnapKit

final class DetailBeerViewController: UIViewController {
    private let detailView = BeerView()
    private let beer: Beer
    
    // MARK: Initialization
    init(beer: Beer) {
      self.beer = beer
      super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
      return nil
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
    }
    
    // MARK: Private Methods
    private func setupSubview() {
        view.backgroundColor = .white
        view.addSubview(detailView)
        
        detailView.setupView(model: beer)
        
        detailView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.size.equalToSuperview()
        }
    }
}

