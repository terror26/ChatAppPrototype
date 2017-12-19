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

class ChatVC:JSQMessagesViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    private var messages = [JSQMessage]()
    
    let picker = UIImagePickerController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
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
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        
        let msg = messages[indexPath.item];
        if msg.isMediaMessage {
            if let mediaItem = msg.media as?JSQVideoMediaItem {
                let player = AVPlayer(url: mediaItem.fileURL)
                let playerController = AVPlayerViewController();
                playerController.player = player
                self.present(playerController, animated: true, completion: nil)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as!JSQMessagesCollectionViewCell
        return cell
    
    }
    
    //ENd COLLECTIONS VIEW FUNCTIONS
    
    // SENDING BUTTON FUNCTIONS
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName,text: text));
        collectionView.reloadData()
        //this will remoce the text from the text field
        finishSendingMessage();
        
    }
 
    override func didPressAccessoryButton(_ sender: UIButton!) {
        
        let alert = UIAlertController(title: "Media Messages", message: "Please Select a Media", preferredStyle: .actionSheet)
        
        let cancel  = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let photos = UIAlertAction(title: "Photos", style: .default,handler: { (alert :UIAlertAction) in
            self.chooseMedia(type: kUTTypeImage)
        })
        
        let videos = UIAlertAction(title: "Videos", style: .default,handler: { (alert :UIAlertAction) in
            self.chooseMedia(type: kUTTypeMovie)
            
        })
        
        
        alert.addAction(photos);
        alert.addAction(videos);
        alert.addAction(cancel);
        present(alert, animated: true, completion: nil)
        
    }
    
    //END SENDING BUTTON FUNCTIONS

    //PICKER VIEW FUNCTIONS
    
    private func chooseMedia(type:CFString) {
        
        picker.mediaTypes = [type as String]
        present(picker, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pic = info[UIImagePickerControllerOriginalImage] as?UIImage {
        
            let img = JSQPhotoMediaItem(image: pic);
            self.messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: img))
        
        } else if let vid = info[UIImagePickerControllerMediaURL] as?URL {
            
            let video = JSQVideoMediaItem(fileURL: vid, isReadyToPlay: true)
            messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, media: video))
            
        }
        
        self.picker.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
        
    }
    //END PICKER VIEW FUNCTIONS
    
    @IBAction func BackBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    
    }
    
}
