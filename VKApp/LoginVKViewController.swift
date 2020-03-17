//
//  LoginVKViewController.swift
//  VKApp
//
//  Created by Сергей Зесли on 23.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit
import WebKit
import FirebaseDatabase

class LoginVKViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    private let ref = Database.database().reference(withPath: "users")
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.setHidesBackButton(true, animated: false)

                    navigationController?.viewControllers.removeAll(where: { (vc) -> Bool in
                        return !vc.isKind(of: LoginVKViewController.self)})

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.navigationDelegate = self
        webview.cleanAllCookies()
        
        
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
          URLQueryItem(name: "client_id", value: "7331879"),
          URLQueryItem(name: "display", value: "mobile"),
          URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
          URLQueryItem(name: "scope", value: "262150"),
          URLQueryItem(name: "response_type", value: "token"),
          URLQueryItem(name: "v", value: "5.103")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        webview.load(request)

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

extension LoginVKViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }

        
        let params1 = fragment.components(separatedBy: "&")
        let params2 = params1.map { $0.components(separatedBy: "=") }
        let params = params2.reduce([String : String]()) { result, param  in
            var dict = result
            
            if param.count == 2 {
                let key = param[0]
                let value = param[1]
                dict[key] = value
            }
            
            return dict
        }
        if let token = params["access_token"], let userids = params["user_id"], let userid = Int(userids)  {
            print("token = \(token)")
            print("user_id = \(userid)")

            Session.instance.token = token
            Session.instance.userId = userid
            
            let user = UserFire(id: userid)
            let userRef = ref.child("\(user.id)")
            userRef.setValue(user.toAnyObject())
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.userId = userid
            
            
            
            performSegue(withIdentifier: "loginVkOkSegue", sender: nil)
            //                   navigationController?.viewControllers.removeAll()
            
//            let vc = storyboard?.instantiateViewController(identifier: "MainTabBarController") as! MainTabBarController
            
 //           navigationController?.pushViewController(vc, animated: true)


        }
        
        decisionHandler(.cancel)
    }
}

extension WKWebView {

    func cleanAllCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        print("All cookies deleted")

        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                print("Cookie ::: \(record) deleted")
            }
        }
    }

    func refreshCookies() {
        self.configuration.processPool = WKProcessPool()
    }
}
