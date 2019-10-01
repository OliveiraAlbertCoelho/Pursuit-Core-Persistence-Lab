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
    
    var userSearch: String?{
        didSet {tableCollection.reloadData()
        }
    }
    
        
        var filteredPhoto: [Photos] {
        guard let userSearch = userSearch else {
            return photos
        }
    guard userSearch != "" else{
    return photos
    }
  return photos
}

@IBOutlet weak var tableCollection: UICollectionView!
@IBOutlet weak var searchBar: UISearchBar!
override func viewDidLoad() {
    super.viewDidLoad()
    tableCollection.delegate = self
    tableCollection.dataSource = self
    loadData(word: nil)
    searchBar.delegate = self
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
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let photoDetail = segue.destination as? DetailViewController,
        let indexPath = tableCollection.indexPath(for: sender as! UICollectionViewCell)
        else {
            fatalError("Unexpected segue")
    }
    let selected = photos[indexPath.row]
    photoDetail.photo = selected
}

}
extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = tableCollection.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell {
            let data = filteredPhoto[indexPath.row]
            ImageHelper.shared.getImage(urlStr: data.largeImageURL) { (result) in
                DispatchQueue.main.async {
                    switch result{
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        print(data.largeImageURL)
                        cell.photoImage.image = image
                    }
                    
                }
            }
            return cell
        }
        return UICollectionViewCell()
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 400)
    }
}
extension ViewController: UISearchBarDelegate{
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     self.userSearch = searchText
    loadData(word: searchText)
    }
}


