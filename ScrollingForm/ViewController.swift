//
//  ViewController.swift
//  ScrollingForm
//
//  Created by Matthias Ludwig on 16/5/20.
//  Copyright © 2020 Quobject. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 3
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        do{
            try FileManager.default.copyfileToUserDocumentDirectory(forResource: "smiley", ofType: ".png")
            
            var fullPathString = ""
            if let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                .userDomainMask,
                                                                true).first {
                let fileName = "smiley.png"
                let fullDestPath = URL(fileURLWithPath: docDir).appendingPathComponent(fileName)
                fullPathString = fullDestPath.path
            }
            
            mainStackView.addArrangedSubview(UIImageView(image: UIImage(contentsOfFile: fullPathString)))
            mainStackView.addArrangedSubview(UIImageView(image: UIImage(contentsOfFile: fullPathString)))
           
        } catch {
            print("error \(error)")
        }
        
    }
    
}

extension FileManager {
    func copyfileToUserDocumentDirectory(forResource name: String,
                                         ofType ext: String) throws
    {
        if let bundlePath = Bundle.main.path(forResource: name, ofType: ext),
            let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                               .userDomainMask,
                                                               true).first {
            let fileName = "\(name)\(ext)"
            let fullDestPath = URL(fileURLWithPath: destPath)
                .appendingPathComponent(fileName)
            let fullDestPathString = fullDestPath.path
            
            if !self.fileExists(atPath: fullDestPathString) {
                try self.copyItem(atPath: bundlePath, toPath: fullDestPathString)
            }
        }
    }
}
