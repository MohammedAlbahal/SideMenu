//
//  ViewController.swift
//  SideMenu
//
//  Created by M.Al-qhtani on 18/12/21.
//

import UIKit
class ViewController: UIViewController {
    var sideBarView: UIView!
    var tableView = UITableView()
    var toplabel = UILabel()
    var bottomView = UIView()
    lazy var logOutBtn: UIButton = {
        let buttonSingOut = UIButton(type: .system)
        buttonSingOut.setTitle(NSLocalizedString("singOut", comment: ""), for: .normal)
        buttonSingOut.setTitleColor(.red, for: .normal)
        buttonSingOut.translatesAutoresizingMaskIntoConstraints = false
        buttonSingOut.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        buttonSingOut.addTarget(self, action: #selector(singOutButtonTapped), for: .touchUpInside)
        return buttonSingOut
    }()
    var nameLbl = UILabel()
    var imageview = UIImageView()
    var topHeight_navigationBar_statusBar:CGFloat = 0.0
    var isEnableSideBarView:Bool = false
    
    
    var arrData = ["Subject", "Instructors","Students","Top 10 Students","Exercises","Calculate your Rate","Learning Resource","Location","Setting"]
    var arrImages:[UIImage] = [#imageLiteral(resourceName: "square.and.pencil"),#imageLiteral(resourceName: "person.wave.2"),#imageLiteral(resourceName: "person.3"),#imageLiteral(resourceName: "figure.wave"),#imageLiteral(resourceName: "square.and.pencil"),#imageLiteral(resourceName: "keyboard.onehanded.right"),#imageLiteral(resourceName: "globe.badge.chevron.backward"),#imageLiteral(resourceName: "location"),#imageLiteral(resourceName: "gear.circle-1")]
    
    var swipeToRight = UISwipeGestureRecognizer()
    var swipetoLeft = UISwipeGestureRecognizer()
    var tempview = UIView()
    var tapGesture = UITapGestureRecognizer()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewFunctionality()
        loadSideBarViewFunctionality()
        loadGesturefunctionality()
    }
    
    
    
    
    func loadViewFunctionality(){
        var menuBtn = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .done, target: self, action: #selector(menuBtnClick))
        menuBtn.tintColor = UIColor(named: "Color-2")
        self.navigationItem.leftBarButtonItem = menuBtn
    }
    @objc private func singOutButtonTapped(sender: UIButton!) {
        let alert = UIAlertController(title:"Sign Out",
                                      message: "Are you sure you want to sign out",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            action in
            self.dismiss(animated: true) {
                self.navigationController?.popViewController(animated: true)
            }
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        self.present(alert, animated: true)
    }
    
    func loadSideBarViewFunctionality(){
        topHeight_navigationBar_statusBar = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height)!
        
        tempview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        tempview.backgroundColor = .white
        tempview.clipsToBounds = true
        sideBarView = UIView(frame: CGRect(x: -self.view.bounds.width/1.5, y: topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - topHeight_navigationBar_statusBar))
        sideBarView.layer.cornerRadius = 15
        sideBarView.clipsToBounds = true
        //--------------------
        tableView.backgroundColor = UIColor(named: "Color")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SideBarTableViewCell", bundle: nil), forCellReuseIdentifier: "sideBarCell")
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        toplabel.text = "Tuwaiq 1000"
        toplabel.textAlignment = .center
        toplabel.font = UIFont(name: "Party LET", size: 45)
        toplabel.textColor = UIColor.black
        toplabel.backgroundColor = UIColor(named: "Color-2")
        
        bottomView.backgroundColor = UIColor(named: "Color-2")
        
        logOutBtn.setTitle("Log Out", for: .normal)
        logOutBtn.backgroundColor = UIColor(named: "Color")
        logOutBtn.setTitleColor(.red, for: .normal)
        logOutBtn.titleLabel?.textColor = UIColor.white
        logOutBtn.titleLabel?.font = UIFont(name: "Chalkboard SE", size: 20)
        
        nameLbl.numberOfLines = 0
        nameLbl.text = "Mohammed Ali"
        nameLbl.textColor = UIColor(named: "Color-1")
        nameLbl.tintColor = UIColor(named: "Color-1")
        nameLbl.textAlignment = NSTextAlignment.center
        nameLbl.backgroundColor = UIColor(named: "Color")
        
        
        imageview.image = UIImage(imageLiteralResourceName: "Mh")
        self.imageview.clipsToBounds = true
        self.imageview.layer.borderWidth = 1
        self.imageview.layer.borderColor = UIColor.white.cgColor
        
        self.view.addSubview(tempview)
        self.view.addSubview(sideBarView)
        self.sideBarView.addSubview(toplabel)
        self.sideBarView.addSubview(bottomView)
        self.sideBarView.addSubview(tableView)
        self.bottomView.addSubview(logOutBtn)
        self.bottomView.addSubview(imageview)
        self.bottomView.addSubview(nameLbl)
        setUpSideBarViewConstraints()
        setUpBottomViewConstraints()
    }
    
    
    func loadGesturefunctionality(){
        swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedToRight))
        swipeToRight.direction = .right
        self.view.addGestureRecognizer(swipeToRight)
        
        swipetoLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedToLeft))
        swipetoLeft.direction = .left
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeSideBarView))
        tempview.addGestureRecognizer(tapGesture)
    }
    
    
    func setUpBottomViewConstraints(){
        logOutBtn.translatesAutoresizingMaskIntoConstraints = false
        logOutBtn.leadingAnchor.constraint(equalTo: self.bottomView.leadingAnchor, constant: 20).isActive = true
        
        logOutBtn.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 15).isActive = true
        logOutBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.leadingAnchor.constraint(equalTo: self.bottomView.leadingAnchor, constant: 20).isActive = true
        nameLbl.trailingAnchor.constraint(equalTo: self.imageview.leadingAnchor, constant: -20).isActive = true
        nameLbl.bottomAnchor.constraint(equalTo: self.bottomView.bottomAnchor, constant: -15).isActive = true
        nameLbl.topAnchor.constraint(equalTo: self.logOutBtn.bottomAnchor, constant: 0).isActive = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 20).isActive = true
        imageview.trailingAnchor.constraint(equalTo: self.bottomView.trailingAnchor, constant: -20).isActive = true
        imageview.bottomAnchor.constraint(equalTo: self.bottomView.bottomAnchor, constant: -20).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    func setUpSideBarViewConstraints(){
        toplabel.translatesAutoresizingMaskIntoConstraints = false
        toplabel.leadingAnchor.constraint(equalTo: self.sideBarView.leadingAnchor, constant: 0).isActive = true
        toplabel.trailingAnchor.constraint(equalTo: self.sideBarView.trailingAnchor, constant: 0).isActive = true
        toplabel.topAnchor.constraint(equalTo: self.sideBarView.topAnchor, constant: 0).isActive = true
        toplabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.sideBarView.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.sideBarView.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: self.toplabel.bottomAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 0).isActive = true
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leadingAnchor.constraint(equalTo: self.sideBarView.leadingAnchor, constant: 0).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.sideBarView.trailingAnchor, constant: 0).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: self.sideBarView.bottomAnchor, constant: 0).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    
    @objc func closeSideBarView(){
        print("tapGesture")
        self.view.addGestureRecognizer(swipeToRight)
        self.view.removeGestureRecognizer(swipetoLeft)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.sideBarView.frame = CGRect(x: -self.view.bounds.width/1.5, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
            
            for alpha in (0...5).reversed(){
                self.tempview.alpha = CGFloat(alpha/10)
            }
        }, completion: nil)
        isEnableSideBarView = false
    }
    
    
    @objc func swipedToLeft(){
        self.view.addGestureRecognizer(swipeToRight)
        self.view.removeGestureRecognizer(swipetoLeft)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.sideBarView.frame = CGRect(x: -self.view.bounds.width/1.5, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
            
            for alpha in (0...5).reversed(){
                self.tempview.alpha = CGFloat(alpha/10)
            }
            
        }, completion: nil)
        isEnableSideBarView = false
    }
    
    
    @objc func swipedToRight(){
        self.imageview.layer.cornerRadius = self.imageview.frame.size.height/2
        
        self.view.addGestureRecognizer(swipetoLeft)
        self.view.removeGestureRecognizer(swipeToRight)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.sideBarView.frame = CGRect(x: 0, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
            
            for alpha in (0...5){
                self.tempview.alpha = CGFloat(alpha/10)
            }
            self.tempview.alpha = 0.5
        }, completion: nil)
        isEnableSideBarView = true
    }
    
    
    @objc func menuBtnClick(){
        self.imageview.layer.cornerRadius = self.imageview.frame.size.height/2
        
        if isEnableSideBarView{
            self.view.addGestureRecognizer(swipeToRight)
            self.view.removeGestureRecognizer(swipetoLeft)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                self.sideBarView.frame = CGRect(x: -self.view.bounds.width/1.5, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
                
                for alpha in (0...5).reversed(){
                    self.tempview.alpha = CGFloat(alpha/10)
                }
                
            }, completion: nil)
            
            isEnableSideBarView = false
            
        }else{
            self.view.addGestureRecognizer(swipetoLeft)
            self.view.removeGestureRecognizer(swipeToRight)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                self.sideBarView.frame = CGRect(x: 0, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
                
                for alpha in (0...5){
                    self.tempview.alpha = CGFloat(alpha/10)
                }
                self.tempview.alpha = 0.5
            }, completion: nil)
            
            isEnableSideBarView = true
        }
    }
    
}




extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideBarCell", for: indexPath)as! SideBarTableViewCell
        cell.imagev.image = self.arrImages[indexPath.row]
        cell.lbl.text = self.arrData[indexPath.row]
        cell.lbl.tintColor = UIColor(named: "Color-1")
        cell.imagev.tintColor = UIColor(named: "Color")
        cell.contentView.backgroundColor = UIColor(named: "Color")
        cell.lbl.textColor = UIColor(named: "Color-1")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)as! SideBarTableViewCell
        
        switch indexPath.row {
        case 0:
            let dashboardVC = self.storyboard?.instantiateViewController(identifier: "dvc")as!SubjectVC
            self.navigationController?.pushViewController(dashboardVC, animated: true)
            
        case 1:
            let shortcutsVC = self.storyboard?.instantiateViewController(identifier: "svc")as! InstructorsVC
            self.navigationController?.pushViewController(shortcutsVC, animated: true)
        case 2:
            let overviewVC = self.storyboard?.instantiateViewController(identifier: "ovc")as! StudentsVC
            self.navigationController?.pushViewController(overviewVC, animated: true)
            
        default:
            print(self.arrData[indexPath.row])
            cell.imagev.tintColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
            cell.lbl.textColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
            cell.contentView.backgroundColor = UIColor.white
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)as! SideBarTableViewCell
        cell.imagev.tintColor = UIColor.white
        cell.lbl.textColor = UIColor.white
        cell.contentView.backgroundColor = UIColor(named: "Color")
    }
    
}
