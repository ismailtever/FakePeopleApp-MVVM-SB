//
//  UserViewModel.swift
//  fake-people
//
//  Created by Ismail Tever on 21.03.2023.
//

import Foundation

struct UserTableViewModel {

    let userList : [User]

    func numberOfRowsInSection() -> Int {
        return self.userList.count
    }

    func userAtIndexPath(_ index: Int) -> UserViewModel {
        let user = self.userList[index]
        return UserViewModel(user: user)
    }
}


struct UserViewModel {
    let user : User 

    var email : String {
        return self.user.email
    }
    var first_name : String {
        return self.user.first_name
    }
    var last_name : String {
        return self.user.last_name
    }
    var avatar : String {
        return self.user.avatar
    }
}
