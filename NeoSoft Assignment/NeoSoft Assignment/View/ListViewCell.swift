//
//  ListViewCell.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 07/09/24.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .listBackground
        view.layer.cornerRadius = 10
        return view
        
    }()
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        contentView.addSubview(baseView)
        baseView.addSubview(itemImageView)
        baseView.addSubview(titleLabel)
        baseView.addSubview(subTitleLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        baseView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            baseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            itemImageView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 10),
            itemImageView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 5),
            itemImageView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -5),
            itemImageView.widthAnchor.constraint(equalToConstant: 70),
            itemImageView.heightAnchor.constraint(equalToConstant: 70),
            
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 15),
            
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -10),
            subTitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: baseView.bottomAnchor, constant: 15)
        ])
    }
    
    func configureCell(with item: ListItem) {
        itemImageView.image = UIImage(named: item.imageUrl)
        titleLabel.text = item.title
        subTitleLabel.text = item.subTitle
    }
}
