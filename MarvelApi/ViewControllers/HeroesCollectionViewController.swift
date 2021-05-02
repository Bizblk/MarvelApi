//
//  HeroesCollectionViewController.swift
//  MarvelApi
//
//  Created by Виталий Оранский on 02.05.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class HeroesCollectionViewController: UICollectionViewController {
    
    var heroes: [Character]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      //  print(heroes.count)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
      //  print(heroes[0].thumbnail)
        // Register cell classes
     //   self.collectionView!.register(HeroCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return heroes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HeroCollectionViewCell
        cell.heroNameLabel.text = heroes[indexPath.item].name
        
        
        
        
        guard let thumbnail = heroes[indexPath.item].thumbnail else { return cell }
        
        let url = NetworkManager.shared.getImageURL(data: thumbnail)
        
        NetworkManager.shared.fetchImage(url: url) { (image) in
            cell.heroImageView.image = image
        }
        
        //
        //        URLSession.shared.dataTask(with: url) { (data, response, error) in
        //            guard let data = data, let response = response else {
        //                print(error?.localizedDescription ?? "Unknown error")
        //                return
        //            }
        //            print(response)
        //            guard let dataImage = UIImage(data: data) else { return }
        //            DispatchQueue.main.async {
        //                cell.heroImageView.image = dataImage
        //                print(dataImage)
        //            }
        //        }.resume()
        //  collectionView.reloadData()
        
        // Configure the cell
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    
//    func fetchImage(thumbnail: [String: String], image: @escaping (UIImage) -> Void) {
//        
//        let path = thumbnail["path"]
//        let ext = thumbnail["extension"]
//        
//        
//        guard let url = URL(string: "\(path).\(ext)") else { return }
//        print(url)
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data, let response = response else {
//                print(error?.localizedDescription ?? "Unknown error")
//                return
//            }
//            print(response)
//            guard let dataImage = UIImage(data: data) else { return }
//            DispatchQueue.main.async {
//                image(dataImage)
//                print(dataImage)
//            }
//        }.resume()
//        
//    }
    

}


extension HeroesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 20, height: 150)
    }
    
    
}
