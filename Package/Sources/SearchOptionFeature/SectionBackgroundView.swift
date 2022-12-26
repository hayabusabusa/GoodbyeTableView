//
//  SectionBackgroundView.swift
//  
//
//  Created by Shunya Yamada on 2022/12/26.
//

import UIKit

final class SectionBackgroundView: UICollectionReusableView {

    private lazy var decorationView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.3).cgColor
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SectionBackgroundView {
    func configure() {
        addSubview(decorationView)

        NSLayoutConstraint.activate([
            decorationView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            decorationView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            decorationView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            decorationView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
}
