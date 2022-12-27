//
//  KeywordCell.swift
//  
//
//  Created by Shunya Yamada on 2022/12/27.
//

import UIKit

final class KeywordCell: UICollectionViewCell {

    // MARK: Subviews

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .systemGray2
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
}

// MARK: - Configurations

private extension KeywordCell {
    func configure() {
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .systemGray.withAlphaComponent(0.3)

        configureSubviews()
    }

    func configureSubviews() {
        addSubview(contentStackView)
        addSubview(separatorView)
        contentStackView.addArrangedSubview(iconImageView)
        contentStackView.addArrangedSubview(titleLabel)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}

#if DEBUG
import SwiftUI

private extension KeywordCell {
    struct Wrapped: UIViewRepresentable {
        typealias UIViewType = KeywordCell

        func makeUIView(context: Context) -> KeywordCell {
            let cell = KeywordCell()
            cell.configure(with: "ラーメン")
            return cell
        }

        func updateUIView(_ uiView: KeywordCell, context: Context) {}
    }
}

struct KeywordCell__Preview: PreviewProvider {
    static var previews: some View {
        KeywordCell.Wrapped()
            .previewLayout(.fixed(width: 320, height: 64))
    }
}
#endif
