//
//  ViewController.swift
//  Air
//
//  Created by Marcin Szabłowski on 19.01.2018.
//  Copyright © 2018 Marcin Szabłowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainDescription: UILabel!
    @IBOutlet weak var carbonMonoxide: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updatePollutionData()
    }

    func updatePollutionData() {
        carbonMonoxide.text = "222"
        mainDescription.textColor = UIColor.green
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
}

