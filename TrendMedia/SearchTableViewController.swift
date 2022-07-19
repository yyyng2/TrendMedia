//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by Y on 2022/07/19.
//

import UIKit

struct Movie {
    let poster: UIImage?
    let title: String?
    let date: String?
    let story: String?
}

class SearchTableViewController: UITableViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    var movie = [
        Movie(poster: UIImage(named: "oneday.jpeg"), title: "원데이", date: "2012. 12. 13", story: #"“내일이 어떻게 되든 오늘은 함께 있잖아” 현실의 벽에 부딪혀도 작가의 꿈을 놓지 않는 ‘엠마’ 그저 세상을 즐기며 살고 싶은 ‘덱스터’                7월 15일, 대학교 졸업식 날 처음 만난 두 사람. 사랑과 우정 사이를 맴돌며 함께 만들어낸 스무 번의 특별한 하루! 다시 시작될 그날, 우리의 기념일"#),
        Movie(poster: UIImage(named: "vanillasky.jpeg"), title: "바닐라스카이", date: "2001. 12. 21", story: "남다른 매력과 탄탄한 재력으로 수많은 여성들의 시선을 한 몸에 받는 데이빗 에임즈. 그는 유력 출판사와 잡지사를 운영하는 와중에 줄리라는 여자를 만나지만 그녀는 단지 섹스 파트너일 뿐이다. 그러던 어느날 데이빗은 자신의 생일 파티에 온 친구 브라이언의 애인 소피아를 보고 한눈에 반한다. 그녀가 바로 자신이 꿈에 그리던 운명의 상대임을 직감하는 데이빗. 소피아 역시 그에게 이끌려 둘은 뜨거운 연인 사이가 된다. 하지만 데이빗에게 버림받은 줄리는 질투와 분노에 사로잡혀 이들을 미행하고, 마침내 데이빗과의 동반자살을 시도한다. 사고 이후 데이빗은 간신히 목숨을 건지지만 자기 얼굴이 알아볼 수 없게 망가진 것을 알고 괴로워한다."),
        Movie(poster: UIImage(named: "grandbudapesthotel.jpeg") , title: "그랜드 부다페스트 호텔", date: "2014. 03. 20", story: "1927년 세계대전이 한창이던 어느 날, 세계 최고의 부호 마담 D.가 의문의 살인을 당한다. 유력한 용의자로 지목된 사람은 바로 전설적인 호텔 지배인이자 그녀의 연인 ‘구스타브’! 구스타브는 누명을 벗기 위해 충실한 로비보이 ‘제로’에게 도움을 청하고, 그 사이 구스타브에게 남겨진 마담 D.의 유산을 노리던 그녀의 아들 ‘드미트리’는 무자비한 킬러를 고용해 [그랜드 부다페스트 호텔]을 찾게 되는데…"),
        Movie(poster: UIImage(named: "tenet.jpeg"), title: "테넷", date: "2020. 08. 26", story: "시간의 흐름을 뒤집는 인버전을 통해 현재와 미래를 오가며 세상을 파괴하려는 사토르(케네스 브래너)를 막기 위해 투입된 작전의 주도자(존 데이비드 워싱턴). 인버전에 대한 정보를 가진 닐(로버트 패틴슨)과 미술품 감정사이자 사토르에 대한 복수심이 가득한 그의 아내 캣(엘리자베스 데비키)과 협력해 미래의 공격에 맞서 제3차 세계대전을 막아야 한다!"),
        Movie(poster: UIImage(named: "interstellar.jpeg"), title: "인터스텔라", date: "2014. 11. 06", story: "세계 각국의 정부와 경제가 완전히 붕괴된 미래가 다가온다. 지난 20세기에 범한 잘못이 전 세계적인 식량 부족을 불러왔고, NASA도 해체되었다. 이때 시공간에 불가사의한 틈이 열리고, 남은 자들에게는 이 곳을 탐험해 인류를 구해야 하는 임무가 지워진다. 사랑하는 가족들을 뒤로 한 채 인류라는 더 큰 가족을 위해, 그들은 이제 희망을 찾아 우주로 간다. 그리고 우린 답을 찾을 것이다. 늘 그랬듯이…")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.backgroundColor = .darkGray
        searchTextField.backgroundColor = .lightGray
        searchTextField.clipsToBounds = true
        searchTextField.layer.cornerRadius = 6
        clearButton.setTitle("", for: .normal)
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.tintColor = .systemGray6
        closeButton.setTitle("", for: .normal)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .white
       
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        cell.backgroundColor = .black
        cell.movieName.text = movie[indexPath.row].title
        cell.movieName.textColor = .white
        cell.movieName.font = .systemFont(ofSize: 16)
        cell.movieDate.text = movie[indexPath.row].date
        cell.movieDate.textColor = .white
        cell.movieDate.font = .systemFont(ofSize: 14)
        cell.story.text = movie[indexPath.row].story
        cell.story.textColor = .systemGray3
        cell.story.font = .systemFont(ofSize: 14)
        cell.story.numberOfLines = 3
        cell.cellImageView.image = movie[indexPath.row].poster
       
        
        
        return cell
    }

}
