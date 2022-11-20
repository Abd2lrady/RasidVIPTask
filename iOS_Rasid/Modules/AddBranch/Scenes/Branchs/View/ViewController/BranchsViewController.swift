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
    @IBOutlet weak var filterCollectionView: DynamicHeightCollectionView!
    
    @IBOutlet weak var filterLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var filtersHeightConstrain: NSLayoutConstraint!
    var filterView: CustomAlertView?

    var filters = [String]() {
        didSet {
            self.showFilters()
        }
    }
    
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
        interactor?.request(request: .loadBranchs)
        configUI()

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
            print("needs to show details for cell index \(indx)")
            // 1- get branch id from interactor
            let branchId = self?.router?.dataStore.branchs?[indx ?? 0].id
            // 2- navigate to details with id
            self?.router?.routeToBranchDetails(facilityId: self?.router?.dataStore.facilityId ?? 0,
                                               branchId: branchId ?? 0)
        }
    }
    
    func configFilterCollectionView() {
//        let size = CGSize(width: 120, height: 32)
//        filterLayout.itemSize = size
//        filterLayout.estimatedItemSize = size
        
//        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false

        let cellNib = UINib(nibName: "\(FilterCell.self)",
                            bundle: .main)
        
        filterCollectionView.register(cellNib,
                                      forCellWithReuseIdentifier: FilterCell.reuseID)
        filterCollectionView.semanticContentAttribute = .forceRightToLeft
         
//        filtersHeightConstrain.constant = 1
        filterCollectionView.dataSource = self
    }
    
    func configUI() {
        
        configNavBar()
        
        branchsTableView.backgroundColor = .clear
        
        branchsTabelViewHeaderLabel.font = Fonts.Cairo.regular.font(size: 16)
        branchsTabelViewHeaderLabel.textColor = Colors.branchsBranchsListHeader.color
        branchsTabelViewHeaderLabel.text = Strings.branchListHeader

        addBranchButton.setImage(Images.addBranchButtonIc.image,
                                 for: .normal)
        addBranchButton.addTarget(self,
                                  action: #selector(addBranchTapped),
                                  for: .touchUpInside)
        
        reportButton.layer.cornerRadius = 5
        reportButton.backgroundColor = Colors.branchsReportButtonBG.color
        let reportButtonTitleString = Strings.reportButtonTitleString
        let reportButtonTitleAtrributes = [NSAttributedString.Key.font:
                                            Fonts.Cairo.regular.font(size: 16),
                                           NSAttributedString.Key.foregroundColor:
                                            Colors.branchsReportButtonTitle.color]
        let reportButtonAttributedTitle = NSAttributedString(string: reportButtonTitleString,
                                                             attributes: reportButtonTitleAtrributes)
        reportButton.setAttributedTitle(reportButtonAttributedTitle,
                                        for: .normal)
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
        let frame = CGRect(x: 0,
                           y: 0,
                           width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height)
        let filterView = CustomAlertView(frame: frame)
        
        filterView.buttonTappedCallback = { filters in
            print("search tapped")

            self.filters = filters.getFilters()
            print(self.filters)
            hideFilterView()
            
            self.filterBranchs(filters: filters)
        }
        
        filterView.tapGestureDetected = {
            hideFilterView()
        }
        
        self.navigationItem.rightBarButtonItem?.customView?.isUserInteractionEnabled = false

        self.filterView = filterView
        view.addSubview(filterView)
        
        print("filter tapped")

        func hideFilterView() {
            filterView.removeFromSuperview()
            self.navigationItem.rightBarButtonItem?.customView?.isUserInteractionEnabled = true
        }
    }
    
    func showFilters() {
        self.filterCollectionView.reloadData()
        filterCollectionView.isScrollEnabled = false
        self.filterCollectionView.invalidateIntrinsicContentSize()
        self.filtersHeightConstrain.constant = self.filterCollectionView.contentSize.height
        self.filterCollectionView.layoutSubviews()

    }
    
    func filterBranchs(filters: Branch.Filter) {
        interactor?.request(request: .filterBranchs(filters: filters))
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
