//
//  ViewController.swift
//  ICE-07-FacialRecognitionApp
//
//  Created by Raj Kumar Shahu on 2021-04-03.
//

import UIKit
import Vision
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var pictureChosen: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getImage(_ sender: Any) {
        getPhoto()
    }
    
    func getPhoto() {
     let picker = UIImagePickerController()
     picker.delegate = self
     picker.sourceType = .savedPhotosAlbum
     present(picker, animated: true, completion: nil)
     }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        pictureChosen.image = image
        
        analyzeImage(image: pictureChosen.image!)
    }
    
    func analyzeImage(image: UIImage)
    {
     let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [ : ])
     messageLabel.text = "Analyzing picture..."
     let request =
     VNDetectFaceRectanglesRequest(completionHandler: handleFaceRecognition)
     try! handler.perform([request])
    }
    
    func handleFaceRecognition(request: VNRequest, error: Error?) {
        guard let foundFaces = request.results as? [VNFaceObservation] else {
            fatalError ("Can't find a face in the picture")
        }
        messageLabel.text = "Found \(foundFaces.count) faces in the picture"
    }
}

