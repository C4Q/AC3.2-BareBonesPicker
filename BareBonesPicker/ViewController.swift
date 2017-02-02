//
//  ViewController.swift
//  BareBonesPicker
//
//  Created by Jason Gresh on 2/2/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var movieURL: URL?
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pickImage(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.mediaTypes = [String(kUTTypeMovie), String(kUTTypeImage)]
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        switch info[UIImagePickerControllerMediaType] as! String {
        case String(kUTTypeImage):
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.imageView.image = image
            }
        case String(kUTTypeMovie):
            if let url = info[UIImagePickerControllerReferenceURL] as? URL {
                self.movieURL = url
            }
        default:
            print("bad media")
        }
        
        // dismissing imagePickerController
        dismiss(animated: true) {
            if let url = self.movieURL {
                let player = AVPlayer(url: url)
                let playerController = AVPlayerViewController()
                playerController.player = player
                self.present(playerController, animated: true, completion: {
                    self.movieURL = nil
                })
            }
        }
    }
}

