//
//  UploadPhotoViewController.swift
//  ArtDeFond
//
//  Created by developer on 19.08.2022.
//

import UIKit
import SnapKit
import TPKeyboardAvoiding

class UploadPhotoViewController: UIViewController {
    
    private let scrollView = TPKeyboardAvoidingScrollView()
    private let contentView = UIView()
    
    private let pictureImageView = UIImageView()
    
    private let titleLabelTextField = LabelTextField(CustomTextFieldViewModel: .init(type: .withoutImage,
                                                                                     keyboardType: .default),
                                                     labelText: "Название картины")
    
    private let aboutPictureLabel = UILabel()
    private let aboutPictureTextView = UITextView()
    private let nextScreenButton = CustomButton(viewModel: .init(type: .dark, labelText: "Далее"))
    
    lazy var someView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 16
        view.backgroundColor = Constants.Colors.lightRed
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewModel: UploadPhotoViewModel
    
    init(viewModel: UploadPhotoViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Добавить изображение"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:Constants.Colors.darkRed]
        
        setup()
        bindToViewModel()
    }
    
    private func scrollViewSetup(){
        view.addSubview(scrollView)
        
        scrollView.keyboardDismissMode = .interactive
        scrollView.isScrollEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().priority(250)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().priority(250)
            
        }
    }
    
    
    private func bindToViewModel(){
        viewModel.didGoToNextScreen = {[weak self] vc in
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setup(){
        view.backgroundColor = .white
        pictureImageViewSetup()
        titleLabelTextFieldSetup()
        aboutPictureLabelSetup()
        aboutPictureTextViewSetup()
        nextScreenButtonSetup()
        scrollViewSetup()
    }
    
    private func pictureImageViewSetup(){
        contentView.addSubview(pictureImageView)
        
        pictureImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnImageView)))
        pictureImageView.isUserInteractionEnabled = true
        
        pictureImageView.image = UIImage(named: "Imageholder")
        pictureImageView.contentMode = .scaleAspectFill
        
        pictureImageView.backgroundColor = Constants.Colors.dirtyWhite
        pictureImageView.layer.cornerRadius = 16
        pictureImageView.layer.masksToBounds = true
        
        pictureImageView.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(200)
        }
    }
    
    private func titleLabelTextFieldSetup(){
        contentView.addSubview(titleLabelTextField)
        
        titleLabelTextField.snp.makeConstraints{make in
            make.top.equalTo(pictureImageView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func aboutPictureLabelSetup(){
        contentView.addSubview(aboutPictureLabel)
        aboutPictureLabel.text = "Опишите вашу картину"
        aboutPictureLabel.font = Constants.Fonts.regular15
        aboutPictureLabel.textColor = Constants.Colors.brown
        
        aboutPictureLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabelTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(48)
        }
    }
    
    private func aboutPictureTextViewSetup(){
        contentView.addSubview(someView)
        someView.addSubview(aboutPictureTextView)
        aboutPictureTextView.textColor = Constants.Colors.darkRed
        aboutPictureTextView.font = Constants.Fonts.regular17
        aboutPictureTextView.layer.cornerRadius = 16
        aboutPictureTextView.backgroundColor = .clear
        
        someView.snp.makeConstraints{make in
            make.top.equalTo(aboutPictureLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(180)
        }
        
        aboutPictureTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func nextScreenButtonSetup(){
        contentView.addSubview(nextScreenButton)
        
        nextScreenButton.addTarget(self, action: #selector(tapOnNextButton), for: .touchUpInside)
        
        nextScreenButton.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(aboutPictureTextView.snp.bottom).offset(30)
            make.height.equalTo(44)
        }
    }
    
    @objc
    private func tapOnImageView(){
        let picker = UIImagePickerController()
        picker.delegate = self
        
        let actionSheet = UIAlertController(title: "Источник фото",
                                            message: "Выберите источник",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Камера",
                                            style: .default,
                                            handler: { (action:UIAlertAction) in
            picker.allowsEditing = false
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Фотогалерея",
                                            style: .default,
                                            handler: { (action:UIAlertAction) in
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Отмена",
                                            style: .cancel,
                                            handler:nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc
    private func tapOnNextButton(){
        
        if pictureImageView.image != UIImage(named: "Imageholder"),
           titleLabelTextField.returnText() != "",
           aboutPictureTextView.text != ""
        {
            viewModel.goToNextScreen(image: pictureImageView.image ?? Constants.Icons.avatarPlaceholder,
                                     pictureName: titleLabelTextField.returnText(),
                                     pictureDescription: aboutPictureTextView.text)
        } else {
            let alert = UIAlertController(title: "Пустые поля", message: "Для продолжения необходимо заполнить все поля.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Хорошо", style: .cancel)
            alert.addAction(alertAction)
            present(alert, animated: true)
        }
    }
}

extension UploadPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if picker.sourceType == .camera{
            guard let image = info[.originalImage] as? UIImage else{
                return
            }
            pictureImageView.image = image
        }
        else if picker.sourceType == .photoLibrary{
            
            let url = info[.imageURL]
            let data = try? Data(contentsOf: url as! URL)
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                pictureImageView.image = image
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
