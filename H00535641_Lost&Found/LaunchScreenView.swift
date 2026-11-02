
import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {

            // background
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 12) {
                // Logo image from Assets
                Image("AppLogo")
                    .resizable()
                    .frame(width: 110, height: 110)
                    .cornerRadius(25)

                // app name
                Text("Lost & Found")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.12))

                Text("HCT Sharjah Campus")
                    .font(.system(size: 15))
                    .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.58))
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
