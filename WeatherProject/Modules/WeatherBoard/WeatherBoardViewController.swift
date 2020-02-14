//
//  WeatherBoardViewController.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/9/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import UIKit

class WeatherBoardViewController: UIViewController, WeatherDetailViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewLayoutConstraintWidth: NSLayoutConstraint!
    @IBOutlet weak var contentViewLayoutConstraintHeight: NSLayoutConstraint!
    
    var weatherItems: [WeatherDetailView] = []
    let identifier = "WeatherIdentifier"
    var isConnectedNetwork = true
    var needReload = false
    var locations: [WLocation] = []
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNotificationCenter()
        
        loadLocation()
        
        viewModel = WeatherBoardViewModel(locations: locations)
        
        addWeatherDetailView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureLabels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureLabelsWithAnimation()
    }
    
    // MARK: ViewModel
    var viewModel: WeatherBoardViewModel? {
        didSet {
            setWeatherDetail()
        }
    }
    
    // MARK: Functions
    func registerNotificationCenter() -> Void {
        let noti = NotificationCenter.default
        noti.addObserver(self, selector: #selector(locationDidSelected), name: Notification.Name(Keys.LocationDidSelectedKey), object: nil)
    }
    
    func configureLabels(){
        
    }
    
    func configureLabelsWithAnimation(){
        
    }
    
    func reloadLayouts() -> Void {
        removeAllWeatherDetailView()
        
        loadLocation()
        
        viewModel = WeatherBoardViewModel(locations: locations)
        
        addWeatherDetailView()
    }
    
    func removeAllWeatherDetailView() -> Void {
        for detailView in weatherItems {
            detailView.removeFromSuperview()
        }
        
        weatherItems.removeAll()
    }
    
    func addWeatherDetailView() -> Void {
        if Reachability.isConnectedToNetwork(){
            isConnectedNetwork = true
        } else {
            isConnectedNetwork = false
        }
        
        var failedCount = 0
        
        for (index, location) in locations.enumerated() {
            let weatherDetailView = WeatherDetailView.init(frame: CGRect.init(x: CGFloat(index)*WScreen.screenWidth, y: 0, width: WScreen.screenWidth, height: WScreen.screenHeight))
            weatherDetailView.contentViewLayoutConstraintWidth.constant = WScreen.screenWidth
            weatherDetailView.delegate = self
            contentView.addSubview(weatherDetailView)
            weatherItems.append(weatherDetailView)
            
            if isConnectedNetwork {
                viewModel?.getWeatherInformationFromServer(cityId: location.id)
            } else {
                failedCount += 1
                print("Network is Unreachable!")
            }
        }
        
        contentViewLayoutConstraintWidth.constant = CGFloat(locations.count - failedCount)*(WScreen.screenWidth)
        contentViewLayoutConstraintHeight.constant = WScreen.screenHeight
        scrollView.contentSize = CGSize(width: contentViewLayoutConstraintWidth.constant, height: contentViewLayoutConstraintHeight.constant)
    }
    
    func loadLocation() -> Void {
        locations = DataBaseManger.loadLocationSelectedDB()
    }
    
    @objc func locationDidSelected() {
        if needReload {
            needReload = false
            reloadLayouts()
        }
    }
    
    // MARK: Actions
    @IBAction func shareButtonPressed(_ sender: Any) {
    }
    
    // MARK: Private Functions
    private func setWeatherDetail() {
        let locationIndex: Int = (viewModel?.locationIndex.value)!
        viewModel?.weatherDetails.observe {
            [unowned self] (weatherDetailVMs) in
            
            for (index, weatherDetailView) in self.weatherItems.enumerated() {
                weatherDetailView.loadViewModel(weatherDetailVMs[index])
                
                let location = WLocation(condition: Int(weatherDetailVMs[index].cityId.value)!, selected: true)
                let currentDayModel = weatherDetailVMs[index].currentDay.value
                let currentDay = CurrentDay(mainId: currentDayModel.mainId.value, mainTitle: currentDayModel.mainTitle.value, iconText: currentDayModel.iconText.value, dayTemp: currentDayModel.dayTemp.value, nightTemp: currentDayModel.nightTemp.value, eveTemp: currentDayModel.eveTemp.value, morTemp: currentDayModel.morTemp.value, minTemp: currentDayModel.minTemp.value, maxTemp: currentDayModel.maxTemp.value)
                var forecasts: [Forecast] = []
                for forecastModel in weatherDetailVMs[index].dayItems.value {
                    let forecast = Forecast(time: forecastModel.time.value, iconText: forecastModel.iconText.value, minTemp: forecastModel.minTemp.value, maxTemp: forecastModel.maxTemp.value)
                    forecasts.append(forecast)
                }
                let weather: Weather = Weather(location: location, currentDay: currentDay, forecasts: forecasts)
                DataBaseManger.updateWeatherDB(weather: weather)
            }
        }
    }
    
    // MARK: - WeatherDetailViewDeleagte
    func locationButtonDidPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let locationViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController")
        present(locationViewController, animated: true) {
            self.needReload = true
        }
    }
}
