//
//  ToggleCell.swift
//  
//
//  Created by Shunya Yamada on 2022/12/22.
//

import UIKit

final class ToggleCell: UICollectionViewCell {

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

    private lazy var toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
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
                   title: String,
                   isOn: Bool) {
        iconImageView.image = iconImage
        iconBackgroundView.backgroundColor = iconBackgroundColor
        titleLabel.text = title
        toggleSwitch.isOn = isOn
    }
}

private extension ToggleCell {
    func configure() {
        backgroundColor = .systemBackground

        configureSubviews()
    }

    func configureSubviews() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(iconBackgroundView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(toggleSwitch)
        iconBackgroundView.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            iconBackgroundView.widthAnchor.constraint(equalTo: iconBackgroundView.heightAnchor, multiplier: 1),
            iconImageView.topAnchor.constraint(equalTo: iconBackgroundView.topAnchor, constant: 4),
            iconImageView.trailingAnchor.constraint(equalTo: iconBackgroundView.trailingAnchor, constant: -4),
            iconImageView.bottomAnchor.constraint(equalTo: iconBackgroundView.bottomAnchor, constant: -4),
            iconImageView.leadingAnchor.constraint(equalTo: iconBackgroundView.leadingAnchor, constant: 4)
        ])
    }
}

#if DEBUG
import SwiftUI

private extension ToggleCell {
    struct Wrapped: UIViewRepresentable {
        typealias UIViewType = ToggleCell

        func makeUIView(context: Context) -> ToggleCell {
            let view = ToggleCell()
            view.configure(with: UIImage(systemName: "wifi"),
                           iconBackgroundColor: .systemOrange,
                           title: "Wi-Fi",
                           isOn: false)
            return view
        }

        func updateUIView(_ uiView: ToggleCell, context: Context) {}
    }
}

struct ToggleCell__Preview: PreviewProvider {
    static var previews: some View {
        ToggleCell.Wrapped()
            .previewLayout(.fixed(width: 320, height: 44))
    }
}
#endif
