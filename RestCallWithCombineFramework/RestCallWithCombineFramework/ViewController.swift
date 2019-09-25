//
//  ViewController.swift
//  RestCallWithCombineFramework
//
//  Created by Gagan Vishal on 2019/09/25.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit
import Combine
fileprivate enum Section {
    case main
}

class ViewController: UITableViewController {
   //1. TableView differentiable Data source
   fileprivate var tableViewDiffableDataSource:  UITableViewDiffableDataSource<Section, SubModel>!
   //2. Bind fecth object
    var isFetchingObject = CurrentValueSubject<Bool, Never>(false)
    //3. Activitiy Indicator
    lazy var activityIndicator: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        $0.center = self.view.center
        self.view.addSubview($0)
        return $0
    }(UIActivityIndicatorView(style: .large))
    //4. ArtistSong
    let service = ArtistSong()
    //5.
    private var subscription = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpActivityIndicator()
        setupTableView()
        fetchSongItems()
    }
    //1.
    private func fetchSongItems(){
        self.isFetchingObject.value =  true
        service.fetchArtistSongList(from: .artistName).sink(receiveCompletion: { [unowned self](completion) in
            self.isFetchingObject.value = false
            if case let .failure(error) = completion {
               self.showError(error: error)
            }
            }, receiveValue: {[unowned self] in self.populateTableView(subModels: $0)})
            .store(in: &self.subscription)
    }
    
    //2.
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableViewDiffableDataSource = UITableViewDiffableDataSource<Section, SubModel>(tableView: tableView) { (tableView, indexPath, subModel) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
            cell.textLabel?.text = subModel.artistName
            return cell
        }
    }
    
    //3.
    private func showError(error: StoreAPIError){
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    //4. populate tableview model
    private func populateTableView(subModels : [SubModel]) {
        //1.
        var snapshotObject = NSDiffableDataSourceSnapshot<Section, SubModel>()
        //2. add section
        snapshotObject.appendSections([.main])
        //3. add row
        snapshotObject.appendItems(subModels)
        //4. apply snapshots
        tableViewDiffableDataSource.apply(snapshotObject, animatingDifferences: true)
    }
    
    //5. Activity Indictor Bidning
    private func setUpActivityIndicator() {
        self.isFetchingObject
            .assign(to: \UIActivityIndicatorView.activityIndicator_isAnimating, on: self.activityIndicator)
            .store(in: &self.subscription)
    }
}

//MARK:- ActivityView extension
extension UIActivityIndicatorView {
    var activityIndicator_isAnimating: Bool {
        set {
            if (newValue) {
                startAnimating()
            }
            else {
                stopAnimating()
            }
        }
        get {
            return isAnimating
        }
    }
}
