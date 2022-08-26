//
//  BackupRestoreViewController.swift
//  TrendMedia
//
//  Created by Y on 2022/08/25.
//

import UIKit

import Zip

class BackupRestoreViewController: UIViewController{
    var mainView = BackupRestoreView()
    
    let dateformat: DateFormatter = {
          let formatter = DateFormatter()
           formatter.dateFormat = "yyyy.MM.dd.HH:mm:ss"
           return formatter
    }()
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        /// progress 배경 색상
        view.trackTintColor = .lightGray
        /// progress 진행 색상
        view.progressTintColor = .systemBlue
        view.progress = 0.1
        return view
    }()
    
    var backupFiles: [String] = []
    var tagId: Int = 0
    
    override func loadView() {
        super.loadView()
        self.view = mainView
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.reloadData()
        
        mainView.backupButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        mainView.restroeButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        mainView.tableView.reloadData()
    }
  
    @objc func backupButtonTapped(){
        var urlPaths = [URL]()
        
        guard let path = documentDirectoryPath() else {
            showAlert(title: "도큐먼트 경로 에러")
            return
        }
        let realmFile = path.appendingPathComponent("default.realm")
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            showAlert(title: "렘 파일 에러")
            return
        }
        urlPaths.append(URL(string: realmFile.path)!)
        
        do{
            let date = dateformat.string(from: Date())
//            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "다이어리 백업 \(date)", progress: { progress in
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "diary_bak", progress: { progress in
//                self.mainView.addSubview(self.progressView)
//                self.backupFiles.append(date)
//                print(self.backupFiles)
//                self.showActivityViewController(date: date)
                self.showActivityViewController()
                
            })
        } catch{
            showAlert(title: "압축 실패")
        }
    }
    
//    func showActivityViewController(date: String){
    func showActivityViewController(){
        guard let path = documentDirectoryPath() else {
            showAlert(title: "도큐먼트 경로 에러")
            return
        }
//        let backupFileURL = path.appendingPathComponent("\(date).zip")
        let backupFileURL = path.appendingPathComponent("diary_bak.zip")
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    @objc func restoreButtonTapped(){
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }
}
extension BackupRestoreViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return backupFiles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackupRestoreTableViewCell.reuseIdentifier, for: indexPath) as? BackupRestoreTableViewCell else { return UITableViewCell()}
        cell.titleLabel.text = "\(backupFiles[indexPath.row])"
        cell.backgroundColor = .white
        cell.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tagId = indexPath.row
    }
    
    
    
}

extension BackupRestoreViewController: UIDocumentPickerDelegate{
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        showAlert(title: "취소했습니다.")
    }
    
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL], tag: Int) {
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectdFileURL = urls.first else {
            showAlert(title: "선택 파일을 찾을 수 없습니다.")
            return
        }
        guard let path = documentDirectoryPath() else {
            showAlert(title: "도큐먼트 경로 오류")
            return
        }
        let sandboxFileURL = path.appendingPathComponent(selectdFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
//            let fileURL = path.appendingPathComponent("\(backupFiles[tag])")
            let fileURL = path.appendingPathComponent("diary_bak.zip")
            
            do{
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
//                    self.mainView.addSubview(self.progressView)
                }, fileOutputHandler: { unzippedFile in
                    self.showAlert(title: "복구가 완로되었습니다.")
                    
//                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
//
//                    let viewController = ShoppingTableViewController()
//                    sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: viewController)
//                    sceneDelegate?.window?.makeKeyAndVisible()
                })
            }catch{
                showAlert(title: "압축해제에 실패했습니다.")
            }
        } else {
            do {
                try FileManager.default.copyItem(at: selectdFileURL, to: sandboxFileURL)
                
//                let fileURL = path.appendingPathComponent("\(backupFiles[tag])")
                let fileURL = path.appendingPathComponent("diary_bak.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
//                    self.mainView.addSubview(self.progressView)
                }, fileOutputHandler: { unzippedFile in
                    self.showAlert(title: "복구가 완로되었습니다.")
                    
//                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
//
//                    let viewController = ShoppingTableViewController()
//                    sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: viewController)
//                    sceneDelegate?.window?.makeKeyAndVisible()
                })
                
            } catch{
                showAlert(title: "압축 해제에 실패했습니다.")
            }
        }
    }
}
