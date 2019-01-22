//
//  ChatViewController.swift
//
//  Created by stefano vecchiati .
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit
import MessageKit
import MessageInputBar





class ChatViewController: MessagesViewController {
    
    var messages: [Msg] = []
    var albumId : String!
    let refreshControl = UIRefreshControl()
    
    /*
     init(withReference reference: ChatReference!) {
     super.init(nibName: nil, bundle: nil)
     self.reference = reference
     }
     
     required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
     }
     */
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    

    lazy var autocompleteManager: AutocompleteManager = { [unowned self] in
        let manager = AutocompleteManager(for: self.messageInputBar.inputTextView)
        manager.delegate = self
        manager.dataSource = self
        return manager
        }()
    
    let users = ["nathantannar4", "SD10"]
    
    let hastags = ["MessageKit", "MessageInputBar"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMessageCollectionView()

        loadFirstMessages()
        title = "Chat"
        
        autocompleteManager.register(prefix: "@", with: [.font: UIFont.preferredFont(forTextStyle: .body),.foregroundColor: UIColor(red: 0, green: 122/255, blue: 1, alpha: 1),.backgroundColor: UIColor(red: 0, green: 122/255, blue: 1, alpha: 0.1)])
        autocompleteManager.register(prefix: "#")
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear	(animated)
        FirebaseChatDatabase.listenerMessages(chanelID: albumId, directChat: false) { success in
            self.loadFirstMessages()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        FirebaseChatDatabase.removeMessageListener()
    }
    
    func loadFirstMessages() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.messages = []
                for message in Message.all2(withTopic: self.albumId){
                    do {
                        let text = try Cryptor.share.decryptMessage(encryptedMessage: message.messageText)
                        self.messages.append(Msg(text: text, sender: Sender(id: message.senderId, displayName: message.senderName), messageId: message.id, date: message.sentDate))
                    } catch {
                        self.messages.append(Msg(text: message.messageText, sender: Sender(id: message.senderId, displayName: message.senderName), messageId: message.id, date: message.sentDate))
                    }
                }
                
                self.messagesCollectionView.reloadData()
                self.messagesCollectionView.scrollToBottom()
            }
        }
    }
    
    //    @objc func loadMoreMessages() {
    //
    //        guard let id = reference?.chatId else {
    //            self.refreshControl.endRefreshing()
    //            return
    //
    //        }
    //
    //                DispatchQueue.main.async {
    //                    FirebaseChatDatabase.listenerMessages(chanelID: id, directChat: false) { success in
    //                        self.messages = []
    //                        for message in Message.all() {
    //                            self.messages.append(Msg(text: message.messageText, sender: Sender(id: message.senderId, displayName: message.senderName), messageId: message.id, date: message.sentDate))
    //                        }
    //                        self.messagesCollectionView.reloadDataAndKeepOffset()
    //                        self.refreshControl.endRefreshing()
    //                    }
    //
    //                }
    //
    //    }
    
    func configureMessageCollectionView() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self
        scrollsToBottomOnKeyboardBeginsEditing = true // default false
        maintainPositionOnKeyboardFrameChanged = true // default false
        //        messagesCollectionView.addSubview(refreshControl)
        //        refreshControl.addTarget(self, action: #selector(loadMoreMessages), for: .valueChanged)
    }
  
    
    // MARK: - Helpers
    func insertMessage(_ message: Msg) {
        messages.append(message)
        // Reload last section to update header/footer labels and insert a new one
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([messages.count - 1])
            if messages.count >= 2 {
                messagesCollectionView.reloadSections([messages.count - 2])
            }
        }, completion: { [weak self] _ in
            if self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToBottom(animated: true)
            }
        })
    }
    
    func isLastSectionVisible() -> Bool {
        guard !messages.isEmpty else { return false }
        let lastIndexPath = IndexPath(item: 0, section: messages.count - 1)
        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
    
    // MARK: - MessagesDataSource
}
extension ChatViewController: MessagesDataSource {
    func currentSender() -> Sender {
        if let id = NetworkManager.getMyID(), let name = User.getUserById(withid: id)?.name.first, let surname = User.getUserById(withid: id)?.surname.first {
            return Sender(id: id, displayName: "\(name)\(surname)")
        }
        
        return Sender(id: "ErrorID", displayName: "Error")
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if indexPath.section % 3 == 0 {
            return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        }
        return nil
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        //        let dateString = formatter.string(from: message.sentDate)
        //        return NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption2)])
        return nil
    }
}

// MARK: - MessageCellDelegate
extension ChatViewController: MessageCellDelegate {
    func didTapAvatar(in cell: MessageCollectionViewCell) {
        print("Avatar tapped")
    }
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
        print("Message tapped")
    }
    
    func didTapCellTopLabel(in cell: MessageCollectionViewCell) {
        print("Top cell label tapped")
    }
    
    func didTapMessageTopLabel(in cell: MessageCollectionViewCell) {
        print("Top message label tapped")
    }
    
    func didTapMessageBottomLabel(in cell: MessageCollectionViewCell) {
        print("Bottom label tapped")
    }
    
    func didTapAccessoryView(in cell: MessageCollectionViewCell) {
        print("Accessory view tapped")
    }
}

// MARK: - MessageLabelDelegate
extension ChatViewController: MessageLabelDelegate {
    func didSelectAddress(_ addressComponents: [String: String]) {
        print("Address Selected: \(addressComponents)")
    }
    
    func didSelectDate(_ date: Date) {
        print("Date Selected: \(date)")
    }
    
    func didSelectPhoneNumber(_ phoneNumber: String) {
        print("Phone Number Selected: \(phoneNumber)")
    }
    
    func didSelectURL(_ url: URL) {
        print("URL Selected: \(url)")
    }
    
    func didSelectTransitInformation(_ transitInformation: [String: String]) {
        print("TransitInformation Selected: \(transitInformation)")
    }
}

// MARK: - MessageInputBarDelegate
extension ChatViewController: MessageInputBarDelegate {
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        for component in inputBar.inputTextView.components {
            if let str = component as? String {
                let message = Message(id: UUID().uuidString,idAlbum: albumId, messageText: str, senderName: currentSender().displayName, senderId: currentSender().id, sentDate: Date())
                FirebaseChatDatabase.sendMessage(chanelID: albumId, directChat: false, message: message) { success in
                    if success {
                        do {
                            let text = try Cryptor.share.decryptMessage(encryptedMessage: message.messageText)
                            // self.insertMessage(Msg(text: text, sender: Sender(id: message.senderId, displayName: message.senderName), messageId: message.id, date: message.sentDate))
                            inputBar.inputTextView.text = String()
                            self.messagesCollectionView.scrollToBottom(animated: true)
                        } catch {
                            //self.insertMessage(Msg(text: message.messageText, sender: Sender(id: message.senderId, displayName: message.senderName), messageId: message.id, date: message.sentDate))
                            inputBar.inputTextView.text = String()
                            self.messagesCollectionView.scrollToBottom(animated: true)
                        }
                    }
                }
            } else if let img = component as? UIImage {
                //                let message = Message(image: img, sender: currentSender(), messageId: UUID().uuidString, date: Date())
                //                FirebaseChatDatabase.sendMessage(chanelID: id, directChat: false, message: message) { message in
                //                    if let message = message {
                //                        self.insertMessage(message)
                //                        inputBar.inputTextView.text = String()
                //                        self.messagesCollectionView.scrollToBottom(animated: true)
                //                    }
                //                }
            }
        }
    }
}

extension ChatViewController: AutocompleteManagerDelegate, AutocompleteManagerDataSource {
    
    // MARK: - AutocompleteManagerDataSource
    
    func autocompleteManager(_ manager: AutocompleteManager, autocompleteSourceFor prefix: String) -> [AutocompleteCompletion] {
        if prefix == "@" {
            return users.map { AutocompleteCompletion(text: $0) }
        } else if prefix == "#" {
            return hastags.map { AutocompleteCompletion(text: $0) }
        }
        return []
    }
    
    func autocompleteManager(_ manager: AutocompleteManager, tableView: UITableView, cellForRowAt indexPath: IndexPath, for session: AutocompleteSession) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AutocompleteCell.reuseIdentifier, for: indexPath) as? AutocompleteCell else {
            fatalError("Oops, some unknown error occurred")
        }
        cell.textLabel?.attributedText = manager.attributedText(matching: session, fontSize: 15)
        return cell
    }
    
    // MARK: - AutocompleteManagerDelegate
    
    func autocompleteManager(_ manager: AutocompleteManager, shouldBecomeVisible: Bool) {
        setAutocompleteManager(active: shouldBecomeVisible)
    }
    
    // Optional
    func autocompleteManager(_ manager: AutocompleteManager, shouldRegister prefix: String, at range: NSRange) -> Bool {
        return true
    }
    
    // Optional
    func autocompleteManager(_ manager: AutocompleteManager, shouldUnregister prefix: String) -> Bool {
        return true
    }
    
    // Optional
    func autocompleteManager(_ manager: AutocompleteManager, shouldComplete prefix: String, with text: String) -> Bool {
        return true
    }
    
    // MARK: - AutocompleteManagerDelegate Helper
    
    func setAutocompleteManager(active: Bool) {
        
        let topStackView = messageInputBar.topStackView
        if active && !topStackView.arrangedSubviews.contains(autocompleteManager.tableView) {
            topStackView.insertArrangedSubview(autocompleteManager.tableView, at: topStackView.arrangedSubviews.count)
            topStackView.layoutIfNeeded()
        } else if !active && topStackView.arrangedSubviews.contains(autocompleteManager.tableView) {
            topStackView.removeArrangedSubview(autocompleteManager.tableView)
            topStackView.layoutIfNeeded()
        }
    }
    
}

