//
//  ViewController.swift
//  MagnificentBeasts
//
//  Created by LS on 2018-05-01.
//  Copyright © 2018 SeeTechnologies Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate var beastForDetails: MyBeast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let segueIdentifier = segue.identifier, let viewController = segue.destination as? MyBeastsCollectionViewController
        {
            viewController.delegate = self
            
            switch segueIdentifier
            {
            case "EmbedMyBeasts":
                viewController.collectionStyle = .MyBeasts
            case "EmbedBeastFinder":
                viewController.collectionStyle = .BeastFinder
            default:
                print("Unknown segue in ViewController")
            }
        }
        else if let segueIdentifier = segue.identifier, let viewController = segue.destination as? BeastDetailsViewController
        {
            if let beastForDetails = beastForDetails, segueIdentifier == "ShowBeastDetails"
            {
                viewController.beast = beastForDetails
            }
        }
    }

}

extension ViewController: MyBeastsCollectionViewControllerDelegate
{
    func showDetails(beast: MyBeast) {
        self.beastForDetails = beast
        performSegue(withIdentifier: "ShowBeastDetails", sender: self)
    }
    
    
}

