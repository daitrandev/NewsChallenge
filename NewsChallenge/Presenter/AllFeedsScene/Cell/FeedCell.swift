//
//  FeedCell.swift
//  NewsChallenge
//
//  Created by Dai Tran on 8/19/23.
//

import UIKit
import Kingfisher

final class FeedCell: UITableViewCell {
    struct Input {
        let imageURL: String
        let title: String
    }
    
    private let feedImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(feedImage)
        NSLayoutConstraint.activate([
            feedImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            feedImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            feedImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            feedImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: feedImage.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with input: Input) {
        if let url = URL(string: input.imageURL) {
            feedImage.kf.setImage(with: url)
        }
        
        titleLabel.text = input.title
    }
}
