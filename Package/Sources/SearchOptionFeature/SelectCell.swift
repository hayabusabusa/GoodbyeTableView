//
//  SelectCell.swift
//  
//
//  Created by Shunya Yamada on 2022/12/26.
//

import UIKit

final class SelectCell: UICollectionViewCell {

    // MARK: Subviews

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .link
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4.0
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

    func configure(with title: String, isSelected: Bool) {
        titleLabel.text = title
        checkmarkImageView.image = isSelected ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
    }
}

// MARK: - Configurations

private extension SelectCell {
    func configure() {
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .systemGray.withAlphaComponent(0.3)

        configureSubviews()
    }

    func configureSubviews() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(checkmarkImageView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}

#if DEBUG
import SwiftUI

private extension SelectCell {
    struct Wrapped: UIViewRepresentable {
        typealias UIViewType = SelectCell

        func makeUIView(context: Context) -> SelectCell {
            let cell = SelectCell()
            cell.configure(with: "タイトル", isSelected: true)
            return cell
        }

        func updateUIView(_ uiView: SelectCell, context: Context) {}
    }
}

struct SelectCell__Preview: PreviewProvider {
    static var previews: some View {
        SelectCell.Wrapped()
            .previewLayout(.fixed(width: 320, height: 44))
    }
}
#endif
