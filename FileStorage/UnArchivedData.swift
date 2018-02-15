//
//  UnArchivedData.swift
//  FileStorage
//
//  Created by Maryam Jafari on 9/13/17.
//  Copyright © 2017 Maryam Jafari. All rights reserved.
//

import UIKit

class UnArchivedData: UIViewController {
    var unArchivedData : String!
    @IBOutlet weak var lable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lable.text = unArchivedData
        
    }
    
    
}
