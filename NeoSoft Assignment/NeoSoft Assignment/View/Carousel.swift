//
//  Carousel.swift
//  NeoSoft Assignment
//
//  Created by  Prince Shrivastav on 07/09/24.
//

import UIKit

protocol CarouselViewDelegate {
    func updateList(currentData: CarouselImage)
}

class Carousel: UIView {
    
    var collectionView: UICollectionView!
    var pageControl: UIPageControl!
    var dataSource: [CarouselImage] = []
    var delegate: CarouselViewDelegate?
    
    func configureUI(dataSource: [CarouselImage] ) {
        self.dataSource = dataSource
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: CGRect(x: 30, y: 0, width: self.bounds.width - 60, height: self.bounds.height - 10), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.cornerRadius = 10
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: "CarouselCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.addSubview(collectionView)
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: collectionView.bounds.maxY , width: self.bounds.width, height: 30))
        pageControl.numberOfPages = dataSource.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.currentPageIndicatorTintColor = .blue
                
        self.addSubview(pageControl)
    }
    
}


extension Carousel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselCell
        cell.setupCell(item: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
        delegate?.updateList(currentData: dataSource[Int(pageIndex)])
    }
}
