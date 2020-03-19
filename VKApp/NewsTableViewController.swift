//
//  NewsTableViewController.swift
//  VKApp
//
//  Created by Сергей Зесли on 03.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    var rootNews: RootNews?
    var news =  [ItemNews]()

    
    func getNewsfeed() {
            var urlConstructor = URLComponents()
            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
            urlConstructor.path = "/method/newsfeed.get"
            urlConstructor.queryItems = [
               URLQueryItem(name: "v", value: "5.58"),
               URLQueryItem(name: "access_token", value: Session.instance.token),
               URLQueryItem(name: "filters", value: "post")
            ]
            
            URLSession.shared.dataTask(with: urlConstructor.url!) { (data, response, error) in
                guard let data = data else {
                    
                    return
                }
                
                DispatchQueue.main.async {
                 
                  do {
                    self.rootNews = try JSONDecoder().decode(RootNews.self, from: data)
                    
                      
                  } catch {
                   return
                  }
                    
                    guard let itN = self.rootNews?.response?.items else {
                        return
                    }
                    
                    self.news = itN
                    self.tableView.reloadData()
                
                
                    
                    
                }
                
                
            }.resume()
            
        }
    
    override func viewWillAppear(_ animated: Bool) {
        getNewsfeed()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       // return VkDataBase.shared().allNews.count
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsTableCell", for: indexPath) as! NewsTableViewCell
        let news2 = news[indexPath.row]
        
        cell.avatarImage.img =  #imageLiteral(resourceName: "groups")//news.user.image
        cell.friendLabel.text = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let ti: TimeInterval = Double(news2.date ?? 0)
        
        cell.newDate.text = dateFormatter.string(from: Date(timeIntervalSince1970: ti))
        cell.newText.text = news2.text
        cell.newViews.text = "0"
        cell.newImage.image = #imageLiteral(resourceName: "friends")


        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
