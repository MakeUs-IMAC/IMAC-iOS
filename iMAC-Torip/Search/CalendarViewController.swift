//
//  CalendarViewController.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/21.
//

import UIKit
import FSCalendar
import SnapKit
import RxSwift

class CalendarViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nextButton: UIButton!
    var monthList = [Int]()
    var count = 0
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        let month = currentMonth()
        stackView.axis = .vertical
        stackView.spacing = 20
        for i in month..<12 {
            let calendarView: FSCalendar = {
                let view = FSCalendar()
                view.scrollDirection = .vertical
                view.scrollEnabled = false
                view.delegate = self
                view.swipeToChooseGesture.isEnabled = true
                // TO DO
                view.today = nil
                view.appearance.selectionColor = .red
                view.allowsMultipleSelection = true
                return view
            }()
            let setMonth = Calendar.current.date(byAdding: .month, value: i - month, to: calendarView.currentPage)!
            calendarView.setCurrentPage(setMonth, animated: true)
            calendarView.snp.updateConstraints { make in
                make.height.equalTo(230)
            }
            stackView.addArrangedSubview(calendarView)
            
        }
    }
    
    func currentMonth() -> Int {
        let date = Date()
        let month = Calendar.current.component(.month, from: date)
        return month
    }
    
    func bindViewModel() {
        nextButton.rx.tap
            .subscribe(onNext: { _ in
                self.navigateToDetailVC()
            }).disposed(by: disposeBag)
    }

}

extension CalendarViewController {
    func navigateToDetailVC() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.sectionCount = count
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CalendarViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {//달력 일정 날짜 선택했을 때
        //달력 하나만 선책 가능하게 하기
        let month = Calendar.current.component(.month, from: date)
        if monthList.isEmpty {
            monthList.append(Calendar.current.component(.month, from: date))
        }else {
            if !monthList.contains(month) {
                calendar.deselect(date)
            }
        }
    
           if calendar.selectedDates.count > 2{
               for _ in 0 ..< calendar.selectedDates.count - 1{
                   calendar.deselect(calendar.selectedDates[0])
               }
           }
           
           var startTemp: Date!
           if calendar.selectedDates.count == 2{
               if calendar.selectedDates[0] < calendar.selectedDates[1]{
                   startTemp = calendar.selectedDates[0]
                   while startTemp < calendar.selectedDates[1]-86400{
                       startTemp += 86400
                       calendar.select(startTemp)
                   }
                   startTemp = nil
               }
               else{
                   startTemp = calendar.selectedDates[1]
                   while startTemp < calendar.selectedDates[0] - 86400{
                       startTemp += 86400
                       calendar.select(startTemp)
                   }
               }
           }
        
        count = calendar.selectedDates.count
        print("count \(count)")
       }
       
       func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) { //선택날짜 한번 더 누를 때
           let month = Calendar.current.component(.month, from: date)
           if monthList.contains(month) {
               for (idx, i) in monthList.enumerated() {
                   if i == month {
                       monthList.remove(at: idx)
                   }
               }
           }
           for _ in 0 ..< calendar.selectedDates.count {
               calendar.deselect(calendar.selectedDates[0])
           }
           calendar.select(date)
       }


}
