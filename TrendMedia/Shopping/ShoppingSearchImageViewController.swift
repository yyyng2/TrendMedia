//
//  ShoppingSearchImageViewController.swift
//  TrendMedia
//
//  Created by Y on 2022/08/24.
//

import UIKit
import Kingfisher

class ShoppingSearchImageViewController: UIViewController {
    
    var delegate: SelectImageDelegate? // 이미지가져오기 deleagte
    var selectImage: UIImage? // 선택된 이미지 가져오기 1.
    var selectIndexPath: IndexPath? //셀 선택표시 1.

    let mainView = ImageSearchView()
    var searchImage: [String] = []

    override func loadView() {
        self.view = mainView
    }
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(ShoppingSearchImageCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingSearchImageCollectionViewCell.reuseIdentifier)
        mainView.searchBar.delegate = self
        
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem = closeButton
        let selectButton = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectButtonClicked))
        navigationItem.rightBarButtonItem = selectButton
        
        searchImage.removeAll()
        APIManager.shared.getImage(query: "Flower", page: 1) { JSON in
            let image = JSON["results"].arrayValue.map {
                $0["urls"]["regular"].stringValue
            }
            self.searchImage.append(contentsOf: image)
            print(self.searchImage)
            self.mainView.collectionView.reloadData()
        }
    }

  
    @objc func closeButtonClicked(){
        dismiss(animated: true)
    }
    @objc func selectButtonClicked(){
        // 선택된 이미지 가져오기 2.
        guard let selectImage = selectImage else {
            showAlert(title: "사진을 선택해주세요.", buttonTitle: "확인")
            return
        }
        
        
        delegate?.sendImageData(image: selectImage)
        dismiss(animated: true)
    }
    
}

extension ShoppingSearchImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchImage.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingSearchImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ShoppingSearchImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // 셀 선택표시 2.
        cell.layer.borderWidth = selectIndexPath == indexPath ? 4 : 0
        cell.layer.borderColor = selectIndexPath == indexPath ? UIColor.red.cgColor : nil
        
        let url = URL(string: searchImage[indexPath.item])
         cell.searchImageView.kf.setImage(with: url)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //셀 선택표시 3.
        selectIndexPath = indexPath

        
        // 선택된 이미지 가져오기 3.
        guard let cell = collectionView.cellForItem(at: indexPath) as? ShoppingSearchImageCollectionViewCell else {return}
        selectImage = cell.searchImageView.image
        collectionView.reloadData()
    }
    
    //과제
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        //셀 선택표시 4. 선택 취소
//        print(#function)
//        selectIndexPath = nil
//        selectImage = nil
//        collectionView.reloadData()
//    }

}

extension ShoppingSearchImageViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let text = searchBar.text {
            searchImage.removeAll()
            APIManager.shared.getImage(query: text, page: 1) { JSON in
                let image = JSON["results"].arrayValue.map {
                    $0["urls"]["regular"].stringValue
                }
                self.searchImage.append(contentsOf: image)
                self.mainView.collectionView.reloadData()
            }
            view.endEditing(true)
        }
    }
}
