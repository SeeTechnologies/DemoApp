//
//  ImageManager.swift
//  MagnificentBeasts
//
//  Created by LS on 2018-05-03.
//  Copyright © 2018 SeeTechnologies Inc. All rights reserved.
//

import Foundation
import UIKit

class ImageManager
{
    static func keyImage(imagePrefix: String, imageExtension: String)->UIImage?
    {
        // search image dir for all named...
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        
        do {
            let imagePaths = try fileManager.contentsOfDirectory(atPath: documentsPath)
            
            for imagePath in imagePaths {
                if imagePath.contains(imagePrefix) && imagePath.contains(".\(imageExtension)")
                {
                    let image = UIImage(contentsOfFile: "\(documentsPath)/\(imagePath)")
                    return image
                }
            }
        } catch let error as Error {
            print("Unable to load beast image due to error - \(error.localizedDescription)")
        }
        
        return nil
    }
}
