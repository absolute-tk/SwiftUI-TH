//
//  สวิฟต์ยูไอไทย.swift
//  รวมนามแฝงและ Components ตัวช่วยภาษาไทย
//


import SwiftUI

// MARK: - การกำหนดนามแฝงและ Types ภาษาไทย

typealias มุมมอง = View
typealias สี = Color
typealias หน่วยทศนิยม = CGFloat
typealias การจัดตำแหน่ง = Alignment
typealias การจัดแนวนอน = HorizontalAlignment
typealias การจัดแนวตั้ง = VerticalAlignment
typealias จำนวนเต็ม = Int

// นามแฝง Components ที่เป็น Leaf Nodes
typealias ข้อความ = Text // Text
typealias รูปภาพ = Image // Image
typealias ปุ่ม = Button // Button
typealias ตัวเว้นระยะ = Spacer // Spacer

// MARK: - คำจำกัดความของ Components โครงสร้าง ภาษาไทย (Thai Container Definitions)

// เรียงแนวตั้ง (VStack) Wrapper - ใช้ มุมมอง, หน่วยทศนิยม, การจัดแนวนอน
struct เรียงแนวตั้ง<Content: มุมมอง>: มุมมอง {
    
    private let เนื้อหา: Content // เปลี่ยน content เป็น เนื้อหา
    private let การจัดเรียง: การจัดแนวนอน
    private let ระยะห่าง: หน่วยทศนิยม?

    // เปลี่ยนชื่อพารามิเตอร์เพื่อให้เป็นภาษาไทย: การจัดเรียง (alignment), ระยะห่าง (spacing)
    init(การจัดเรียง: การจัดแนวนอน = .กลาง, ระยะห่าง: หน่วยทศนิยม? = nil, @ViewBuilder เนื้อหา: () -> Content) {
        self.การจัดเรียง = การจัดเรียง
        self.ระยะห่าง = ระยะห่าง
        self.เนื้อหา = เนื้อหา()
    }
    
    var body: some มุมมอง {
        VStack(alignment: การจัดเรียง, spacing: ระยะห่าง) {
            เนื้อหา
        }
    }
}

// เรียงแนวนอน (HStack) Wrapper
struct เรียงแนวนอน<Content: มุมมอง>: มุมมอง {
    
    private let เนื้อหา: Content
    private let การจัดเรียง: การจัดแนวตั้ง
    private let ระยะห่าง: หน่วยทศนิยม?

    init(การจัดเรียง: การจัดแนวตั้ง = .center, ระยะห่าง: หน่วยทศนิยม? = nil, @ViewBuilder เนื้อหา: () -> Content) {
        self.การจัดเรียง = การจัดเรียง
        self.ระยะห่าง = ระยะห่าง
        self.เนื้อหา = เนื้อหา()
    }
    
    var body: some มุมมอง {
        HStack(alignment: การจัดเรียง, spacing: ระยะห่าง) {
            เนื้อหา
        }
    }
}

// ซ้อนทับ (ZStack) Wrapper
struct ซ้อนทับ<Content: มุมมอง>: มุมมอง {
    
    private let เนื้อหา: Content
    private let การจัดเรียง: การจัดตำแหน่ง

    init(การจัดเรียง: การจัดตำแหน่ง = .กลาง, @ViewBuilder เนื้อหา: () -> Content) {
        self.การจัดเรียง = การจัดเรียง
        self.เนื้อหา = เนื้อหา()
    }
    
    var body: some มุมมอง {
        ZStack(alignment: การจัดเรียง) {
            เนื้อหา
        }
    }
}

// MARK: - Extension สำหรับ Modifier ภาษไทย

extension มุมมอง {
    
    // .padding(30.0) -> .ระยะขอบ(30.0)
    func ระยะขอบ(_ length: หน่วยทศนิยม) -> some มุมมอง {
        self.padding(length)
    }

    // .padding(.bottom, 20.0) -> .ระยะขอบ(.ล่าง, 20.0)
    func ระยะขอบ(_ edges: Edge.Set, _ length: หน่วยทศนิยม) -> some มุมมอง {
        self.padding(edges, length)
    }

    // .padding() -> .ระยะขอบ()
    func ระยะขอบ() -> some มุมมอง {
        self.padding()
    }
    
    // .frame() -> .กรอบ()
    func กรอบ(width: หน่วยทศนิยม? = nil, height: หน่วยทศนิยม? = nil) -> some มุมมอง {
        self.frame(width: width, height: height)
    }
    
    // .foregroundStyle() -> .สีด้านหน้า()
    func สีด้านหน้า<S: ShapeStyle>(_ style: S) -> some มุมมอง {
        self.foregroundStyle(style)
    }
    
    // .font() -> .รูปแบบอักษร()
    func รูปแบบอักษร(_ font: Font) -> some มุมมอง {
        self.font(font)
    }
    
    // .tint() -> .สีเน้น()
    func สีเน้น(_ color: สี) -> some มุมมอง {
        self.tint(color)
    }
    
    // .opacity() -> .ความทึบแสง()
    func ความทึบแสง(_ opacity: Double) -> some มุมมอง {
        self.opacity(opacity)
    }
    
    // Modifier สำหรับ ButtonStyle
    func ปุ่มสไตล์เน้นขอบเขต() -> some มุมมอง {
        self.buttonStyle(.borderedProminent)
    }
    
    func ปุ่มสไตล์ขอบเขต() -> some มุมมอง {
        self.buttonStyle(.bordered)
    }
}

// Extension สำหรับ Image Modifier
extension Image {
    
    // *** NEW: Initializer for Image(systemName:) -> รูปภาพ(ชื่อระบบ:) ***
    init(ชื่อระบบ: String) {
        self.init(systemName: ชื่อระบบ)
    }
    
    // .resizable() -> .ปรับขนาดได้()
    func ปรับขนาดได้() -> Image {
        self.resizable()
    }
}

// Extension สำหรับ Font Modifier
extension Font {
    // .system() -> .ระบบ()
    static func ระบบ(size: หน่วยทศนิยม, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        .system(size: size, weight: weight, design: design)
    }
}

// MARK: - นามแฝงสำหรับค่าคงที่ (Constants)

extension Edge.Set {
    static let ล่าง: Edge.Set = .bottom
}

extension Color {
    // กำหนดสีเป็น static var เพื่อให้เข้าถึงได้ด้วย สี.มิ้นท์
    static let มิ้นท์: สี = .mint
    static let รอง: สี = .secondary
    static let แดง: สี = .red
}

extension Font {
    // .caption -> .หัวข้อรอง
    static let หัวข้อรอง: Font = .caption
}

extension Font.Weight {
    static let หนา: Font.Weight = .bold
}

extension Font.Design {
    static let มน: Font.Design = .rounded
}

extension Alignment {
    static let กลาง: Alignment = .center
}

extension HorizontalAlignment {
    static let กลาง: HorizontalAlignment = .center
}
