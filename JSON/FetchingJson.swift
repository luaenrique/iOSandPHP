//
//  TasksViewController.swift
//  ToDoAppPHP
//
//  Created by Luã Enrique on 04/04/2018.
//  Copyright © 2018 lzstudios. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController{

    @IBOutlet weak var testLabel: UILabel!
    let URL_JSON = "http://luaenrique.com.br/ZDTasks/php/mobile/teste.json";
    
    //A string array to save all the names
    var jsonArray = [String]()
    
    func sendRequest(){
        let url = NSURL(string: URL_JSON)

        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
        if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {

              //printing the json in console
              print(jsonObj!.value(forKey: "tests")!)

              if let testArray = jsonObj!.value(forKey: "tests") as? NSArray {

                  for names in testArray{

                      //converting the element to a dictionary
                      if let testDict = test as? NSDictionary {

                          if let name = heroeDict.value(forKey: "name") {

                              self.jsonArray.append((name as? String)!)
                          }

                      }
                  }
              }

              OperationQueue.main.addOperation({
                  self.showNames()
              })
          }
      }).resume()
    }
    
    func showNames(){
        for name in jsonArray{
            testLabel.text = testLabel.text! + name + "\n";
        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        sendRequest()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
