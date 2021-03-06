//
//  PokemonViewController.swift
//  XcaretTest
//
//  Created by Jonathan Pabel Saldivar Mendoza on 03/05/21.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weighttLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    
    var activityIndicator: NVActivityIndicatorView!
    var pokemon: PokemonModel?
    var dataSource: PokemonDetailResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchDetail()
    }
    
    func configureView() {
        if let pokemon = pokemon {
            titleLabel.text = pokemon.name
            titleImageView.image = UIImage(named: pokemon.imageName)
        }
        
        if let dataSource = dataSource {
            idLabel.text = "pokemon id: \(dataSource.id)"
            heightLabel.text = "Alto: \(dataSource.height)"
            weighttLabel.text = "Peso: \(dataSource.weight)"
        } else {
            idLabel.text = "Cargando..."
            heightLabel.text = ""
            weighttLabel.text = ""
        }
        
        activityIndicator = NVActivityIndicatorView(frame: (self.view.frame), type: .ballRotateChase, color: .white, padding: 80.0)
        activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.view.addSubview(activityIndicator)
    }
    
    func fetchDetail() {
        guard let requestURL = pokemon?.url else {return}
        activityIndicator.startAnimating()
        AF.request(requestURL, method: .get, headers: nil)
            .validate()
            .responseDecodable(of:PokemonDetailResponseModel.self) { (response) in
                self.activityIndicator.stopAnimating()
                switch response.result {
                case .success(let pokemonDetail):
                    self.dataSource = pokemonDetail
                    self.configureView()
                case .failure(let error):
                    self.show(error)
                }
            }
    }
    
    func show(_ error: Error) {
        let title = "Ooh oh! "
        let message = error.localizedDescription
        let settingsActionTitle = "Entendido"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let goToSettings = UIAlertAction(title: settingsActionTitle, style: .default) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(goToSettings)
        self.present(alert, animated: true)
    }
}
