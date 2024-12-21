//
//  FilmesTableViewController.swift
//  ProjetoFilmes
//
//  Created by Ednaldo Franco on 18/12/24.
//

import UIKit
import CoreData

class FilmesTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var filmes: [Filmes] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchMoviesData()
        createMovies()
        
    }
    
    private func configureTableView() {
        tableView.rowHeight = 100
    }
    
    func fetchMoviesData() {
        do {
            filmes = try context.fetch(Filmes.fetchRequest())
            tableView.reloadData()
        } catch {
            AlertHelper.showAlert(title: "Erro", message: "Erro ao buscar filmes", on: self)
        }
    }
    
    func createMovies() {
        let filme = Filmes(context: context)
        filme.titulo = "Filme de teste 1"
        filme.ano = 2021
        
        let filme2 = Filmes(context: context)
        filme2.titulo = "Filme de teste 2"
        filme2.ano = 2022
        
        
        do {
            try context.save()
        } catch {
            AlertHelper.showAlert(title: "Erro", message: "Erro ao buscar filmes", on: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmesTableViewCell", for: indexPath) as! FilmesTableViewCell
        
        let filme = filmes[indexPath.row]
        
        cell.titleLabel.text = filme.titulo ?? "Titulo não informado"
        cell.genderLabel.text = filme.genero ?? "Titulo não informado"
        cell.dicrectorLabel.text = filme.diretor ?? "Titulo não informado"

        if let capaData = filme.capa, let capaImage = UIImage(named: capaData) {
            cell.movieImageView.image = capaImage
        } else {
            cell.movieImageView.image = UIImage(named: "movie")
        }
        
        return cell
    }
    
}
