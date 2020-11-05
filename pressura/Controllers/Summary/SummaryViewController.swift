//
//  SummaryViewController.swift
//  pressura
//
//  Created by Sergio Diosdado on 18/10/20.
//

import UIKit
import GoogleSignIn

let exampleData : [[String]] = [
    ["102", "93", "80"],
    ["118", "70", "90"],
    ["110", "89", "85"],
]

class SummaryViewController: UIViewController {
    
    @IBOutlet weak var lblLastMeassures: UILabel!
    @IBOutlet weak var viewCollectionCards: UIView!
    var collectionPressureCards: UICollectionView?
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 19
        layout.minimumLineSpacing = 19
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PressureCardUIView.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let user = GIDSignIn.sharedInstance()?.currentUser {
            navigationItem.title = "¡Hola \(user.profile.givenName!)!"
        } else {
            navigationItem.title = "¡Hola!"
        }
        
        viewCollectionCards.addSubview(collectionView)
        collectionView.backgroundColor = .white
        
        collectionView.topAnchor.constraint(equalTo: viewCollectionCards.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: viewCollectionCards.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: viewCollectionCards.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: viewCollectionCards.bottomAnchor).isActive = true

        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension UIViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(collectionView.frame.height)
        return CGSize(width: 164, height: 164)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PressureCardUIView
        cell.configureCard(pSistolica: exampleData[indexPath.row][0], pDiastolica: exampleData[indexPath.row][1], pulso: exampleData[indexPath.row][2])
        return cell
    }
    
    
}
