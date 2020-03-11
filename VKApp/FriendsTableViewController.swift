//
//  FriendsTableViewController.swift
//  VKApp
//
//  Created by Сергей Зесли on 20.01.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController {
    var friendsDictionary = [String: [RealmUser]]()
    var friendsSectionTitles = [String]()
    var filteredFriends = [RealmUser]()
    
    var rootFriends: RootFriends?
    var allFriends  = [RealmUser]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func readFriendsFromDB() {
        allFriends = []
        guard let realm = try? Realm() else {
            return
        }
        
        let friends = realm.objects(RealmUser.self).sorted(byKeyPath: "firstName")
        
        allFriends = friends.map({ (realmUser) -> RealmUser in
             return realmUser
        })
        
        friendsDictionary = [:]
        friendsSectionTitles = []

        for friend in self.allFriends {
            let key = String((friend.firstName ?? "anonymous").prefix(1))
            
             
            if var friendValues = self.friendsDictionary[key] {
                friendValues.append(friend)
                self.friendsDictionary[key] = friendValues
            } else {
                self.friendsDictionary[key] = [friend]
            }
          }
        
         friendsSectionTitles = [String] (self.friendsDictionary.keys)
         friendsSectionTitles = self.friendsSectionTitles.sorted(by: { $0 < $1 })
         tableView.reloadData()

        
    }
    
    func getFriends() {
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
                
                DispatchQueue.main.async {
                 
                  do {
                    self.rootFriends = try JSONDecoder().decode(RootFriends.self, from: data)
                    
                    
                    
                  } catch {
                   return
                  }
                    
                
                
                  guard let allf = self.rootFriends?.response?.items else {
                    return
                  }
                  //self.allFriends = allf
                    
                    
                    do {
                        let realm = try Realm()
                    
                        try realm.write {
                            realm.delete(realm.objects(RealmUser.self))
                            for fr in allf {
                                let ru = RealmUser()
                                ru.id = fr.id ?? 0
                                ru.domain = fr.domain
                                ru.firstName = fr.firstName
                                ru.lastName = fr.lastName
                                ru.nickname = fr.nickname
                                ru.sex = fr.sex ?? 1
                                if let cit = fr.city {
                                    let city = RealmCity()
                                    city.id = cit.id ?? 0
                                    city.title = cit.title
                                    ru.city = city
                                }
                                realm.add(ru)
                                
                            }
                        }
                        print("Друзья сохранены в Realm")
                        print(realm.configuration.fileURL)

                    } catch {
                        print(error)
                    }
                
                    self.readFriendsFromDB()
                }
                
                
            }.resume()
            
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 74
        tableView.tableFooterView = UIView()
        
        friendsDictionary = [:]
        friendsSectionTitles = []
        
    }

    // MARK: - Table view data source


    override func viewWillAppear(_ animated: Bool) {
        getFriends()
    }
    
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if let s = searchBar.text, s != "" {
            return 1
        }
        
        
        return friendsSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let s = searchBar.text, s != "" {
            return filteredFriends.count
        }

        
        let key = friendsSectionTitles[section]
        
        if let friendValues = friendsDictionary[key] {
            return friendValues.count
        }
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendTableCell", for: indexPath) as! FriendTableViewCell
        
        if let s = searchBar.text, s != "" {
            cell.friendLabel.text = filteredFriends[indexPath.row].firstName ?? "anonymous"
            cell.avatarImage.img = #imageLiteral(resourceName: "groups")
            cell.animate()
            return cell
        }

        
        let key = friendsSectionTitles[indexPath.section]
  
        if let friendValues = friendsDictionary[key] {
            cell.friendLabel.text = friendValues[indexPath.row].firstName ?? "anonymous"
            cell.avatarImage.img = #imageLiteral(resourceName: "groups")
            cell.animate()
        }

        
        

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let s = searchBar.text, s != "" {
             return nil
        }

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendTableHeader") as! FriendTableViewHeader
        
        cell.sectionHeader.text = friendsSectionTitles[section]
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if let s = searchBar.text, s != "" {
            return nil
        }

        return friendsSectionTitles
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "friendPropertiesSegue" {
            
            guard let section = tableView.indexPathForSelectedRow?.section, let row = tableView.indexPathForSelectedRow?.row else { return }
            
            if let s = searchBar.text, s != "" {
               (segue.destination as! FriendCollectionViewController).friend = filteredFriends[row]
                return
            }

            
            
            
            
            let key = friendsSectionTitles[section]
            
            if let friendValues = friendsDictionary[key] {
                (segue.destination as! FriendCollectionViewController).friend = friendValues[row]
            }

        }
    }
    

}

extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let s = searchBar.text, s != "" {
            tableView.sectionHeaderHeight = 0
        } else {
            tableView.sectionHeaderHeight = 40
        }
        
        filteredFriends = []
        if searchText != "" {
            filteredFriends = allFriends.filter({ (user) -> Bool in
                return (user.firstName ?? "anonymous").lowercased().hasPrefix(searchText.lowercased())
            })
        }

        tableView.reloadData()
    }
}

