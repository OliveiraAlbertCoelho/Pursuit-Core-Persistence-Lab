//
//  DetailViewController.swift
//  PersistenceLab
//
//  Created by albert coelho oliveira on 9/30/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var photo: Photos!
    @IBOutlet weak var imageSelect: UIImageView!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var tags: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUp()
        setUpImage()
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        do{
            try PhotoPersistenceHelper.manager.savePhotos(newPhoto: photo)
        }
        catch {
            print(error)
        }
    }
    
    func loadUp(){
        likes.text = "👍 \(photo.likes.description)"
        views.text = "\(photo.views.description) people viewed this"
        tags.text = "# \(photo.tags)"
        
    }
    func setUpImage(){
        let url = photo?.largeImageURL
        ImageHelper.shared.getImage(urlStr: url!) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let success):
                    self.imageSelect.image = success
                }
            }
        }
    }

}
