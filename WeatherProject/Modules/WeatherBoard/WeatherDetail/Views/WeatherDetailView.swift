//
//  WeatherDetailView.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/9/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import UIKit

protocol WeatherDetailViewDelegate: class {
    func locationButtonDidPressed() -> Void
}

class WeatherDetailView: UIView {
    var view: UIView!
    weak var delegate: WeatherDetailViewDelegate?
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var currentDayView: CurrentDayView!
    @IBOutlet weak var dayItemStackView: UIStackView!
    @IBOutlet weak var firstDayItemView: DayItemView!
    @IBOutlet weak var secondDayItemView: DayItemView!
    @IBOutlet weak var thirdDayItemView: DayItemView!
    @IBOutlet weak var fourthDayItemView: DayItemView!
    @IBOutlet weak var fifthDayItemView: DayItemView!
    
    @IBOutlet weak var contentViewLayoutConstraintWidth: NSLayoutConstraint!
    @IBOutlet weak var contentViewLayoutConstraintHeight: NSLayoutConstraint!
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        view = loadViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = loadViewFromNib()
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName(), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        return view
    }
    
    //MARK: ViewModel
    var viewModel: WeatherDetailViewModel? {
        didSet {
            setCityNameLabel()
            
            setCurrentDayView()
            
            setDayItemsView()
        }
    }
    
    func loadViewModel(_ viewModel: WeatherDetailViewModel) {
      self.viewModel = viewModel
    }
    
    // MARK: Private Functions
    fileprivate func nibName() -> String {
      return String(describing: type(of: self))
    }
    
    private func setCityNameLabel() {
        viewModel?.cityName.observe {
            [unowned self] in
            self.cityNameLabel.text = $0
        }
    }
    
    private func setCurrentDayView() {
        viewModel?.currentDay.observe {
            [unowned self] (currentDayViewModel) in
            self.currentDayView.loadViewModel(currentDayViewModel)
        }
    }
    
    private func setDayItemsView() {
        viewModel?.dayItems.observe {
            [unowned self] (dayItemViewModels) in
            if dayItemViewModels.count >= 5 {
                for i in 0...4 {
                    switch i {
                    case 0:
                        self.firstDayItemView.loadViewModel(dayItemViewModels[i])
                    case 1:
                        self.secondDayItemView.loadViewModel(dayItemViewModels[i])
                    case 2:
                        self.thirdDayItemView.loadViewModel(dayItemViewModels[i])
                    case 3:
                        self.fourthDayItemView.loadViewModel(dayItemViewModels[i])
                    case 4:
                        self.fifthDayItemView.loadViewModel(dayItemViewModels[i])
                        
                    default:
                        self.fifthDayItemView.loadViewModel(dayItemViewModels[i])
                    }
                }
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func locationButtonAction(_ sender: Any) {
        self.delegate?.locationButtonDidPressed()
    }
}
