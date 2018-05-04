//
//  MyBeastsCollectionViewController.swift
//  MagnificentBeasts
//
//  Created by LS on 2018-05-01.
//  Copyright © 2018 SeeTechnologies Inc. All rights reserved.
//

import UIKit

public enum CollectionStyle {
    case MyBeasts,
    BeastFinder
}

private let reuseIdentifier = "MyBeastCell"
private let loggedInOwnerId = Int64(1) // LS - login screen out of scope
private let noOwnerId = Int64(0) // LS - beasts with no owner for Beast Finder

protocol MyBeastsCollectionViewControllerDelegate
{
    func showDetails(beast: MyBeast)
}

class MyBeastsCollectionViewController: UICollectionViewController {
    private var fetchedResultsController = BeastsManager.beastsFetchedResultsController(ownerId: loggedInOwnerId)
    public var collectionStyle: CollectionStyle = .BeastFinder
    public var delegate: MyBeastsCollectionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // LS - remove line below, this CollectionViewController boilerplate overrides the class set in the storyboard!
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        switch collectionStyle {
        case .MyBeasts:
            configureForMyBeasts()
        case .BeastFinder:
            configureForBeastFinder()
        }
    }
    
    private func configureForMyBeasts()
    {
        if let layout = self.collectionView!.collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.scrollDirection = .vertical
            fetchedResultsController = BeastsManager.beastsFetchedResultsController(ownerId: loggedInOwnerId)
        }
    }

    private func configureForBeastFinder()
    {
        if let layout = self.collectionView!.collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 100, height: 100)
            fetchedResultsController = BeastsManager.beastsFetchedResultsController(ownerId: noOwnerId)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        do {
            try fetchedResultsController.performFetch()
        } catch let error as Error {
            print("Fetched results controller fetch failed with error - \(error.localizedDescription)")
        }
        
        if let count = fetchedResultsController.fetchedObjects?.count
        {
            return count
        }
        else
        {
            return 1
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BeastCollectionViewCell
        
        if fetchedResultsController.fetchedObjects?.count != nil
        {
            let beast = fetchedResultsController.object(at: indexPath)
            cell.nameLabel.text = beast.name
            
            // LS - data model enforces name is not optional
            if let image = ImageManager.keyImage(imagePrefix: beast.name!, imageExtension: "jpeg")
            {
               cell.beastImage.image = image
            }
            else
            {
                cell.beastImage.image = UIImage(named: "No Beasts")
            }
        }
        else
        {
            cell.nameLabel.text = "No beasts for you..."
        }
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if fetchedResultsController.fetchedObjects?.count != nil
        {
            let beast = fetchedResultsController.object(at: indexPath)
            
            delegate?.showDetails(beast: beast)
        }
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

}
