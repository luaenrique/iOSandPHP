import UIKit

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var nomeText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var nickText: UITextField!
    @IBOutlet weak var senhaText: UITextField!
    @IBOutlet weak var confSenhaText: UITextField!
    @IBOutlet weak var dataNascimento: UIDatePicker!
    
    
    @IBAction func ActionChooseImage(sender:UIButton){
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func registerUser(_ sender: Any) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://yoururl.com/insertUser.php")! as URL)
        request.httpMethod = "POST"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let strDate = dateFormatter.string(from: NSDate() as Date)
        print(strDate)
        let postString = "name=\(nomeText.text!)&email=\(emailText.text!)&nick=\(nickText.text!)&pass=\(senhaText.text!)&dateb=\(strDate)"
       
        let param = [
            "name"  : nomeText.text!,
            "bDate"    : strDate,
            "nick"    : nickText.text!,
            "email" : emailText.text!,
            "pass" : senhaText.text!
        ]
        
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(myImage.image!, 1)
        
        if(imageData==nil)  { return; }
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        
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
        
        
        let alertController = UIAlertController(title: "Cadastro de usuário", message:
            "Adicionado com sucesso", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectImage(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        myImage.image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    

    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = UUID().uuidString+".jpg"
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
}


extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
