//
//  CollectionDataSource.swift
//  poke-list
//
//  Created by Nicola Innocenti on 30/10/21.
//

import Foundation
import UIKit
import RealmSwift

class CollectionDataSource<CELL: UICollectionViewCell, T: Object> : NSObject, UICollectionViewDataSource {
    
    private var collectionView: UICollectionView?
    private var cellIdentifier: String!
    private var items: Results<T>!
    private var notificationToken: NotificationToken?
    var configureCell: (CELL, T, IndexPath) -> () = {_, _, _ in }
    
    init(collectionView: UICollectionView?, cellIdentifier: String, items: Results<T>, configureCell: @escaping (CELL, T, IndexPath) -> ()) {
        super.init()
        self.collectionView = collectionView
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
        observeChanges()
    }
    
    private let fromRow = {(row: Int) in return IndexPath(row: row, section: 0)}
    
    private func observeChanges() {
        self.notificationToken = self.items.observe(on: nil, { changes in
            if let cv = self.collectionView {
                switch changes {
                    case .initial:
                        cv.reloadData()
                    case .update(_, let deletions, let insertions, let modifications):
                        cv.performBatchUpdates({
                            cv.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
                            cv.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                            cv.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                        }, completion: { finished in
                            
                        })
                    case .error(let error):
                        fatalError("\(error)")
                }
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CELL
       
       let item = self.items[indexPath.row]
       configureCell(cell, item, indexPath)
       return cell
    }
}
