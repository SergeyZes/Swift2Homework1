//
//  MainTabBarController.swift
//  VKApp
//
//  Created by Сергей Зесли on 27.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.setHidesBackButton(true, animated: false)
                navigationController?.viewControllers.removeAll(where: { (vc) -> Bool in
            return !vc.isKind(of: MainTabBarController.self)

        })

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
