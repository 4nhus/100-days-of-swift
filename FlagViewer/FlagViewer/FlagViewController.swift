//
//  FlagViewController.swift
//  FlagViewer
//
//  Created by Anh on 6/26/24.
//

import UIKit

class FlagViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var country: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flag of: \(country!.uppercased())"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let country {
            imageView.image = UIImage(named: country)
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No flag found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, country!.uppercased()], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
