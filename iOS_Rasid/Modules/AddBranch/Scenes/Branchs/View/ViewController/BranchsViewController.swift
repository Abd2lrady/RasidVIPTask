//
//  BranchsViewController.swift
//  iOS_Rasid
//
//  Created by Fintech on 06/11/2022.
//

import UIKit

protocol BranchsViewControllerProtocol: AnyObject {
    func showBranchs(branchs: [Branch.ViewModel])
}

class BranchsViewController: UIViewController {

    @IBOutlet weak var branchsTableView: UITableView!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var branchsTabelViewHeaderLabel: UILabel!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var filtersHeightConstrain: NSLayoutConstraint!

    var filters = [String]()
    var interactor: BranchsInteractorProtocol?
    var router: BranchsRouter?
    var branchViewModels = [Branch.ViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configBranchsTableView()
        configFilterCollectionView()
        interactor?.request(request: .loadBranchs)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configUI()
    }
    
    @IBAction func reportButtonTapped(_ sender: Any) {
        print("report button tapped")

    }
    
    @IBAction func addBranchButtonTapped(_ sender: Any) {
        print("add Branch button tapped")
        router?.routeToAddBranch(facilityID: self.router?.dataStore.facilityId)
    }
    
}

extension BranchsViewController {
    func configBranchsTableView() {
        let cellNib = UINib(nibName: "\(BranchCell.self)",
                            bundle: .main)
        branchsTableView.register(cellNib,
                                  forCellReuseIdentifier: BranchCell.reuseID)
        
        branchsTableView.dataSource = self
        branchsTableView.delegate = self
    }
    
    func configFilterCollectionView() {

        let cellNib = UINib(nibName: "\(FilterCell.self)",
                            bundle: .main)
        
        filterCollectionView.register(cellNib,
                                      forCellWithReuseIdentifier: FilterCell.reuseID)
         
        filterCollectionView.dataSource = self
        
    }
    
    func configUI() {
        
        configNavBar()
        branchsTableView.backgroundColor = .clear
        reportButton.layer.cornerRadius = 5
    }
    
    func configNavBar() {
        hideNavBar()
        let filterButton = UIButton()
        filterButton.setImage(Images.filter.image,
                              for: .normal)
        filterButton.addTarget(self,
                               action: #selector(filterButtonTapped),
                               for: .touchUpInside)
        let rightItem = UIBarButtonItem(customView: filterButton)
        navigationItem.rightBarButtonItem = rightItem
    }
    
    func hideNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
    }
    
    @objc
    func filterButtonTapped() {
        router?.routeToFilter()
    }
    
    func showFilters() {
        self.filterCollectionView.reloadData()
        self.filterCollectionView.isHidden = false
        self.filterCollectionView.layoutIfNeeded()
        let height = filterCollectionView.contentSize.height
        self.filtersHeightConstrain.constant = height
    }
        
    func filterBranchs(filters: Branch.Filter) {
        print("filters", filters)
        interactor?.request(request: .filterBranchs(filters: filters))
    }
    
}

extension BranchsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("filter count from delegate", filters.count)
        return filters.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("dequeue filter cell")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.reuseID,
                                                            for: indexPath) as? FilterCell
        else { fatalError("can`t  dequeue filter cell") }
        cell.filterLabel.text = filters[indexPath.row]
        return cell

    }
}

extension BranchsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branchViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BranchCell.reuseID,
                                                       for: indexPath) as? BranchCell
        else { return UITableViewCell() }
        cell.configCell(with: branchViewModels[indexPath.row])
        cell.viewDetailsTapped = { [weak self] in
            self?.router?.routeToBranchDetails(at: indexPath.row)
        }
      return cell
    }
    
}

extension BranchsViewController: UITableViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let dragOffestY = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let container = scrollView.frame.size.height
    
        if dragOffestY > ((totalContentHeight - container) + 50) {
            print("load more")
            self.interactor?.request(request: .loadMoreBranchs)
        }
    }

}

extension BranchsViewController: BranchsViewControllerProtocol {
    func showBranchs(branchs: [Branch.ViewModel]) {
        self.branchViewModels = branchs
        branchsTableView.reloadData()
    }
}
