//
//  PlainCell.swift
//  
//
//  Created by Shunya Yamada on 2022/12/19.
//

import UIKit

final class PlainCell: UICollectionViewCell {

    // MARK: Subviews

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var iconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        view.layer.cornerRadius = 4.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var disclosureIndicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .systemGray3
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with iconImage: UIImage?,
                   iconBackgroundColor: UIColor,
                   title: String) {
        iconImageView.image = iconImage
        iconBackgroundView.backgroundColor = iconBackgroundColor
        titleLabel.text = title
    }
}

private extension PlainCell {
    func configure() {
        backgroundColor = .systemBackground
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .systemGray.withAlphaComponent(0.4)

        configureSubviews()
    }

    func configureSubviews() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(iconBackgroundView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(disclosureIndicatorImageView)
        iconBackgroundView.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            iconBackgroundView.widthAnchor.constraint(equalTo: iconBackgroundView.heightAnchor, multiplier: 1),
            disclosureIndicatorImageView.widthAnchor.constraint(equalToConstant: 12),
            iconImageView.topAnchor.constraint(equalTo: iconBackgroundView.topAnchor, constant: 4),
            iconImageView.trailingAnchor.constraint(equalTo: iconBackgroundView.trailingAnchor, constant: -4),
            iconImageView.bottomAnchor.constraint(equalTo: iconBackgroundView.bottomAnchor, constant: -4),
            iconImageView.leadingAnchor.constraint(equalTo: iconBackgroundView.leadingAnchor, constant: 4)
        ])
    }
}

#if DEBUG
import SwiftUI

private extension PlainCell {
    struct Wrapped: UIViewRepresentable {
        typealias UIViewType = PlainCell

        func makeUIView(context: Context) -> PlainCell {
            let view = PlainCell(frame: .zero)
            view.configure(with: UIImage(systemName: "wifi"),
                           iconBackgroundColor: .systemOrange,
                           title: "Wi-Fi")
            return view
        }

        func updateUIView(_ uiView: PlainCell, context: Context) {}
    }
}

struct PlainCell__Preview: PreviewProvider {
    static var previews: some View {
        PlainCell.Wrapped()
            .previewLayout(.fixed(width: 320, height: 44))
    }
}
#endif
