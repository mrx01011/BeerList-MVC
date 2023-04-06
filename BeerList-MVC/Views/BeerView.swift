//
//  BeerView.swift
//  BeerList-MVC
//
//  Created by Vladyslav Nhuien on 06.04.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class BeerView: UIView {
    private let beerImageView: UIImageView = {
        let beerImageView = UIImageView()
        beerImageView.contentMode = .scaleAspectFit
        beerImageView.snp.makeConstraints { make in
            make.height.width.equalTo(UIScreen.main.bounds.height / 3.5)
        }
        return beerImageView
    }()
    private let idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.textColor = UIColor.orange
        idLabel.text = ""
        idLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        return idLabel
    }()
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Please Search Beer by ID"
        return nameLabel
    }()
    private let descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = ""
        descLabel.textColor = UIColor.gray
        descLabel.numberOfLines = 0
        return descLabel
    }()
    private lazy var nameStackView: UIStackView = {
        let nameStackView = UIStackView(arrangedSubviews: [beerImageView, idLabel, nameLabel, descLabel])
        nameStackView.axis = .vertical
        nameStackView.alignment = .center
        nameStackView.spacing = Constants.stackSpacing
        return nameStackView
    }()
    
    // MARK: Initialization
    init() {
        super.init(frame: .zero)
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: Public Methods
    func setupView(model: Beer) {
        DispatchQueue.main.async { // Change UI
            self.beerImageView.kf.setImage(with: URL(string: model.imageURL ?? ""))
            self.idLabel.text = String(model.id ?? 0)
            self.nameLabel.text =  model.name ?? ""
            self.descLabel.text = model.description ?? ""
        }
    }
    
    // MARK: Private Methods
    private func setupSubview() {
        addSubview(nameStackView)
        nameStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(Constants.padding)
        }
    }
}

// MARK: - Constants
extension BeerView {
    enum Constants {
        static let stackSpacing: CGFloat = 10.0
        static let padding: CGFloat = 16.0
    }
}
