//
//  ExpensesListVC.swift
//  TBInterview
//
//  Created by David Ruvinskiy on 8/22/22.
//

import UIKit

class ExpensesListVC: TBDataLoadingVC {
    enum Section { case main }
    
    var interactor = Interactor(api: API())
    var expenses = [Expense]()
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Expense>!
    let overviewView = OverviewView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        layoutUI()
        getExpenses()
        configureDataSource()
    }
    
    func configureViewController() {
        view.backgroundColor = .white
    }
    
    func layoutUI() {
        view.addSubViews(overviewView, collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            overviewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            overviewView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overviewView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overviewView.heightAnchor.constraint(equalToConstant: 140),
            
            collectionView.topAnchor.constraint(equalTo: overviewView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionView.createExpensesListVCFlowLayout(in: view))
        collectionView.backgroundColor = .zircon
        collectionView.register(ExpenseCell.self, forCellWithReuseIdentifier: ExpenseCell.reuseID)
    }
    
    func getExpenses() {
        showLoadingView()
        
        interactor.getExpenses { [weak self] (result: Result<[Expense], TBError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let expenses):
                self.updateData(on: expenses)
                
                self.interactor.fetchMonthlyBudget { [weak self] budget in
                    guard let self = self else { return }
                    self.dismissLoadingView()
                    self.overviewView.set(expenses: expenses, budget: budget)
                }
            case .failure(let error):
                self.dismissLoadingView()
                self.presentTBAlertOnMainThread(title: "Something Went Wrong", message: error .rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Expense>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, expense) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpenseCell.reuseID, for: indexPath) as! ExpenseCell
            cell.set(expense: expense)
            
            return cell
        })
    }
    
    func updateData(on expenses: [Expense]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Expense>()
        snapshot.appendSections([.main])
        snapshot.appendItems(expenses)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}
