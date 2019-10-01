//
//  FavoriteViewController.swift
//  PersistenceLab
//
//  Created by albert coelho oliveira on 10/1/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    var favorite = [Photos](){
        didSet{
            favoriteTable.reloadData()
        }
    }
    @IBOutlet weak var favoriteTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTable.delegate = self
        favoriteTable.dataSource = self
      
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
   func loadData(){
        do {
            favorite = try PhotoPersistenceHelper.manager.getPhotos()
        } catch {
            print(error)
        }
    }

  
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = favoriteTable.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as? FavoriteTableViewCell {
        let data = favorite[indexPath.row]
        ImageHelper.shared.getImage(urlStr: data.largeImageURL) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
               print(error)
                case .success(let image):
                    cell.favImage.image = image
                }
            }
        }
        return cell
    }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
        
    }
}
