//
//  BeastDetailsViewController.swift
//  MagnificentBeasts
//
//  Created by LS on 2018-05-03.
//  Copyright © 2018 SeeTechnologies Inc. All rights reserved.
//

import UIKit

class BeastDetailsViewController: UIViewController {

    public var beast: MyBeast?
    @IBOutlet weak var profileTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if let beastProfile = beast?.profile
        {
            profileTextView.text = beastProfile
        }
        else
        {
            profileTextView.text = "Poor creature... nobody has wrote its profile!"
        }
        
        if let beast = beast
        {
            if beast.ownerId > Int64(0)
            {
                profileTextView.isEditable = true
            }
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
