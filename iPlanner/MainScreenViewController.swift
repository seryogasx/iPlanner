//
//  MainScreenViewController.swift
//  iPlanner
//
//  Created by Сергей Петров on 24.06.2021.
//

import UIKit

class MainScreenViewController: UIViewController {

    let sections = ["Избранное", "Контакты", "Действия"]
    let favorites = ["kek1", "cheburek2", "oladushek"]
    let contacts = ["jenka", "ilya", "seryogas", "nikita"]
    let actions = ["Present", "joke"]
    
    let cellIdentifier = "CollectionViewCellIdentifier"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let nibCell = UINib(nibName: "MainScreenCollectionViewCell", bundle: nil)
//        self.collectionView.register(MainScreenCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView.register(MainScreenCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MainScreenCollectionViewCell
        print(cell)
        print(cell.label)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    
}

extension MainScreenViewController: UICollectionViewDelegate {
    
}
