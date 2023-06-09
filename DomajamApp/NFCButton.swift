//
//  NFCButton.swift
//  DomajamApp
//
//  Created by 宮地篤士 on 2023/03/24.
//

import SwiftUI
import CoreNFC

struct NFCButton : UIViewRepresentable {
    @Binding var payload: NFCTagPayload?

    func makeUIView(context: UIViewRepresentableContext<NFCButton>) -> UIButton {
        let button = UIButton()
        button.configuration = nil
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.setTitle("タグを読み取る", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(context.coordinator, action: #selector(context.coordinator.beginScan(_:)), for: .touchUpInside)
        return button
    }
    func updateUIView(_ uiView: UIButton, context: UIViewRepresentableContext<NFCButton>) {

    }
    func makeCoordinator() -> NFCButton.Coordinator {
        return Coordinator(payload: $payload)
    }

    class Coordinator : NSObject, NFCNDEFReaderSessionDelegate {
        var session : NFCReaderSession?
        @Binding var payload: NFCTagPayload?

        init(payload: Binding<NFCTagPayload?>) {
            _payload = payload
        }

        @objc func beginScan(_ sender: Any) {
            guard NFCNDEFReaderSession.readingAvailable else {
                print("このタグは読み込む事ができません")
                return
            }

            session = NFCNDEFReaderSession(delegate: self, queue: .main, invalidateAfterFirstRead: true)
            session?.alertMessage = "スキャンします。 iPhoneを近づけて下さい"
            session?.begin()
        }


        func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
            if let readerError = error as? NFCReaderError{

                if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                    && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                    print("読み込みできませんでした")
                }
            }

            self.session = nil

        }

        func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
            guard
                let nfcMess = messages.first,
                let record = nfcMess.records.first,
                record.typeNameFormat == .absoluteURI || record.typeNameFormat == .nfcWellKnown,
                let payload = record.wellKnownTypeTextPayload().0,
                let p = NFCTagPayload(rawValue: payload)
            else {
                return
            }
            self.payload = p
        }
    }
}
