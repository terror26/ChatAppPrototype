//
//  ChatVC.swift
//  ChatApp
//
//  Created by Kanishk Verma on 18/12/17.
//  Copyright © 2017 Kanishk Verma. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import MobileCoreServices
import AVKit;

class ChatVC:JSQMessagesViewController {

    private var messages = [JSQMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = "1"
        self.senderDisplayName = "Car"
        // Do any additional setup after loading the view.
    }

    //COLLECTION VIEW FUNCTIONS
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory();
        // let message = messages[indexPath.item];
        return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.blue);
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "Profile"), diameter: 30)
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as!JSQMessagesCollectionViewCell
        return cell
    }
    
    //ENd COLLECTIONS VIEW FUNCTIONS
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName,text: text));
        collectionView.reloadData()
        //this will remoce the text from the text field
        finishSendingMessage();
    }
    
    
    @IBAction func BackBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
