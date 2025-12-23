import SwiftUI

struct MyCustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Example: Drawing a simple triangle
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()

        return path
    }
}

struct SimpleCardShape: Shape {
    let cornerRadius: CGFloat
    let tailHeight: CGFloat
    let centerWidth: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let centerHeight: CGFloat = 100
        let centerRect = CGRect(
            x: (rect.width - centerWidth) / 2,
            y: rect.midY - centerHeight / 2,
            width: centerWidth,
            height: centerHeight
        )
        
        // Центральная закругленная часть
        path.addRoundedRect(
            in: centerRect,
            cornerSize: CGSize(width: cornerRadius, height: cornerRadius)
        )
        
        // Левый "хвостик"
        let leftTailRect = CGRect(
            x: 0,
            y: rect.midY - tailHeight / 2,
            width: centerRect.minX,
            height: tailHeight
        )
        path.addRect(leftTailRect)
        
        // Правый "хвостик"
        let rightTailRect = CGRect(
            x: centerRect.maxX,
            y: rect.midY - tailHeight / 2,
            width: rect.width - centerRect.maxX,
            height: tailHeight
        )
        path.addRect(rightTailRect)
        
        return path
    }
}


struct ContentView: View {
    var body: some View {
        MyCustomShape()
            .stroke(Color.blue, lineWidth: 5) // Adds a blue border with a width of 5
            .frame(width: 200, height: 200) // Set a frame for the shape
            .foregroundColor(.green) // Fill the shape with green
    }
}

#Preview {
    SimpleCardShape(cornerRadius: 60, tailHeight: 30, centerWidth: 300)
}
