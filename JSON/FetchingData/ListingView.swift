//
//  TasksViewController.swift
//  ToDoAppPHP
//
//  Created by Luã Enrique Zangradne on 04/04/2018.
//  Copyright © 2018 lzstudios. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    //setting up the tables
    @IBOutlet weak var tableCompletedTasks: UITableView!
    @IBOutlet weak var tableCanceledTasks: UITableView!
    @IBOutlet weak var tableOverdueTasks: UITableView!
    @IBOutlet weak var tableToDo: UITableView!
    
    //setting up the URL from where our json will come from
    let URL_HEROES = "http://yoururl.com.br/listTasks.php";
    

    //creating my lists based on the Tasks.swift file 
    var toDoTasks = [Tasks]()
    var canceledTasks = [Tasks]()
    var overdueTasks  = [Tasks]()
    var completedTasks = [Tasks]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int?
        
        //working with multiple tables
        if tableView == self.tableToDo{
            count = toDoTasks.count
        }
        
        if tableView == self.tableCompletedTasks{
            count = completedTasks.count
        }
        
        if tableView == self.tableCanceledTasks{
            count = canceledTasks.count
        }
        
        if tableView == self.tableOverdueTasks{
            count = overdueTasks.count
        }
        //returning the number of rows
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        //checking which table will be updated
        
        if tableView == self.tableToDo {
            let tasks:Tasks
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            tasks = toDoTasks[indexPath.row]
            cell!.textLabel!.text = tasks.Title
            cell!.tag = tasks.Id!
        }
        
        if tableView == self.tableOverdueTasks {
            let tasks:Tasks
            cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            tasks = overdueTasks[indexPath.row]
            cell!.textLabel!.text = tasks.Title
            cell!.tag = tasks.Id!
        }
        
        if tableView == self.tableCanceledTasks {
            let tasks:Tasks
            cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
            tasks = canceledTasks[indexPath.row]
            cell!.textLabel!.text = tasks.Title
            cell!.tag = tasks.Id!
        }
        
        if tableView == self.tableCompletedTasks {
            let tasks:Tasks
            cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath)
            tasks = completedTasks[indexPath.row]
            cell!.textLabel!.text = tasks.Title
            cell!.tag = tasks.Id!
        }
        //returning the cell
        return cell!
    }
    
    func sendRequest(){
        let url = NSURL(string: URL_HEROES)
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                print(jsonObj!.value(forKey: "tasks")!)
                
                //getting the tasks array from json and converting it to NSArray
                if let tasksArray = jsonObj!.value(forKey: "tasks") as? NSArray {
                    //looping through all the tasks
                    for task in tasksArray{
                        
                        //converting the element to a dictionary
                        if let tasksDict = task as? NSDictionary {
                            
                            
                            //getting the data from the dictionary
                            
                            let id = (tasksDict.value(forKey: "id") as! NSString?)?.intValue
                            let title = (tasksDict.value(forKey: "title") as! NSString)
                            let category = (tasksDict.value(forKey: "category") as! NSString)
                            let deadline = (tasksDict.value(forKey: "deadline") as! NSString)
                            let situation = (tasksDict.value(forKey: "situation") as! NSString)
         
                            if situation == "0"{
                                //todo
                                self.toDoTasks.append(Tasks(id: Int(id as! Int32), title: title as String, category: category as String , deadline: deadline as String ))
                            }
                            if situation == "1"{
                                //completed
                                self.completedTasks.append(Tasks(id: Int(id as! Int32), title: title as String, category: category as String , deadline: deadline as String ))
                            }
                            if situation == "2"{
                                //overdue
                                self.overdueTasks.append(Tasks(id: Int(id as! Int32), title: title as String, category: category as String , deadline: deadline as String ))
                            }
                            if situation == "3"{
                                //canceled
                                self.canceledTasks.append(Tasks(id: Int(id as! Int32), title: title as String, category: category as String , deadline: deadline as String ))
                            }
                            
                            
                            
                            // printing the number of elements in each list in the console
                            print(self.toDoTasks.count)
                            print(self.completedTasks.count)
                            print(self.overdueTasks.count)
                            print(self.canceledTasks.count)
                            
                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    //reloading all the tables
                    self.tableToDo.reloadData()
                    self.tableOverdueTasks.reloadData()
                    self.tableCompletedTasks.reloadData()
                    self.tableCanceledTasks.reloadData()
                })
            }
        }).resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up the cells, dataSources and delegates
        
        tableToDo.dataSource = self
        tableToDo.delegate = self
        tableToDo.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableOverdueTasks.dataSource = self
        tableOverdueTasks.delegate = self
        tableOverdueTasks.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        
        tableCanceledTasks.dataSource = self
        tableCanceledTasks.delegate = self
        tableCanceledTasks.register(UITableViewCell.self, forCellReuseIdentifier: "cell3")
        
        tableCompletedTasks.dataSource = self
        tableCompletedTasks.delegate = self
        tableCompletedTasks.register(UITableViewCell.self, forCellReuseIdentifier: "cell4")
        
        //calling the method
        sendRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
