//
//  ViewController.swift
//  WeatheriOSAssignment
//
//  Created by Madhuri Patil on 03/07/21.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var citysearchbar: UISearchBar!
    
    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var validationLabel: UILabel!
    
    
    private var weatherViewModel: WeatherViewModel!
    var weather = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityName.delegate = self
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        
        Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(expiredLocalRecords), userInfo: nil, repeats: true)
        
        weather = DatabaseHelper.sharedInstance.fetchWeatherData()
    }
    
    @objc func expiredLocalRecords()
    {
        weather = DatabaseHelper.sharedInstance.deleteData()
        DispatchQueue.main.async {
            self.tabelView.reloadData()
        }
    }
    
    func searchCity(cityName: String) {
        
        weather = DatabaseHelper.sharedInstance.fetchSearchedData(city: cityName)
        if weather.count <= 0 {
            weatherViewModel = WeatherViewModel()
            weatherViewModel.callGetWeatherData(cityName:cityName, completion: { (data, error) in
                if let data = data {
                    
                    let dict = ["cityname": data.cityName, "temp": "\(data.tempData.temp)", "date": Date()] as [String : Any]
                    DatabaseHelper.sharedInstance.save(object: dict)
                    self.weather = DatabaseHelper.sharedInstance.fetchWeatherData()
                    DispatchQueue.main.async {
                        self.validationLabel.isHidden = true
                        self.cityName.text = ""
                        self.tabelView.reloadData()
                    }
                    
                } else if let error = error {
                    DispatchQueue.main.async {
                        self.validationLabel.isHidden = false
                        self.validationLabel.text = error
                    }
                }
            })
        }
    }
    
}

//MARK :- Textfield deletgate methods
extension WeatherViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text!.isEmpty {
            validationLabel.isHidden = false
        } else {
            searchCity(cityName: textField.text! )
            validationLabel.isHidden = true
        }
        return true
    }
}


//MARK :- TableView DataSource methods
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTabelCell", for: indexPath) as! WeatherTabelCell
        let data = weather[indexPath.row]
        if let dateTime = data.date, let city = data.cityname, let temp = data.temp {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, HH:mm"
            let time = dateFormatter.string(from: dateTime)
            
            cell.cityNamelabel.text = city
            cell.tempabel.text = temp
            cell.datelabel.text = time
        }
        return cell
        
    }
    
    
}

