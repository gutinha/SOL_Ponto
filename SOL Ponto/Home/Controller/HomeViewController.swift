//
//  swift
//  SOL Ponto
//
//  Created by Sósthenes Oliveira Lima on 02/10/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var horarioView: UIView!
    @IBOutlet weak var horarioLabel: UILabel!
    @IBOutlet weak var registrarButton: UIButton!
    
    // MARK: - Attributes
    
    private var timer: Timer?
    private lazy var camera = Camera()
    private lazy var controladorDeImagem = UIImagePickerController()
    
    var contexto: NSManagedObjectContext = {
        let contexto = UIApplication.shared.delegate as! AppDelegate
        
        return contexto.persistentContainer.viewContext
    }()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraView()
        atualizaHorario()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configuraTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    // MARK: - Class methods
    
    func configuraView() {
        configuraBotaoRegistrar()
        configuraHorarioView()
    }
    
    func configuraBotaoRegistrar() {
        registrarButton.layer.cornerRadius = 5
    }
    
    func configuraHorarioView() {
        horarioView.backgroundColor = .white
        horarioView.layer.borderWidth = 3
        horarioView.layer.borderColor = UIColor.systemGray.cgColor
        horarioView.layer.cornerRadius = horarioView.layer.frame.height/2
    }
    
    func configuraTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(atualizaHorario), userInfo: nil, repeats: true)
    }
    
    @objc func atualizaHorario() {
        let horarioAtual = FormatadorDeData().getHorario(Date())
        horarioLabel.text = horarioAtual
    }
    
    func tentaAbrirCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            camera.delegate =  self
            camera.abrirCamera(self, controladorDeImagem)
        }
    }
    // MARK: - IBActions
    
    @IBAction func registrarButton(_ sender: UIButton) {
        tentaAbrirCamera()
        
    }
    
    @IBAction func onClickSwitch(_ sender: UISwitch){
        if #available(iOS 13.0, *){
            let appDelegate = UIApplication.shared.windows.first
            
            if sender.isOn{
                appDelegate?.overrideUserInterfaceStyle = .dark
                return
            }
            
            appDelegate?.overrideUserInterfaceStyle = .light
        } else{
            print("No support")
        }
    }
}

extension HomeViewController: CameraDelegate {
    func didSelecFoto(_ image: UIImage) {
        let recibo = Recibo (status: false, data: Date(), foto: image)
        recibo.salvar(contexto)
    }
}
