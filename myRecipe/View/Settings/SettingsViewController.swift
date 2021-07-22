//
//  SettingsViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 19.07.2021.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let viewModel: SettingsViewModel
    private let parametersViewFactory: ParametersViewFactory
    
    private let spacingBetweenGroups: CGFloat = 20
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var intolerancesStackView: UIStackView = {
        let stack = parametersViewFactory.createHorizontalStack()
        stack.addArrangedSubview(parametersViewFactory.createTitleLabel(text: "Your Intolerances"))
        stack.addArrangedSubview(chosenIntolerancesLabel)
        return stack
    }()
    
    private lazy var chosenIntolerancesLabel: UILabel = {
        let label = parametersViewFactory.createChosenLabel(text: viewModel.getUserIntolerances() ?? "Choose")
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(showMultipleChoosingController))
        
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private lazy var measureSystemStackView: UIStackView = {
        let stack = parametersViewFactory.createHorizontalStack()
        stack.addArrangedSubview(parametersViewFactory.createTitleLabel(text: "Prefered Measure System"))
        stack.addArrangedSubview(chosenMeasureSystemSegmentedControl)
        return stack
    }()
    
    private lazy var chosenMeasureSystemSegmentedControl: UISegmentedControl = {
        let items = ["Metric", "US"]
        
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(segmentedControlDidChange), for: .valueChanged)
        
        switch viewModel.getUserMeasureSystem() {
        case .metric:
            segmentedControl.selectedSegmentIndex = 0
        case .US:
            segmentedControl.selectedSegmentIndex = 1
        }
        
        return segmentedControl
    }()
    
    init(viewModel: SettingsViewModel, parametersViewFactory: ParametersViewFactory) {
        self.viewModel = viewModel
        self.parametersViewFactory = parametersViewFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAutoLayout()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "background")
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        
        view.addSubview(scrollView)
        scrollView.addSubview(intolerancesStackView)
        scrollView.addSubview(measureSystemStackView)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            intolerancesStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: spacingBetweenGroups),
            intolerancesStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            intolerancesStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            measureSystemStackView.topAnchor.constraint(equalTo: intolerancesStackView.bottomAnchor, constant: spacingBetweenGroups),
            measureSystemStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            measureSystemStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            measureSystemStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -spacingBetweenGroups)
        ])
    }
    
    @objc private func showMultipleChoosingController() {
        let multipleChoosingController = MultipleChoosingViewController(items: viewModel.intolerances)
        
        multipleChoosingController.selectedItems = { [weak self] intolerances in
            let chosenIntolerances = intolerances.joined(separator: ", ")
            self?.chosenIntolerancesLabel.text = intolerances.isEmpty ? "Choose" : chosenIntolerances
            self?.viewModel.setUserIntolerances(chosenIntolerances)
        }
        
        navigationController?.pushViewController(multipleChoosingController, animated: true)
    }
    
    @objc private func segmentedControlDidChange() {
        if chosenMeasureSystemSegmentedControl.selectedSegmentIndex == 0 {
            viewModel.setUserMeasureSystem(.metric)
        } else {
            viewModel.setUserMeasureSystem(.US)
        }
    }
}
