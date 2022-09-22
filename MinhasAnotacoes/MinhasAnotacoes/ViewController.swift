//
//  ViewController.swift
//  MinhasAnotacoes
//
//  Created by Rodrigo Garcia on 21/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    var imputTextRecorder: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 0.5
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 15
        textField.placeholder = "Insert Your Note"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        return textField
    }()
    
    var buttonSave: UIButton = {
        let button = UIButton(frame: .zero)
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.setTitleColor(UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1), for: .normal)
        button.layer.borderWidth = 0.5
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(buttonPlay(_:)), for: .touchUpInside)
        return button
    }()
    
    var buttonDelete: UIButton = {
        let button = UIButton(frame: .zero)
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.setTitleColor(UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1), for: .normal)
        button.layer.borderWidth = 0.5
        button.setTitle("Delete", for: .normal)
        button.addTarget(self, action: #selector(buttonRemove(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addSubViews()
        makeConstraints()
        setupKeyboardHiding()
        imputTextRecorder.text = (UserDefaults.standard.object(forKey: "noteCreated") as? String)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func alertSaveNotes() {
        let alertController = UIAlertController(title: "Notepad App", message: "salvo com sucesso", preferredStyle: .alert)
        
        let alertSave = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(alertSave)
        self.present(alertController, animated: true)
    }
    
    func alertDeleteNotes() {
        let alertController = UIAlertController(title: "Notepad App", message: "Deletado com sucesso", preferredStyle: .alert)
        
        let alertRemove = UIAlertAction(title: "Ok", style: .destructive) { alertRemove in
            self.imputTextRecorder.text = ""
        }
        alertController.addAction(alertRemove)
        self.present(alertController, animated: true)
    }
    
    func makeConstraints(){
        
        NSLayoutConstraint.activate([
            imputTextRecorder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imputTextRecorder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imputTextRecorder.widthAnchor.constraint(equalToConstant: 200),
            imputTextRecorder.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            buttonSave.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50),
            buttonSave.topAnchor.constraint(equalTo: imputTextRecorder.bottomAnchor, constant: 10),
            buttonSave.widthAnchor.constraint(equalToConstant: 100),
            buttonSave.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            buttonDelete.leadingAnchor.constraint(equalTo: buttonSave.trailingAnchor, constant: 10),
            buttonDelete.topAnchor.constraint(equalTo: imputTextRecorder.bottomAnchor, constant: 10),
            buttonDelete.widthAnchor.constraint(equalToConstant: 100),
            buttonDelete.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func addSubViews(){
        view.addSubview(imputTextRecorder)
        view.addSubview(buttonSave)
        view.addSubview(buttonDelete)
    }
    
    func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension ViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        view.frame.origin.y = view.frame.origin.y - 150
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    @objc func buttonPlay(_ sender: UIButton!) {
        
        if imputTextRecorder.text != ""{
            let saveDefault = UserDefaults.standard.setValue(imputTextRecorder.text ?? "", forKey: "noteCreated")
            alertSaveNotes()
        } else{
            print("inserir text")
        }
    }
    
    @objc func buttonRemove(_ sender: UIButton!) {
        let removeDefault = UserDefaults.standard.removeObject(forKey: "noteCreated")
        alertDeleteNotes()
    }
    
}
