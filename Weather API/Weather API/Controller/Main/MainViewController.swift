//
//  MainViewController.swift
//  Weather API
//
//  Created by imac-1682 on 2023/8/11.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var rightBarButton_choose: UIBarButtonItem?
    var WeatherData: WeatherResponse?
    var catchArea: String = ""
    var reloadDelegate: ReloadTableViewDelegate?
    
//    var reloadAPI: ReloadAPI?
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    func setupNavigation() {
        
        rightBarButton_choose = UIBarButtonItem(title: "選擇", style: .done, target: self, action: #selector(chooseBTN))
        
        navigationItem.rightBarButtonItem = rightBarButton_choose
        title = "天氣"
    }
    
    // MARK: - Call API
    func CallAPI(_ Area: String) {

        if Area != "" {
            var address: String = ""
            if let encodedLocation = Area.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                address = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-B2DBC725-8F48-451C-98B0-E75A0326E789&locationName=\(encodedLocation)"
            }
            let url = URL(string: address)
            URLSession.shared.dataTask(with: url!) { [self] data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        WeatherData = try decoder.decode(WeatherResponse.self, from: data)
                        DispatchQueue.main.async {
                            tableView.reloadData()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 600, repeats: true) { timer in
            // 这里是您想要在每分钟触发时执行的代码
            self.CallAPI(self.catchArea)
        }
    }
    
    // MARK: - IBAction
    @objc func chooseBTN() {
        
        let chooseVC = ChooseViewController()
        chooseVC.SendArea = self
        chooseVC.reloadAView = self
        chooseVC.reloadAPI = self 
        chooseVC.recieveArea = catchArea
        let navigationController = UINavigationController(rootViewController: chooseVC)
        navigationController.isNavigationBarHidden = false
        self.present(navigationController, animated: true, completion: nil)

    }
}
// MARK: - Extension

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        
        DispatchQueue.main.async { [self] in
            
            cell.Area.text = WeatherData?.records.location[0].locationName
            cell.Wx.text = WeatherData?.records.location[0].weatherElement[0].time[indexPath.row].parameter.parameterName
            cell.startTime.text = WeatherData?.records.location[0].weatherElement[0].time[indexPath.row].startTime
            cell.endTime.text = WeatherData?.records.location[0].weatherElement[0].time[indexPath.row].endTime
            cell.PoP.text = WeatherData?.records.location[0].weatherElement[1].time[indexPath.row].parameter.parameterName
            cell.MinT.text = WeatherData?.records.location[0].weatherElement[2].time[indexPath.row].parameter.parameterName
            cell.CI.text = WeatherData?.records.location[0].weatherElement[3].time[indexPath.row].parameter.parameterName
            cell.MaxT.text = WeatherData?.records.location[0].weatherElement[4].time[indexPath.row].parameter.parameterName
        }
        return cell
    }
    
}

extension MainViewController: SendArea {
    func sendArea(Area: String) {
        catchArea = Area
    }
}

extension MainViewController: ReloadTableViewDelegate {
    func reloadtableview() {
        tableView.reloadData()
    }
}

extension MainViewController: ReloadAPI {
    func reloadAPI(area: String) {
        CallAPI(area)
    }
}
// MARK: - Protocol

protocol ReloadTableViewDelegate {
    func reloadtableview()
}

protocol ReloadAPI {
    func reloadAPI(area: String)
}

