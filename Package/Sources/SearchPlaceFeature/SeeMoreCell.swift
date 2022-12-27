//
//  SeeMoreCell.swift
//  
//
//  Created by Shunya Yamada on 2022/12/27.
//

import UIKit

final class SeeMoreCell: UICollectionViewCell {

    // MARK: Subviews

    private lazy var disclosureIndicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .systemGray2
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "もっと見る"
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
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
}

// MARK: - Configurations

private extension SeeMoreCell {
    func configure() {
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .systemGray.withAlphaComponent(0.3)

        configureSubviews()
    }

    func configureSubviews() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(disclosureIndicatorImageView)

        NSLayoutConstraint.activate([
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

#if DEBUG
import SwiftUI

private extension SeeMoreCell {
    struct Wrapped: UIViewRepresentable {
        typealias UIViewType = SeeMoreCell

        func makeUIView(context: Context) -> SeeMoreCell {
            let cell = SeeMoreCell()
            return cell
        }

        func updateUIView(_ uiView: SeeMoreCell, context: Context) {}
    }
}

struct SeeMoreCell__Preview: PreviewProvider {
    static var previews: some View {
        SeeMoreCell.Wrapped()
            .previewLayout(.fixed(width: 320, height: 64))
    }
}
#endif
