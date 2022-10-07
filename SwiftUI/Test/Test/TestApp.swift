//
//  TestApp.swift
//  Test
//
//  Created by Ivan Pryhara on 18.09.22.
//

import SwiftUI


//MARK: Creating APNs files

@main
struct TestApp: App {
    //MARK: Linking App Delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    //MARK: All notifications
    @State var notifications: [NotificationValue] = []
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(alignment: .top) {
                    GeometryReader { proxy in
                        let size = proxy.size
                        ForEach(notifications) { notification in
                            NotificationPreview(size: size, value: notification, notifications: $notifications)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                            
                        }
                    }
                    .ignoresSafeArea()
                }
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("NOTIFY"))) { output in
                    if let content = output.userInfo?["content"] as? UNNotificationContent {
                        //MARK: Creating new notifcation
                        let newNotification = NotificationValue(content: content)
                        notifications.append(newNotification)
                    }
                }
        }
    }
}

//MARK: Creating custom notification view
struct NotificationPreview: View {
    var size: CGSize
    var value: NotificationValue
    
    @Binding  var notifications: [NotificationValue]
    var body: some View {
        HStack{
           //MARK: UI
            if let image = UIImage(named: "AppIcon60x60") {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(value.content.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Text(value.content.body)
                    .foregroundColor(.gray)
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(10)
        .padding(.horizontal, 12)
        .padding(.vertical, 18)
        .blur(radius: value.showNotification ? 0 : 30)
        .opacity(value.showNotification ? 1 : 0)
        .scaleEffect(value.showNotification ? 1: 0.5, anchor: .top)
        .frame(width: value.showNotification ? size.width - 22 : 126, height: value.showNotification ? 100 : 37.33)
        .background {
            // Radius = 126/2 = 63
            RoundedRectangle(cornerRadius: value.showNotification ? 50 : 63, style: .continuous)
                .fill(.black)
        }
        .offset(y: 11)
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: value.showNotification)
        //MARK: Auto close after some time
        //Then removing notification from the array
        .onChange(of: value.showNotification, perform: { newValue in
            if newValue &&  notifications.indices.contains(index) {
                // You can set what ever value where 2.8
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                    notifications[index].showNotification = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        notifications.remove(at: index)
                    }
                }
            }
        })
        .onAppear {
            //MARK: Animating when a new notification is added
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                notifications[index].showNotification = true
            }
        }
    }
    // MARK: Index
    var index: Int {
        return notifications.firstIndex { CValue in
            CValue.id == value.id
        } ?? 0
    }
}

//MARK: App Delegate to Listen for In App Notificaitons
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        if UIApplication.shared.haveDynamicIsland {
            //MARK: Do animation
            //MARK: Observing Notifications
            NotificationCenter.default.post(name: NSNotification.Name("NOTIFY"), object: nil, userInfo: ["content" : notification.request.content])
            return [.sound]
        } else {
            //MARK: Normal Notification
            return [.sound, .badge, .banner ]
        }
    }
}

extension UIApplication {
    
    var haveDynamicIsland: Bool {
        return deviceName == "iPhone 14 Pro" || deviceName == "iPhone 14 Pro Max"
    }
    
    var deviceName: String {
        return UIDevice.current.name
    }
}
