//
//  FriendsTableViewController.swift
//  VKApp
//
//  Created by Сергей Зесли on 20.01.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    var friendsDictionary = [String: [User]]()
    var friendsSectionTitles = [String]()
    var filteredFriends = [User]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 74
        tableView.tableFooterView = UIView()
        
        friendsDictionary = [:]
        friendsSectionTitles = []
        
        for friend in VkDataBase.shared().friends {
            let key = String(friend.name.prefix(1))
            if var friendValues = friendsDictionary[key] {
                friendValues.append(friend)
                friendsDictionary[key] = friendValues
            } else {
                friendsDictionary[key] = [friend]
            }
        }
        
        friendsSectionTitles = [String] (friendsDictionary.keys)
        friendsSectionTitles = friendsSectionTitles.sorted(by: { $0 < $1 })
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source


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
            cell.friendLabel.text = filteredFriends[indexPath.row].name
            cell.avatarImage.img = filteredFriends[indexPath.row].image
            return cell
        }

        
        let key = friendsSectionTitles[indexPath.section]
  
        if let friendValues = friendsDictionary[key] {
            cell.friendLabel.text = friendValues[indexPath.row].name
            cell.avatarImage.img = friendValues[indexPath.row].image
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
            filteredFriends = VkDataBase.shared().friends.filter({ (user) -> Bool in
                return user.name.lowercased().hasPrefix(searchText.lowercased())
            })
        }

        tableView.reloadData()
    }
}

