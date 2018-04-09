//
//  Tasks.swift
//  ToDoAppPHP
//
//  Created by Luã Enrique Zangrande on 09/04/2018.
//  Copyright © 2018 lzstudios. All rights reserved.
//

import Foundation

class Tasks{
    var Id:Int?
    var Title:String?
    var Category:String?
    var Deadline:String?
    
    init(id: Int, title: String, category: String, deadline: String){
        self.Id = id
        self.Title = title
        self.Category = category
        self.Deadline = deadline
    }
}
