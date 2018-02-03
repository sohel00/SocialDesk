//
//  Groups.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 25/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import Foundation

class Group {
    var _groupTitle: String
    var _groupDesc: String
    var _groupKey: String
    var _membersCount: Int
    var _members: [String]
    
    var groupTitle: String{
        return _groupTitle
    }
    
    var groupDesc: String{
        return _groupDesc
    }
    
    var groupKey:String{
        return _groupKey
    }
    
    var memberCount: Int{
        return _membersCount
    }
    
    var members: [String] {
        return _members
    }
    
    init(title: String, desc: String, key: String, memberCount: Int, members: [String]) {
        self._groupTitle = title
        self._groupDesc = desc
        self._groupKey = key
        self._membersCount = memberCount
        self._members = members
    }
}
