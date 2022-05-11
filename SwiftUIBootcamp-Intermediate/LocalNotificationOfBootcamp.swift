//
//  LocalNotificationOfBootcamp.swift
//  SwiftUIBootcamp-Intermediate
//
//  Created by MEWO on 11.05.2022.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager{
    static let instance = NotificationManager() //singleton
    
    func requestAuthorization(){
        let options : UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }else{
                print("success")
            }
        }
    }
    func scheduleNotification(){
        let content = UNMutableNotificationContent()
        content.title = "this is the notification"
        content.subtitle = "the first one"
        content.sound = .defaultCritical
        content.badge = 1
        
        //time
        
            //       let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

       //calender
        
            //        var dateComponents = DateComponents()
            //        dateComponents.hour = 18
            //        dateComponents.minute = 15
            //        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
      //location
        let coordinate = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00)
        let region = CLCircularRegion(
            center: coordinate,
            radius: 100,
            identifier: UUID().uuidString)
        region.notifyOnExit = true
            region.notifyOnEntry = true
        let trigger = UNLocationNotificationTrigger(region: region, repeats: false)

        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        }
    func cancelNotifications(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    }


struct LocalNotificationOfBootcamp: View {
    var body: some View {
        VStack{
            Button("Request Authorization") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notification") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel Notifications") {
                NotificationManager.instance.cancelNotifications()
            }
        }.onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationOfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationOfBootcamp()
    }
}
