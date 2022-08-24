//
//  FileManager.swift
//  TrendMedia
//
//  Created by Y on 2022/08/24.
//

import UIKit

extension UIViewController{
    //메인화면 저장된 이미지 출력
    func loadImageFromDocument(fileName: String) -> UIImage?{
        // 앱의 document 경로
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        // 세부 파일 경로, 이미지 저장할 위치
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        // 파일 존재 여부 확인
        if FileManager.default.fileExists(atPath: fileURL.path){
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star.fill")
        }
        
        //.path : url string 형태로 변환
//        let image = UIImage(contentsOfFile: fileURL.path)
        // 파일 변환
//        return image
    }
    
    func removeImageFromDocument(fileName: String){
        // 앱의 document 경로
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        // 세부 파일 경로, 이미지 저장할 위치
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error{
            print(error)
        }
    }
    
    //이미지 저장 메소드
    func saveImageToDocument(fileName: String, image: UIImage){
        // 앱의 document 경로
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        // 세부 파일 경로, 이미지 저장할 위치
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        // 용량 줄이기
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do{
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
}
