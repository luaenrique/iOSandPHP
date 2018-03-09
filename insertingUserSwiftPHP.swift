//
//  insertingUserSwiftPHP.swift
//  insertingUserSwiftPHP
//
//  Created by Luã Enrique Zangrande on 09/03/2018.
//  Copyright © 2018 lzstudios. All rights reserved.
//

import UIKit

class insertingUserSwiftPHP: UIViewController{
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var nickText: UITextField!
    @IBOutlet weak var senhaText: UITextField!
    @IBOutlet weak var confSenhaText: UITextField!
    @IBOutlet weak var dataNascimento: UIDatePicker!
    
    @IBAction func registerUser(_ sender: Any) {
        let request = NSMutableURLRequest(url: NSURL(string: "www.yoursite.com/insertUser.php")! as URL) // setting up the url 
        request.httpMethod = "POST" //defining the http method
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd" // formatting the date
        let strDate = dateFormatter.string(from: NSDate() as Date)

        let postString = "name=\(nameText.text!)&email=\(emailText.text!)&nick=\(nickText.text!)&pass=\(senhaText.text!)&dateb=\(strDate)" //setting up the request string
        
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
        }
        task.resume()
        
        
        let alertController = UIAlertController(title: "User register", message:
            "Added successfully", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil) //showing an alert controller 
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
