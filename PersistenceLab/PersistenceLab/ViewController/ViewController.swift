//
//  ViewController.swift
//  PersistenceLab
//
//  Created by albert coelho oliveira on 9/30/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var photos = [Photos](){
        didSet{
            tableCollection.reloadData()
        }
    }
    @IBOutlet weak var tableCollection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableCollection.delegate = self
        tableCollection.dataSource = self
        loadData(word: nil)
    }
    func loadData(word: String?){
        PhotosAPi.manager.getPhotos(urlStr: word) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let success):
                    self.photos = success
                }
            }
        }
    }
}
extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tableCollection.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell
        let data = photos[indexPath.row]
        ImageHelper.shared.getImage(urlStr: data.largeImageURL) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let image):
                    print(data.largeImageURL)
                    cell?.photoImage.image = image
                }
                
            }
        }
        return cell!
    }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             return CGSize(width: 400, height: 400)
         }
}


