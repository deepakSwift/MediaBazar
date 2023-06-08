import UIKit
import Firebase
import IQKeyboardManagerSwift

class ChatLogController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        cv.register(ChatMessageCell.self, forCellWithReuseIdentifier: "collectionCell")
        cv.alwaysBounceVertical = true
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.white
        //        cv.makeRoundCorner(borderColor: .black, borderWidth: 2, cornerRadius: 25)
        cv.keyboardDismissMode = UIScrollView.KeyboardDismissMode.interactive
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        cv.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    var textViewHeight: NSLayoutConstraint!
    
    lazy var inputTextField: UITextView = {
        let textField = UITextView()
        //        textField.placeholder = "Write message"
        textField.delegate = self
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.textContainerInset = UIEdgeInsets(top: 10, left: 6, bottom: 8, right: 6)
        textField.font = UIFont.systemFont(ofSize: 14)
        //        textField.isScrollEnabled = false
        //        textField.borderStyle = UITextField.BorderStyle.line
        //        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 10
        //        textField.backgroundColor = .lightGray
        //        textField.layer.shadowRadius = 3.0
        //        textField.layer.shadowColor = UIColor.black.cgColor
        //        textField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        //        textField.layer.shadowOpacity = 1.0
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let sendButton = UIButton(type: .custom)
    let backButton = UIButton(type: .custom)
    
    let statusLabel = UILabel()
    
    var firstMessage = false
    var messageNode = ""
    
    let baseUrl = "https://apimediaprod.5wh.com/"
    
    var textArray: [Any] = ["A", "B", "C", "1"] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var messages = [Message]()
    
    var user: Users? {
        didSet {
            navigationItem.title = user?.receiverFirstName
            observeOnlineStatus()
            observeMessages()
        }
    }
    
    func observeMessages() {
        guard let toId = user?.receiverID, let uid = user?.senderID, let chatID = user?.chatID else {
            return
        }
        
        let messageIdRef = Database.database().reference().child("chat").child("users").child(chatID)
        messageIdRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let messageKey = snapshot.value as? String else {
                self.firstMessage = true
                return
            }
            self.firstMessage = false
            self.messageNode = messageKey
            
            self.observerChildedAdded()
            
        }, withCancel: nil)
    }
    
    func observerChildedAdded() {
        let messagesRef = Database.database().reference().child("messages").child(self.messageNode)
        messagesRef.observe(.childAdded) { (snap) in
            let messageId = snap.key
            let messRef = Database.database().reference().child("messages").child(self.messageNode).child(messageId)
            messRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dictionary = snapshot.value as? [String: AnyObject] else {
                    return
                }
                
                let tempMessage = Message(dictionary: dictionary)
                self.messages.append(tempMessage)
                DispatchQueue.main.async(execute: {
                    self.collectionView.reloadData()
                    //                        scroll to the last index
                    let indexPath = IndexPath(item: self.messages.count - 1, section: 0)
                    self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                })
                
            }, withCancel: nil)
        }
    }
    
    func observeOnlineStatus() {
        let statusOnceRef = Database.database().reference().child("users").child((user?.receiverID)!)
        statusOnceRef.observeSingleEvent(of: .value) { (snapshot) in
            if let values = snapshot.value as? [String : AnyObject], let userStatus = values["status"] as? String {
                self.statusLabel.text = userStatus.capitalized
            }
        }
        
        let statusRef = Database.database().reference().child("users").child((user?.receiverID)!)
        statusRef.observe(.childChanged) { (snap) in
            if let values = snap.value as? String {
                self.statusLabel.text = values.capitalized
            }
        }
    }
    
    var currentUserLogin: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentUserLogin = User.loadSavedUser()
        
        self.view.addSubview(collectionView)
        self.view.addSubview(topBar)
        setupContraints()
        setupKeyboardObservers()
        setupSwipeGesture()
        
        self.tabBarController?.tabBar.isHidden = true
        IQKeyboardManager.shared.enable = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        IQKeyboardManager.shared.enable = true
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func setupSwipeGesture() {
        let leftRecognizer = UISwipeGestureRecognizer(target: self, action:
            #selector(swipeMade(_:)))
        leftRecognizer.direction = .right
        view.addGestureRecognizer(leftRecognizer)
    }
    
    @objc func swipeMade(_ sender: UISwipeGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    lazy var topBar: UIView = {
        let tb = UIView()
        tb.backgroundColor = UIColor.white
        //        tb.backgroundColor = UIColor(rgb: 0x1a1a1a)
        //        tb.addBottomBorders()
        tb.translatesAutoresizingMaskIntoConstraints = false
        
        //        backButton.setTitle("Back", for: .normal)
        backButton.setImage(UIImage(named: "icons-back"), for: [])
        backButton.backgroundColor = .clear
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        //        backButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        //what is handleSend?
        
        tb.addSubview(backButton)
        //x,y,w,h
        backButton.leftAnchor.constraint(equalTo: tb.leftAnchor, constant: 5).isActive = true
        backButton.centerYAnchor.constraint(equalTo: tb.centerYAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor, multiplier: 1).isActive = true
        
        let nameLabel = UILabel()
        var fName = self.user?.receiverFirstName ?? ""
        var mName = self.user?.receiverMiddleName ?? ""
        var lName = self.user?.receiverLastName ?? ""
        fName = fName != "" ? fName + " " : ""
        mName = mName != "" ? mName + " " : ""
        nameLabel.text = fName + mName + lName
        let titleFont = UIFont(name: "Lato-Regular", size: 22)
        nameLabel.font = titleFont
        
        nameLabel.backgroundColor = UIColor.clear
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tb.addSubview(nameLabel)
        
        //        nameLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 5).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: tb.centerYAnchor, constant: 0).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: tb.centerXAnchor, constant: 0).isActive = true
        //        nameLabel.rightAnchor.constraint(equalTo: tb.rightAnchor, constant: -5).isActive = true
        
        //        let statusLabel = UILabel()
        //        statusLabel.text = "Online"
        let statusFont = UIFont(name: "Lato-Regular", size: 16)
        statusLabel.font = statusFont
        
        statusLabel.backgroundColor = UIColor.clear
        statusLabel.textColor = .black
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tb.addSubview(statusLabel)
        
        statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive = true
        //        statusLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 5).isActive = true
        //        statusLabel.centerYAnchor.constraint(equalTo: tb.centerYAnchor, constant: 0).isActive = true
        statusLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor, constant: 0).isActive = true
        //        statusLabel.rightAnchor.constraint(equalTo: tb.rightAnchor, constant: -5).isActive = true
        
        return tb
    }()
    
    lazy var testingViewContainer: UIView = {
        let testingView = UIView()
        testingView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        testingView.autoresizingMask = .flexibleHeight
        testingView.backgroundColor = UIColor.white
        //        let uploadImageView = UIImageView()
        //        uploadImageView.image = UIImage(named: "upload_image_icon")
        //        uploadImageView.isUserInteractionEnabled = false
        //        uploadImageView.translatesAutoresizingMaskIntoConstraints = false
        //        uploadImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleUploadTap)))
        //        uploadImageView.isHidden = true
        
        //        testingView.addSubview(uploadImageView)
        //
        //        uploadImageView.leftAnchor.constraint(equalTo: testingView.leftAnchor).isActive = true
        //        uploadImageView.centerYAnchor.constraint(equalTo: testingView.centerYAnchor).isActive = true
        //        uploadImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        //        uploadImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        //        sendButton.setTitle("Send", for: .normal)
        sendButton.setImage(UIImage(named: "Mask Group 9"), for: [])
        sendButton.setBackgroundImage(UIImage(named: "Ellipse 15"), for: [])
        //        sendButton.contentEdgeInsets = UIEdgeInsets(top: 17, left: 15, bottom: 17, right: 15)
        //        sendButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //        sendButton.backgroundColor =  UIColor(rgb: 0x459316)
        sendButton.addTarget(self, action: #selector(handleSendButton), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        //what is handleSend?
        
        testingView.addSubview(sendButton)
        //x,y,w,h
        sendButton.rightAnchor.constraint(equalTo: testingView.rightAnchor, constant: -8).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: testingView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sendButton.heightAnchor.constraint(equalTo: sendButton.widthAnchor).isActive = true
        
        testingView.addSubview(self.inputTextField)
        //x,y,w,h
        self.inputTextField.leftAnchor.constraint(equalTo: testingView.leftAnchor, constant: 8).isActive = true
        //        self.inputTextField.centerYAnchor.constraint(equalTo: testingView.centerYAnchor).isActive = true
        self.inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant:  -16).isActive = true
        //        self.inputTextField.topAnchor.constraint(equalTo: testingView.topAnchor, constant: 10).isActive = true
        self.inputTextField.bottomAnchor.constraint(equalTo: testingView.bottomAnchor, constant: -10).isActive = true
        textViewHeight = self.inputTextField.heightAnchor.constraint(equalToConstant: 34)
        textViewHeight.isActive = true
        //        self.inputTextField.heightAnchor.constraint(equalToConstant: testingView.bounds.height - 20).isActive = true
        
        //        let separatorLineView = UIView()
        //        separatorLineView.backgroundColor = UIColor(rgb: 0xbcd9ce)
        //        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        //        testingView.addSubview(separatorLineView)
        //        //x,y,w,h
        //        separatorLineView.leftAnchor.constraint(equalTo: testingView.leftAnchor).isActive = true
        //        separatorLineView.topAnchor.constraint(equalTo: testingView.topAnchor).isActive = true
        //        separatorLineView.widthAnchor.constraint(equalTo: testingView.widthAnchor).isActive = true
        //        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        return testingView
    }()
    
    @objc func handleUploadTap() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        //        imagePickerController.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
        present(imagePickerController, animated: true, completion: nil)
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return testingViewContainer
        }
    }
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    // Function for when device rotate
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //MARK: To hide inputAccessoryView view in image picker view. Took a lot fo time. phew
        //        self.inputAccessoryView?.removeFromSuperview()
        self.inputAccessoryView?.isHidden = true
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.inputAccessoryView?.isHidden = false
    }
    
    fileprivate func setupContraints() {
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 2).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        //        topBar.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 79).isActive = true
    }
    
    var containerViewBottomAnchor: NSLayoutConstraint?
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        print(keyboardDuration)
        print(keyboardFrame.height)
        //        containerViewBottomAnchor?.constant = -keyboardFrame.height
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        UIView.animate(withDuration: keyboardDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //        self.containerViewBottomAnchor?.constant = 0
        UIView.animate(withDuration: keyboardDuration) {
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleSendButton() {
        guard inputTextField.text != "" else { return }
        
        var ref = Database.database().reference().child("messages")
        if firstMessage {
            ref = Database.database().reference().child("messages").childByAutoId()
            guard let chatID = user?.chatID, let nodeKey = ref.key else {
                return
            }
            let messageIdRef = Database.database().reference().child("chat").child("users")
            messageIdRef.updateChildValues([chatID: nodeKey])
            self.messageNode = nodeKey
            self.firstMessage = false
            self.observeMessages()
        } else {
            ref = Database.database().reference().child("messages").child(self.messageNode)
        }
        
        let childRef = ref.childByAutoId()
        let toID = user!.receiverID!
        let fromID = user!.senderID!
        let timestamp = ServerValue.timestamp()
        
        let values: [String: Any] = ["message" : inputTextField.text!, "toId": toID, "fromId": fromID, "timestamp": timestamp, "mediaUrl": "", "messageType" : "text"]
        
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            
            if self.user?.senderUserType == "journalist"{
                self.chatInsertJournalist(mediaHouseID: toID, message: self.inputTextField.text, messageType: "text", haeder: self.currentUserLogin.token)
            }else if self.user?.senderUserType == "mediahouse"{
                self.chatInsertMediaHouse(journalistID: toID, message: self.inputTextField.text, messageType: "text", header: self.currentUserLogin.mediahouseToken)
            }
            
            
            
            //                self.chatInsert(senderId: fromID, recieverId: toID, postID: <#String#>, message: self.inputTextField.text ?? "")
            //                self.sendNotificationFromChat(userId: fromID, msg: self.inputTextField.text ?? "")
            
            self.inputTextField.text = nil
            
            //            guard let messageId = childRef.key else { return }
            //
            //            let userMessagesRef = Database.database().reference().child("user-messages").child(fromID).child(toID)
            //            userMessagesRef.updateChildValues([messageId: 1])
            //
            //            let recipientUserMessagesRef = Database.database().reference().child("user-messages").child(toID).child(fromID)
            //            recipientUserMessagesRef.updateChildValues([messageId: 1])
        }
    }
    
    func chatInsertJournalist(mediaHouseID : String, message : String, messageType : String, haeder : String){
        Webservices.sharedInstance.insertUserChat(mediaHouseID: mediaHouseID, message: message, messageType: messageType, header: haeder){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
            }else{
                
            }
        }
    }
    
    func chatInsertMediaHouse(journalistID : String,message : String, messageType : String, header : String){
        WebService3.sharedInstance.insertMediaChat(journalistID: journalistID, message: message, messageType: messageType, header: header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
            }else{
            }
        }
    }
    
    func chatInsert(senderId : String,recieverId : String,postID : String,message : String) {
        //        Webservice.sharedInstance.chatInsert(senderID: senderId, receiverID: recieverId, postID: postID, message: message){ (result, response ,messsage) in
        //            if result == 1 {
        //            } else {
        //
        //            }
        //        }
    }
    
    
    func sendNotificationFromChat(userId :String, msg : String){
        //        Webservice.sharedInstance.sendMessage(userId: userId, msg: msg){ (result, response ,messsage) in
        //            if result == 1 {
        //            } else {
        //
        //            }
        //        }
    }
    
    
    fileprivate func chatDelete(userID: String, postID: String, receiverID: String) {
        //        Webservice.sharedInstance.finishDeleteChat(userID: userID, postID: postID, receiverID: receiverID, type: "delete") { (result, message, data) in
        //            if result == 1 {
        //                self.navigationController?.popViewController(animated: true)
        //                print("chatDelete success ---- \(message)")
        //            } else {
        //                print("chatDelete failed ---- \(message)")
        //            }
        //        }
    }
    
}


// MARK:- UICollectionView extension
extension ChatLogController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of cell --- \(textArray.count)")
        return messages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! ChatMessageCell
        
        let message = messages[indexPath.item]
        cell.textView.text = message.message
        
        // handle time
        var timeText: String?
        if let seconds = message.timestamp?.doubleValue {
            let timestampDate = Date(timeIntervalSince1970: seconds/1000)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            timeText = dateFormatter.string(from: timestampDate)
            cell.timeLabel.text = timeText
        }
        
        setupCell(cell, message: message)
        
        //        cell.bubbleWidthAnchor?.constant = estimateFrameForText(text: message.text!).width + 32
        
        // handel bubble width, compare width between text and time, set bubble with according to whichever is big
        cell.bubbleWidthAnchor?.constant = (estimateFrameForText(text: message.message ?? "").width + 32) > (estimateFrameForText(text: timeText ?? "").width + 32) ? (estimateFrameForText(text: message.message ?? "").width + 32) : (estimateFrameForText(text: timeText ?? "").width + 32)
        
        //        let UpSwipe = UISwipeGestureRecognizer(target: self, action: #selector(someMethod(sender:)))
        //        UpSwipe.direction = UISwipeGestureRecognizer.Direction.left
        //        cell.addGestureRecognizer(UpSwipe)
        
        return cell
    }
    
    //    @objc func someMethod(sender: UISwipeGestureRecognizer) {
    //        let cell = sender.view as! UICollectionViewCell
    //        let itemIndex = self.collectionView.indexPath(for: cell)!.item
    //        messages.remove(at: itemIndex)
    //        self.collectionView.reloadData()
    //    }
    
    fileprivate func setupCell(_ cell: ChatMessageCell, message: Message) {
        //        if let senderImageUrl = self.user?.senderImage, senderImageUrl != "" {
        //        cell.profileImage2.sd_setImage(with: URL(string: self.user?.senderImage ?? ""), placeholderImage: UIImage(named: "default_profile"), completed: nil)            //            cell.profileImage.loadImageUsingCacheWithUrlString(senderImageUrl)
        //        }
        
        //        "\(self.baseUrl)\(receiverImageUrl)"
        
        if let receiverImageUrl = self.user?.receiverImage, receiverImageUrl != "" {
            cell.profileImage.sd_setImage(with: URL(string: "\(self.baseUrl)\(receiverImageUrl)"),placeholderImage: UIImage(named: "default_profile"), completed: nil)
            //                    cell.profileImage2.loadImageUsingCacheWithUrlString(receiverImageUrl)
        }
        
        if message.fromId == self.user?.senderID {
            cell.bubbleView.backgroundColor = .white
            cell.bubbleView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner], radius: 8)
            cell.textView.textColor = .black
            cell.profileImage.isHidden = true
            //            cell.profileImage2.isHidden = true
            cell.messageImageView.isHidden = true
            cell.bubbleRightAnchor?.isActive = true
            cell.bubbleLeftAnchor?.isActive = false
        } else {
            cell.bubbleView.backgroundColor = UIColor(r: 245, g: 245, b: 245)
            cell.bubbleView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 8)
            cell.textView.textColor = .black
            cell.profileImage.isHidden = false
            //            cell.profileImage2.isHidden = truer
            cell.messageImageView.isHidden = true
            cell.bubbleRightAnchor?.isActive = false
            cell.bubbleLeftAnchor?.isActive = true
        }
        //        else {
        //            cell.bubbleView.backgroundColor = .clear
        //            cell.messageImageView.image = textArray[indexPath.item] as! UIImage
        //            cell.messageImageView.isHidden = false
        //            cell.textView.isHidden = true
        //            cell.profileImage.isHidden = true
        //            cell.bubbleRightAnchor?.isActive = true
        //            cell.bubbleLeftAnchor?.isActive = false
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 80
        
        let message = messages[indexPath.item]
        if let text = message.message {
            height = estimateFrameForText(text: text).height + 30
        } else if let imageWidth = message.imageWidth?.floatValue, let imageHeight = message.imageHeight?.floatValue {
            
            // h1 / w1 = h2 / w2
            // solve for h1
            // h1 = h2 / w2 * w1
            
            height = CGFloat(imageHeight / imageWidth * 200)
            
        }
        
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: height)
    }
    
    // Function to get the estimated height of given text. You need to specify the width, height and text font size in the function.
    private func estimateFrameForText(text: String) -> CGRect {
        // "size" is the maximum width and height the text bubble can have.
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}


// MARK:- UITextField extension
extension ChatLogController: UITextFieldDelegate {
    
}


// MARK:- UIImagePickerControlle extension
extension ChatLogController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            print("selectedimage")
            //            sentImage = selectedImage
            textArray.append(selectedImage)
            //            sentMessageType.append("image")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ChatLogController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let sizeToFitIn = CGSize(width: self.inputTextField.bounds.size.width, height: CGFloat(MAXFLOAT))
        let newSize = self.inputTextField.sizeThatFits(sizeToFitIn)
        let height = newSize.height > 34 ? (newSize.height > 60 ? 60 : newSize.height) : 34
        print("height --- \(height)")
        self.textViewHeight.constant = height
        testingViewContainer.invalidateIntrinsicContentSize()
        testingViewContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height + 20)
    }
}
