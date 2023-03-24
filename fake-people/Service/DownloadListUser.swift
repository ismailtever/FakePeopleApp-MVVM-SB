//
//  DownloadListUser.swift
//  fake-people
//
//  Created by Ismail Tever on 21.03.2023.
//

import Foundation
import Alamofire


class Webservice {
    
    var user = [User]()
    var tableView = ViewController().tableView
    
    func urlSessionIndirme(url: URL, completion: @escaping ([User]?)-> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                completion(nil)
            }else if let data = data{
                let userDizi = try? JSONDecoder().decode([User].self, from: data)
                if let userDizi = userDizi{
                    completion(userDizi)
                }
            }
        }.resume()
    }
    func loadJsonData() {
        AF
            .request("https://reqres.in/api/users?page=2")
            .response { response in
//                print("\(response)")
//                print("\(response.value)")
                    
                let json = try? JSONDecoder().decode(UserList.self, from: response.data!)
                self.user = json!.data
//                self.tableView.reloadData()
//                ViewController().tableView?.reloadData()
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
                
        }
    }

}
