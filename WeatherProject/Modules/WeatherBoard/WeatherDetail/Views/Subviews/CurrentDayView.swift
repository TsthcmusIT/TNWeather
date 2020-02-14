//
//  CurrentDayView.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/9/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import UIKit

class CurrentDayView: UIView {
    var view: UIView!

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var maxTempImageView: UIImageView!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var mainTempLabel: UILabel!
    
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

    // MARK: - ViewModel
    var viewModel: CurrentDayViewModel? {
        didSet {
            viewModel?.iconText.observe {
                [unowned self] in
                self.mainImageView.image = UIImage(named: $0)
            }

            viewModel?.mainTitle.observe {
              [unowned self] in
              self.mainLabel.text = $0
            }

            viewModel?.dayTemp.observe {
              [unowned self] in
              self.mainTempLabel.text = $0 + "°"
            }
            
            viewModel?.nightTemp.observe {
              [unowned self] in
              self.mainTempLabel.text = $0 + "°"
            }
            
            viewModel?.eveTemp.observe {
              [unowned self] in
              self.mainTempLabel.text = $0 + "°"
            }
            
            viewModel?.morTemp.observe {
              [unowned self] in
              self.mainTempLabel.text = $0 + "°"
            }
            
            viewModel?.maxTemp.observe {
              [unowned self] in
              self.maxTempLabel.text = $0 + "°"
            }

            viewModel?.minTemp.observe {
              [unowned self] in
              self.minTempLabel.text = $0 + "°"
            }
        }
    }

    func loadViewModel(_ viewModel: CurrentDayViewModel) {
      self.viewModel = viewModel
    }

    // MARK: - Private
    fileprivate func nibName() -> String {
        return String(describing: type(of: self))
    }
    
}
