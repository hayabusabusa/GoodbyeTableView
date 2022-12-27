//
//  PlaceCell.swift
//  
//
//  Created by Shunya Yamada on 2022/12/27.
//

import UIKit

final class PlaceCell: UICollectionViewCell {

    // MARK: Subviews

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mappin")
        imageView.tintColor = .systemGray2
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var kiloMetersLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var iconsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var textsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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

    func configure(with title: String, kilometers: String?, address: String?) {
        titleLabel.text = title
        kiloMetersLabel.text = kilometers
        addressLabel.text = address
        addressLabel.isHidden = address == nil
    }
}

// MARK: - Configurations

private extension PlaceCell {
    func configure() {
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .systemGray.withAlphaComponent(0.3)

        configureSubviews()
    }

    func configureSubviews() {
        addSubview(contentStackView)
        addSubview(separatorView)
        contentStackView.addArrangedSubview(iconsStackView)
        contentStackView.addArrangedSubview(textsStackView)
        iconsStackView.addArrangedSubview(iconImageView)
        iconsStackView.addArrangedSubview(kiloMetersLabel)
        textsStackView.addArrangedSubview(titleLabel)
        textsStackView.addArrangedSubview(addressLabel)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
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

private extension PlaceCell {
    struct Wrapped: UIViewRepresentable {
        typealias UIViewType = PlaceCell

        func makeUIView(context: Context) -> PlaceCell {
            let cell = PlaceCell()
            cell.configure(with: "タイトル",
                           kilometers: "999km",
                           address: "東京都渋谷区")
            return cell
        }

        func updateUIView(_ uiView: PlaceCell, context: Context) {}
    }
}

struct PlaceCell__Preview: PreviewProvider {
    static var previews: some View {
        PlaceCell.Wrapped()
            .previewLayout(.fixed(width: 320, height: 64))
    }
}
#endif
