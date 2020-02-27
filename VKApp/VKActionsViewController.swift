//
//  VKActionsViewController.swift
//  VKApp
//
//  Created by Сергей Зесли on 23.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit
import Alamofire

class VKActionsViewController: UIViewController {
    
    @IBOutlet weak var searchString: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
            navigationController?.viewControllers.removeAll(where: { (vc) -> Bool in
            return !vc.isKind(of: VKActionsViewController.self)
        })

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
     }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func getFriends(_ sender: Any) {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [
           URLQueryItem(name: "v", value: "5.103"),
           URLQueryItem(name: "access_token", value: Session.instance.token),
           URLQueryItem(name: "fields", value: "city,domain,sex,nickname,country")
        ]
        
        URLSession.shared.dataTask(with: urlConstructor.url!) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let friends = try JSONDecoder().decode(RootFriends.self, from: data)
                print(friends)
            } catch {
                print(error)
            }
            
            //print("JSON = \(json)")
        }.resume()
        
        print("URL= \(urlConstructor.url!)")
        
        
//        let request = AF.request(urlConstructor.url!)
//        request.responseJSON { (data) in
//            print(data)
//        }
    }
    
    @IBAction func getPhotoes(_ sender: Any) {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/photos.getAll"
        urlConstructor.queryItems = [
           URLQueryItem(name: "v", value: "5.103"),
           URLQueryItem(name: "access_token", value: Session.instance.token),
           URLQueryItem(name: "extended", value: "1")
        ]
        
        print("URL= \(urlConstructor.url!)")
//        let request = AF.request(urlConstructor.url!)
//        request.responseJSON { (data) in
//            print(data)
//        }

    }
    @IBAction func getGroups(_ sender: Any) {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
           URLQueryItem(name: "v", value: "5.103"),
           URLQueryItem(name: "access_token", value: Session.instance.token),
           URLQueryItem(name: "fields", value: "city,country,place,description"),
           URLQueryItem(name: "extended", value: "1")
        ]
        
        URLSession.shared.dataTask(with: urlConstructor.url!) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let groups = try JSONDecoder().decode(RootGroups.self, from: data)
                //print(groups)
            } catch {
                print(error)
            }
            
            //print("JSON = \(json)")
        }.resume()
        
//        print("URL= \(urlConstructor.url!)")
//
//
//        let request = AF.request(urlConstructor.url!)
//        request.responseJSON { (data) in
//            print(data)
//        }
    }
    
    @IBAction func searchGroups(_ sender: Any) {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.search"
        urlConstructor.queryItems = [
           URLQueryItem(name: "v", value: "5.103"),
           URLQueryItem(name: "access_token", value: Session.instance.token),
           URLQueryItem(name: "q", value: searchString.text ?? "")
        ]
        let request = AF.request(urlConstructor.url!)
        request.responseJSON { (data) in
            print(data)
        }

    }
    
    @IBAction func logOut(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "LoginVKViewController") as! LoginVKViewController
        
        navigationController?.pushViewController(vc, animated: true)

    }
}
