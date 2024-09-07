//
//  CarouselViewController.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 07/09/24.
//

import UIKit

class CarouselViewController: UIViewController {
    
    var viewModel: CarouselListViewModel = CarouselListViewModel(parser: DataParser())
    var carouselUIView: Carousel?
    var tableView: UITableView!
    var searchBar: SearchBarView!
    var floatingButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    fileprivate func initialSetup()  {
         Task {
            do {
                try await viewModel.fetchListData()
                await configureView()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    fileprivate func configureView() async {
        carouselUIView = Carousel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 220))
        carouselUIView?.configureUI(dataSource: viewModel.carouselList?.carouselImages ?? [])
        carouselUIView?.delegate = self
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .plain)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ListViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableHeaderView = carouselUIView
        view.addSubview(tableView)
        
        setupFloatingButton()
        
        searchBar = SearchBarView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width - 60, height: 50))
        searchBar.configureUI()
        searchBar.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
       @objc func dismissKeyboard() {
           view.endEditing(true)
       }
    
    fileprivate func setupFloatingButton() {
        
        floatingButton = UIButton(type: .custom)
        floatingButton.setImage(UIImage(systemName: "ellipsis")?.withRenderingMode(.alwaysTemplate), for: .normal)
        floatingButton.tintColor = .white
        floatingButton.backgroundColor = .systemBlue
        floatingButton.layer.cornerRadius = 25
        floatingButton.layer.shadowOpacity = 0.3
        floatingButton.layer.shadowRadius = 10
        floatingButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        floatingButton.transform = CGAffineTransform(rotationAngle: .pi / 2)

        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
        view.addSubview(floatingButton)
        
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            floatingButton.widthAnchor.constraint(equalToConstant: 50),
            floatingButton.heightAnchor.constraint(equalToConstant: 50),
            floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            floatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
    
    
    @objc fileprivate func floatingButtonTapped() {
        let floatingVC = FloatingViewController()
        floatingVC.statistic = viewModel.floaterItem
        let sheet = UINavigationController(rootViewController: floatingVC)
        sheet.modalPresentationStyle = .pageSheet
        if let sheetController = sheet.sheetPresentationController {
            sheetController.detents = [.medium()]
        }
        present(sheet, animated: true, completion: nil)
    }
    
}
extension CarouselViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListViewCell else { return UITableViewCell() }
        let item = viewModel.filteredItems[indexPath.row]
        cell.configureCell(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchBar
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
extension CarouselViewController: SearchBarViewDelegate {
    func textDidChange(searchText: String) {
        viewModel.searchItems(for: searchText)
        tableView.reloadData()
    }
}
extension CarouselViewController: CarouselViewDelegate {
    func updateList(currentData: CarouselImage) {
        viewModel.selectedCarouselId = currentData.id
        viewModel.filteredItems = currentData.items
        tableView.reloadData()
    }
}
