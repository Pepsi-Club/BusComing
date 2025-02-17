import UIKit

import Domain
import DesignSystem
import RxSwift

public final class RegularAlarmViewController: UIViewController {
    private let viewModel: RegularAlarmViewModel
    
    private var dataSource: RegularAlarmDataSource!
    private var disposeBag = DisposeBag()
    private var editItemSelected = PublishSubject<RegularAlarmResponse>()
    private var removeItemSelected = PublishSubject<RegularAlarmResponse>()
    
    private let emptyRegularAlarmView = EmptyRegularAlarmView()
    private let floatingBtnSpacingView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = DesignSystemFontFamily.NanumSquareNeoOTF.extraBold.font(
            size: 25
        )
        label.text = "정기알람"
        label.textColor = DesignSystemAsset.settingColor.color
        return label
    }()
    
    private lazy var alarmTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = DesignSystemAsset.cellColor.color
        tableView.separatorStyle = .none
        tableView.backgroundView = emptyRegularAlarmView
        tableView.register(RegularAlarmTVCell.self)
        tableView.tableFooterView = floatingBtnSpacingView
        return tableView
    }()
    
    private let addBtn: BottomButton = {
        let addBtn = BottomButton(title: "추가하기")
        addBtn.accessibilityIdentifier = "정규알람 추가하기"
        return addBtn
    }()
    
    public init(viewModel: RegularAlarmViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bind()
        configureDataSource()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(
            true,
            animated: true
        )
    }
    
    private func configureUI() {
        view.backgroundColor = DesignSystemAsset.cellColor.color
        
        [floatingBtnSpacingView, titleLabel, alarmTableView, addBtn].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: 15
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 20
            ),
            
            alarmTableView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor
            ),
            alarmTableView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            alarmTableView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            alarmTableView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor
            ),
            
            addBtn.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            addBtn.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor,
                multiplier: 0.5
            ),
            addBtn.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: -40
            ),
            
            floatingBtnSpacingView.widthAnchor.constraint(
                equalTo: safeArea.widthAnchor
            ),
            floatingBtnSpacingView.heightAnchor.constraint(
                equalTo: addBtn.heightAnchor,
                constant: 60
            )
        ])
    }
    
    private func bind() {
        let output = viewModel.transform(
            input: .init(
                viewWillAppearEvent: rx
                    .methodInvoked(#selector(UIViewController.viewWillAppear))
                    .map { _ in },
                addBtnTapEvent: addBtn.rx.tap.asObservable(),
                editItemSelected: editItemSelected,
                removeItemSelected: removeItemSelected
            )
        )
        
        output.regularAlarmList
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { viewController, responses in
                    if responses.isEmpty {
                        viewController.alarmTableView.backgroundView
                        = viewController.emptyRegularAlarmView
                    } else {
                        viewController.alarmTableView.backgroundView = nil
                    }
                    viewController.updateSnapshot(responses: responses)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func configureDataSource() {
        dataSource = .init(
            tableView: alarmTableView
        ) { [weak self] tableView, indexPath, item in
            guard let self else { return .init() }
            let cell = tableView.dequeueReusableCell(
                withIdentifier: RegularAlarmTVCell.identifier,
                for: indexPath
            ) as? RegularAlarmTVCell
            cell?.updateUI(response: item)
            let tapGesture = UITapGestureRecognizer()
            cell?.contentView.addGestureRecognizer(tapGesture)
            tapGesture.rx.event
                .map { _ in
                    item
                }
                .bind(to: editItemSelected)
                .disposed(by: disposeBag)
            cell?.removeBtnTapEvent
                .map { _ in
                    item
                }
                .bind(to: self.removeItemSelected)
                .disposed(by: self.disposeBag)
            return cell
        }
    }
    
    private func updateSnapshot(responses: [RegularAlarmResponse]) {
        var snapshot = RegularAlarmSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(responses)
        dataSource.apply(snapshot)
    }
}

extension RegularAlarmViewController {
    typealias RegularAlarmDataSource
    = UITableViewDiffableDataSource<Int, RegularAlarmResponse>
    typealias RegularAlarmSnapshot
    = NSDiffableDataSourceSnapshot<Int, RegularAlarmResponse>
}
