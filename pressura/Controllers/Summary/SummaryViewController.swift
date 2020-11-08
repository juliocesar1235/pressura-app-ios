//
//  SummaryViewController.swift
//  pressura
//
//  Created by Sergio Diosdado on 18/10/20.
//

import UIKit


class SummaryViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var lblLastMeassures: UILabel!
    @IBOutlet weak var viewCollectionCards: UIView!
    var collectionPressureCards: UICollectionView?
    var bloodReadings: [BloodPressureReading] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        if bloodReadings.count == 0 {
            APIManager.shared.getBloodReadings{ (bloodReadings,message) in
                if let bReadings = bloodReadings {
                    self.bloodReadings = bReadings
                    self.collectionView.reloadData()
                }
            }
        }
        print("Will Appear")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "¡Hola!"
        
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
    
    @IBAction func moreReadings(_ sender: UIButton) {
        APIManager.shared.getBloodReadings{ (bloodReadings,message) in
            if let bReadings = bloodReadings {
                self.bloodReadings = bReadings
            }
        }
        collectionView.reloadData()
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 164, height: 164)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bloodReadings.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PressureCardUIView
        cell.configureCard(
            pSistolica: String(bloodReadings[indexPath.row].getSystolicReading()),
            pDiastolica: String(bloodReadings[indexPath.row].getDiastolicReading()),
            pulso: String(bloodReadings[indexPath.row].getPulse()))
        return cell
    }
    
}


//extension UIViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        print(collectionView.frame.height)
//        return CGSize(width: 164, height: 164)
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PressureCardUIView
//        cell.configureCard(pSistolica: exampleData[indexPath.row][0], pDiastolica: exampleData[indexPath.row][1], pulso: exampleData[indexPath.row][2])
//        return cell
//    }
//}
