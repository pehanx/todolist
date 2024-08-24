//
//  TodoItemTableViewCell.swift
//  TodoList
//
//  Created by Nikita Spekhin on 24.08.2024.
//

import UIKit

final class TodoItemTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "TodoItemTableViewCell"
    
    // MARK: - Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.attributedText = nil
        subtitleLabel.attributedText = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    // MARK: - Helpers
    private func setupView() {
        contentView.addSubview(textStackView)
        contentView.addSubview(dateLabel)
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            textStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textStackView.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -24),
            textStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    func configure(model: TodoItem) {
        subtitleLabel.isHidden = model.subtitle?.isEmpty ?? true
        if model.isCompleted {
            let titleAttributedText = NSAttributedString(
                string: model.title ?? "",
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            titleLabel.attributedText = titleAttributedText
            let subtitleAttributedText = NSAttributedString(
                string: model.subtitle ?? "",
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            subtitleLabel.attributedText = subtitleAttributedText
        } else {
            titleLabel.text = model.title
            subtitleLabel.text = model.subtitle
        }
        dateLabel.text = model.creationDate?.toString()
    }
}
