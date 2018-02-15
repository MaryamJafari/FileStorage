//
//  ViewController.swift
//  FileStorage
//
//  Created by Maryam Jafari on 9/13/17.
//  Copyright © 2017 Maryam Jafari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Desc: UITextField!
    @IBOutlet weak var AuthorName: UITextField!
    @IBOutlet weak var iOSBookName: UITextField!
    var fullPath : URL!
    var path : URL!
    var  savedText : String!
    @IBAction func SaveFile(_ sender: Any) {
        
        let file = "file.txt"
        let text = createTextFromUIInputs()
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            path = dir.appendingPathComponent(file)
            print("\(path!)")
            
            
            do {
                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                
            }
            catch let error as NSError {
                print("ERROR : writing to file \(path) : \(error.localizedDescription)")
            }
            
        }
    }
    
    @IBAction func EditFile(_ sender: Any) {
        
        
        
        let file: FileHandle? = FileHandle(forReadingAtPath: String(describing: path))
        
        if file == nil {
            print("File open failed")
            
        } else {
            let text = createTextFromUIInputs()
            let data = (text as
                NSString).data(using: String.Encoding.utf8.rawValue)
            
            
            file?.seek(toFileOffset: 10)
            _ = file?.readData(ofLength: 5)
            file?.write(data!)
            file?.closeFile()
        }
    }
    @IBAction func SaveArchive(_ sender: Any) {
        
        let text = createTextFromUIInputs()
        let file = UUID().uuidString
        let data = NSKeyedArchiver.archivedData(withRootObject: text)
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            fullPath = dir.appendingPathComponent(file)
            print (fullPath)
            do {
                try data.write(to: fullPath)
            } catch {
                print("Couldn't write file")
            }
            
        }
    }
    
    @IBAction func UnArchive(_ sender: Any) {
        if let loadedStrings = NSKeyedUnarchiver.unarchiveObject(withFile: fullPath.path) as? String {
            savedText = loadedStrings
            
            performSegue(withIdentifier: "ShowUnArchivedData", sender: savedText)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowUnArchivedData"{
            if let destination = segue.destination as? UnArchivedData{
                if let unArchivedText = savedText {
                    destination.unArchivedData = unArchivedText
                    
                }
            }
        }
    }
    func createTextFromUIInputs()-> String{
        
        var text : String = ""
        var authorName : String = ""
        var bookName: String = ""
        var desc : String = ""
        
        if let author = AuthorName.text{
            authorName = author
        }
        if let name = iOSBookName.text{
            bookName = name
        }
        if let comment = Desc.text{
            desc = comment
        }
        
        text = "iOS Book Name is : \(bookName)\nAuthor Name is : \(authorName)\nDescription is : \(desc)"
        return text
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
}

