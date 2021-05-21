//
//  NEXT.swift
//  UI-199
//
//  Created by にゃんにゃん丸 on 2021/05/20.
//

import SwiftUI
import AudioToolbox

struct NEXT: View {
    
    @State var offset : CGFloat = 0
    @State var next = false
    var body: some View {
        VStack{
            
            
            Image("p1")
                .resizable()
                .aspectRatio(contentMode: .fit)
               
                .clipShape(Circle())
            
            Spacer()
            
            
            Text("Height")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
            
            Text("\(SwithcWeight())")
                .font(.system(size: 38, weight: .bold))
                .foregroundColor(Color("bg2"))
                .padding(.bottom,20)
            
            let pickCount = 6
            
            
            CustomSlider(pickCount: pickCount, offset: $offset) {
                
                
                HStack(spacing:0){
                    
                    
                    ForEach(1...pickCount,id:\.self){index in
                        
                        
                        VStack{
                            
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 1, height: 30)
                                //.frame(width: 20)
                            
                            Text("\(130 + (index * 10))")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            
                        }
                        .frame(width: 20)
                        
                        ForEach(1...4,id:\.self){sub in
                            
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 1, height: 15)
                                .frame(width: 20)
                           
                            
                        }
                        
                        
                        
                        
                        
                    }
                    
                    
                    VStack{
                        
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 1, height: 30)
                           // .frame(width: 20)
                        
                        Text("\(200)")
                            .font(.system(size: 10))
                        
                           
                    }
                    .frame(width: 20)
                    
                    
                }
                
                
                
                
                
            }
            .frame(height: 50)
            
            .overlay(
            
            
            Rectangle()
                .fill(Color.gray)
                .frame(width: 1, height: 50)
                .offset(x: 0.8, y: -30)
            
            )
            .padding()
           
            
            Button(action: {
                
                next.toggle()
                
            }, label: {
                Text("Height")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .padding(.horizontal,50)
                    .background(Color("bg2"))
                    .clipShape(Capsule())
            })
            .padding(.top,20)
            .padding(.bottom,10)
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
        
          Circle()
        .fill(Color("bg1"))
            .scaleEffect(1.5)
            .offset(y: -getRect().height / 2.5)
        
        )
        .sheet(isPresented: $next, content: {
               Home()
        })
        
    }
    
    func SwithcWeight()->String{
        
          let start = 140
        
        let progress = offset / 20
        
        return ("\(start + Int(progress) * 2)")
        
        
    }
}
struct NEXT_Previews: PreviewProvider {
    static var previews: some View {
        NEXT()
    }
}

struct CustomSlider2<Content:View> : UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return CustomSlider2.Coordinator(parent: self)
    }
    
    
    var content : Content
    @Binding var offset : CGFloat
    var pickCount : Int
    
    init(pickCount : Int,offset : Binding<CGFloat>,@ViewBuilder content : @escaping () -> (Content)) {
        self.content = content()
        self._offset = offset
        self.pickCount = pickCount
    }
    
    
    func makeUIView(context: Context) -> UIScrollView {
        
        let view = UIScrollView()
        
        let SwiftUiView = UIHostingController(rootView: content).view!
        
        let width = CGFloat((pickCount * 5) * 20) + (getRect().width - 30)
        
        
        SwiftUiView.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        
        view.contentSize = SwiftUiView.frame.size
        
        view.addSubview(SwiftUiView)
        
        view.bounces = false
        view.showsHorizontalScrollIndicator = false
        
        view.delegate = context.coordinator
        
        
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
    class Coordinator : NSObject,UIScrollViewDelegate{
        
        var parent : CustomSlider2
        
        
        init(parent : CustomSlider2) {
            self.parent = parent
        }
        
        
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            
            
            let offset = scrollView.contentOffset.x
            
            let value = (offset / 20).rounded(.toNearestOrAwayFromZero)
            
            scrollView.setContentOffset(CGPoint(x: value*20, y: 0), animated: false)
            
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            AudioServicesPlayAlertSound(1157)
            
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            
            if !decelerate{
                
                
                let offset = scrollView.contentOffset.x
                
                let value = (offset / 20).rounded(.toNearestOrAwayFromZero)
                
                scrollView.setContentOffset(CGPoint(x: value*20, y: 0), animated: false)
                
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                AudioServicesPlayAlertSound(1157)
                
                
                
            }
            
        }
        
    }
    
}


