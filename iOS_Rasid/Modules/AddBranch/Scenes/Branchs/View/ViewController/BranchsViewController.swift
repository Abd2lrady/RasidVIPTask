//
//  BranchsViewController.swift
//  iOS_Rasid
//
//  Created by Fintech on 06/11/2022.
//

import UIKit

class BranchsViewController: UIViewController {

    @IBOutlet weak var branchsTableView: UITableView!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var addBranchButton: UIButton!
    @IBOutlet weak var branchsTabelViewHeaderLabel: UILabel!
    var interactor: BranchsInteractorProtocol?
    var router: BranchsRouter?
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var filtersHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!

    var filters = [String]()
    
    lazy var branchsTableViewDelegate = BranchsTableViewDelegate(branchs: [Branch.ViewModel(branchName: "السعودية",
                                                                                            managerName: "احمد",
                                                                                            sellersCount: "5"),
                                                                          Branch.ViewModel(branchName: "fintech",
                                                                                           managerName: "abdelrady",
                                                                                           sellersCount: "5"),
                                                                          Branch.ViewModel(branchName: "fintech",
                                                                                           managerName: "abdelrady",
                                                                                           sellersCount: "5")])
    override func viewDidLoad() {
        super.viewDidLoad()
        configBranchsTableView()
        configFilterCollectionView()
        interactor?.request(request: .loadBranchs)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        interactor?.request(request: .loadBranchs)
        configUI()

    }
    
    @IBAction func tryButton(_ sender: Any) {
        router?.routeToFilter()
    }
}

extension BranchsViewController {
    func configBranchsTableView() {
        let cellNib = UINib(nibName: "\(BranchCell.self)",
                            bundle: .main)
        branchsTableView.register(cellNib,
                                  forCellReuseIdentifier: BranchCell.reuseID)
        
        branchsTableView.dataSource = branchsTableViewDelegate
        branchsTableView.delegate = branchsTableViewDelegate
        branchsTableViewDelegate.loadMoreRequest = {
            self.interactor?.request(request: .loadMoreBranchs)
            print("load more branchs")
        }
        branchsTableViewDelegate.showBranchDetails = { [weak self] indx in
            // 1- get branch id from interactor
            let branchId = self?.router?.dataStore.branchs?[indx ?? 0].id
            // 2- navigate to details with id
            self?.router?.routeToBranchDetails(facilityId: self?.router?.dataStore.facilityId ?? 0,
                                               branchId: branchId ?? 0)
        }
    }
    
    func configFilterCollectionView() {

        let cellNib = UINib(nibName: "\(FilterCell.self)",
                            bundle: .main)
        
        filterCollectionView.register(cellNib,
                                      forCellWithReuseIdentifier: FilterCell.reuseID)
        filterCollectionView.semanticContentAttribute = .forceRightToLeft
         
        filterCollectionView.dataSource = self
        
    }
    
    func configUI() {
        
        configNavBar()
        
        branchsTableView.backgroundColor = .clear
//        branchsTabelViewHeaderLabel.font = Fonts.Cairo.regular.font(size: 16)
//        branchsTabelViewHeaderLabel.textColor = Colors.branchsBranchsListHeader.color
//        branchsTabelViewHeaderLabel.text = Strings.branchListHeader

        addBranchButton.setImage(Images.addBranchButtonIc.image,
                                 for: .normal)
        addBranchButton.addTarget(self,
                                  action: #selector(addBranchTapped),
                                  for: .touchUpInside)
        
        reportButton.layer.cornerRadius = 5
//        reportButton.backgroundColor = Colors.branchsReportButtonBG.color
//        let reportButtonTitleString = Strings.reportButtonTitleString
//        let reportButtonTitleAtrributes = [NSAttributedString.Key.font:
//                                            Fonts.Cairo.regular.font(size: 16),
//                                           NSAttributedString.Key.foregroundColor:
//                                            Colors.branchsReportButtonTitle.color]
//        let reportButtonAttributedTitle = NSAttributedString(string: reportButtonTitleString,
//                                                             attributes: reportButtonTitleAtrributes)
//        reportButton.setAttributedTitle(reportButtonAttributedTitle,
//                                        for: .normal)
        reportButton.addTarget(self,
                               action: #selector(reportTapped),
                               for: .touchUpInside)
    }
    
    @objc
    func reportTapped() {
        print("report button tapped")
    }
    
    @objc
    func addBranchTapped() {
        router?.routeToAddBranch(facilityID: self.router?.dataStore.facilityId)
        print("add Branch button tapped")
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
//        let height = filterCollectionView.contentSize.height
//        self.filtersHeightConstrain.constant = height
        self.filterCollectionView.layoutIfNeeded()
    }
        
    func filterBranchs(filters: Branch.Filter) {
        print("filters", filters)
        interactor?.request(request: .filterBranchs(filters: filters))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let height = filterCollectionView.collectionViewLayout.collectionViewContentSize.height
        filtersHeightConstrain.constant = height
        self.view.layoutIfNeeded()

    }
}

// swiftlint: disable all
extension BranchsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("filter count from delegate", filters.count)
        return filters.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("dequeue filter cell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.reuseID,
                                                      for: indexPath) as! FilterCell
//        else { fatalError("can`t  dequeue filter cell") }
        cell.filterLabel.text = filters[indexPath.row]
        return cell

    }
}
