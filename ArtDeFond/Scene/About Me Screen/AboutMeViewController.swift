//
//  AboutMeViewController.swift
//  ArtDeFond
//
//  Created by developer on 20.08.2022.
//

import UIKit
import SnapKit
import TPKeyboardAvoiding

class AboutMeViewController: UIViewController {
    
    private let scrollView = TPKeyboardAvoidingScrollView()
    private let contentView = UIView()
    
    private let avatarImageView = UIImageView()
    private let nickNameLabelTextField = LabelTextField(CustomTextFieldViewModel: .init(type: .withoutImage,
                                                                                        keyboardType: .default,
                                                                                        placeholder: "Введите ваш никнейм"),
                                                        labelText: "Никнейм")
    private let aboutMeLabel = UILabel()
    private let aboutMeTextView = UITextView()
    private let nextButton = CustomButton(viewModel: .init(type: .dark,
                                                           labelText: "Завершить"))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Обо мне"
//        navigationController?.navigationBar.backItem?.setHidesBackButton(true, animated: false)
//        self.tabBarController?.navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.tintColor = .red
        
        
        
        self.navigationItem.leftBarButtonItems = []
        setup()
    }
    
    private func setup(){
        scrollViewSetup()
        avatarImageViewSetup()
        nickNameLabelTextFieldSetup()
        aboutMeLabelSetup()
        aboutMeTextViewSetup()
        nextButtonSetup()
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
    
    private func avatarImageViewSetup(){
        contentView.addSubview(avatarImageView)
        
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.backgroundColor = Constants.Colors.lightRed
        avatarImageView.image = Constants.Icons.avatarPlaceholder
        
        avatarImageView.snp.makeConstraints{make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }
    
    private func nickNameLabelTextFieldSetup(){
        contentView.addSubview(nickNameLabelTextField)
        
        nickNameLabelTextField.snp.makeConstraints{ make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func aboutMeLabelSetup(){
        contentView.addSubview(aboutMeLabel)
        aboutMeLabel.text = "Расскажите о себе"
        aboutMeLabel.font = Constants.Fonts.regular15
        aboutMeLabel.textColor = Constants.Colors.brown
        
        aboutMeLabel.snp.makeConstraints{make in
            make.top.equalTo(nickNameLabelTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(48)
        }
        
    }
    
    private func aboutMeTextViewSetup(){
        contentView.addSubview(aboutMeTextView)
        
        aboutMeTextView.textColor = Constants.Colors.darkRed
        aboutMeTextView.font = Constants.Fonts.regular17
        aboutMeTextView.layer.cornerRadius = 16
        aboutMeTextView.backgroundColor = Constants.Colors.lightRed
        
        aboutMeTextView.snp.makeConstraints{make in
            make.top.equalTo(aboutMeLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(180)
        }
    }
    
    private func nextButtonSetup(){
        contentView.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        
        nextButton.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(44)
            make.top.equalTo(aboutMeTextView.snp.bottom).offset(175)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc
    private func tapNextButton(){
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
