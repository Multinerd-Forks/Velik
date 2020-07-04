//
//  GridShape.swift
//  Fietscomputer
//
//  Created by Grigory Avdyushin on 04/07/2020.
//  Copyright © 2020 Grigory Avdyushin. All rights reserved.
//

import SwiftUI

struct GridShape: Shape {

    let size: CGSize
    let position: Edge.Set

    private let axis: Axis

    init(values: [Double], size: CGSize, position: Edge.Set) {
        self.size = size
        self.position = position
        self.axis = Axis(
            minX: 0,
            maxX: CGFloat(max(1, values.count)),
            minY: CGFloat(values.min() ?? .zero),
            maxY: CGFloat(values.max() ?? .zero)
        )
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            if position.contains(.leading) {
                yAxis(path: &path, in: rect)
            }
            if position.contains(.bottom) {
                xAxis(path: &path, in: rect)
            }
        }
    }

    func chartRect(in rect: CGRect) -> CGRect {
        CGRect(
            x: rect.origin.x,
            y: rect.origin.y,
            width: rect.size.width - size.width,
            height: rect.size.height - size.height
        )
    }

    func convert(point: CGPoint, in rect: CGRect) -> CGPoint {
        axis.convert(point: point, in: chartRect(in: rect))
            .applying(.init(translationX: size.width, y: 0))
    }

    private func yAxis(path: inout Path, in rect: CGRect) {
        let height = rect.height - size.height
        for offset in stride(from: height, to: size.height, by: -height / 5) {
            let point = CGPoint(x: rect.origin.x + size.width / 2, y: offset)
            path.move(to: point)
            path.addLine(to: point.applying(.init(translationX: size.width / 2, y: 0)))
        }
    }

    private func xAxis(path: inout Path, in rect: CGRect) {
        let width = rect.width - size.width
        for offset in stride(from: size.width, to: width, by: width / 7) {
            let point = CGPoint(x: offset, y: rect.maxY - size.height / 2)
            path.move(to: point)
            path.addLine(to: point.applying(.init(translationX: 0, y: -size.height / 2)))
        }
    }
}