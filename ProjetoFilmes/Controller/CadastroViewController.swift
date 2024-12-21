//
//  CadastroViewController.swift
//  ProjetoFilmes
//
//  Created by Ednaldo Franco on 21/12/24.
//

import UIKit
import CoreData

class CadastroViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var filmeEdit: Filmes?
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var durationTextField: UITextField!
    
    @IBOutlet weak var yearTextField: UITextField!
    
    @IBOutlet weak var originTextField: UITextField!
    
    @IBOutlet weak var directorTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEditar()
    }
    
    
    @IBAction func galeryButton(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[.originalImage] as? UIImage {
            movieImageView.image = imageSelected
        }
        picker.dismiss(animated: true , completion: nil)
    }
    
    
    @IBAction func cameraButton(_ sender: UIButton) {
    }
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        if let filme = self.filmeEdit {
            self.editMovie(filme)
        } else {
            self.createMovie()
        }
    }
    
    private func editMovie(_ filme: Filmes) {
        let newMovie = Filmes(context: context)
        buildMovie(newMovie)
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            AlertHelper.showAlert(title: "Erro", message: "Erro ao Criar Filme", on: self)
        }
    }
    
    private func createMovie() {
        let newMovie = Filmes(context: context)
        buildMovie(newMovie)
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            AlertHelper.showAlert(title: "Erro", message: "Erro ao Criar Filme", on: self)
        }
    }
    
    private func buildMovie(_ filme: Filmes) {
        filme.titulo = self.titleTextField.text
        filme.diretor = self.directorTextField.text
        filme.genero = self.genderTextField.text
        filme.origiem = self.originTextField.text
        
        if let duration = Int32(durationTextField.text ?? "") {
            filme.duracao = duration
        }
        
        if let year = Int32(yearTextField.text ?? "") {
            filme.ano = year
        }
        
        filme.capa = movieImageView.image?.cgImage
        
        print(<#T##items: Any...##Any#>)
    }
    
    private func setupEditar() {
        if let filme = self.filmeEdit {
            self.movieImageView.image = UIImage(named: filme.capa ?? "movie")
            self.titleTextField.text = filme.titulo
            self.directorTextField.text = filme.diretor
            self.genderTextField.text = filme.genero
            self.originTextField.text = filme.origiem
            self.durationTextField.text = String(filme.duracao)
            self.yearTextField.text = String(filme.ano)
        }
    }
}


    
