//
//  SearchViewController.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 22/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import UIKit
import IGListKit
import SVPullToRefresh

final class SearchViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: SearchPresenterInterface!
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    lazy var viewLayout: ListCollectionViewLayout = {
        let layout = ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        view.backgroundColor = .systemGroupedBackground
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        return view
    }()
    
    lazy var filterButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Filter", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .tokopediaGreen
        button.isHidden = true
        button.addTarget(self, action: #selector(didSelectFilterButton), for: .touchUpInside)
        return button
    }()
    
    lazy private var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Data
    var data = [ListDiffable]()
    
    // Show data setup
    var showDataFunction: ((_ data: [ListDiffable]) -> ())?
    
    // Refresh setup
    var refreshFunction: (() -> ())?
    
    var loadMoreFunction: (() -> ())?
    
    var isShowingButton = false

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        setupViews()
        showDataFunction = { [weak self] data in
            self?.data = data
            self?.adapter.performUpdates(animated: true, completion: { [weak self] (_) in
                self?.adapter.collectionView?.infiniteScrollingView.stopAnimating()
                self?.adapter.collectionView?.pullToRefreshView.stopAnimating()
                if self?.isShowingButton == false {
                    self?.filterButton.isHidden = false
                    self?.isShowingButton = true
                }
            })
        }
        
        loadMoreFunction = { [weak self] in
            self?.presenter.requestLoadMore()
        }
        
        refreshFunction = { [weak self] in
            self?.presenter.requestRefresh()
        }
        presenter.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layoutFrameGuide = view.layoutGuide.layoutFrame
        collectionView.frame = layoutFrameGuide
        loadingView.frame = view.bounds
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(filterButton)
        view.addSubview(loadingView)
        collectionView.addInfiniteScrolling(actionHandler: { [weak self] in
            self?.presenter.requestLoadMore()
        })
        collectionView.addPullToRefresh { [weak self] in
            self?.refreshFunction?()
        }
        adapter.collectionView = collectionView
        adapter.dataSource = self
        NSLayoutConstraint.activate([
            filterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterButton.bottomAnchor.constraint(equalTo: view.layoutGuide.bottomAnchor),
            filterButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func didSelectFilterButton() {
        presenter.didSelectFilterAction()
    }
    
    func listSectionController(forObject object: Any) -> ListSectionController {
        if object is ProductModel {
            return ProductSectionController()
        }
        return ListSectionController()
    }
	
}

// MARK: - Extensions -

// MARK: - UIScrollViewDelegate -

extension SearchViewController: SearchViewInterface {
    func showData(_ data: [ListDiffable]) {
        showDataFunction?(data)
    }
    
    func showLoader(_ show: Bool) {
        if show {
            loadingView.startAnimating()
        } else {
            loadingView.stopAnimating()
            adapter.collectionView?.infiniteScrollingView.stopAnimating()
            adapter.collectionView?.pullToRefreshView.stopAnimating()
        }
    }
}

// MARK: - ListAdapter Data Source -

extension SearchViewController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return listSectionController(forObject: object)
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}
