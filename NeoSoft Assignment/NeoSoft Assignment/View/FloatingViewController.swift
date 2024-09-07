//
//  FloatingViewController.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 07/09/24.
//

import UIKit

class FloatingViewController: UIViewController {
    
    var statistic: FloaterItem?
    private let itemCountLabel = UILabel()
    private let characterOccurrencesLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
        setupUI()
        updateStatistics()
    }
    
    private func setupUI() {
        itemCountLabel.numberOfLines = 0
        characterOccurrencesLabel.numberOfLines = 0
        
        itemCountLabel.translatesAutoresizingMaskIntoConstraints = false
        characterOccurrencesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemCountLabel)
        view.addSubview(characterOccurrencesLabel)
        
        NSLayoutConstraint.activate([
            itemCountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            itemCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            itemCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            characterOccurrencesLabel.topAnchor.constraint(equalTo: itemCountLabel.bottomAnchor, constant: 10),
            characterOccurrencesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            characterOccurrencesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            characterOccurrencesLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    private func updateStatistics() {
        guard let statistic else { return }
        itemCountLabel.text = "List 1 (\(statistic.itemCount) items)"
        
        var occurrencesText = "Top 3 Occurrences:\n"
        for item in statistic.topCharacters {
            occurrencesText += "\(item.character) = \(item.count)\n"
        }
        characterOccurrencesLabel.text = occurrencesText
    }
}

