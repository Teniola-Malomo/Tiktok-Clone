//
//  ProfileHeader.swift
//  KD Tiktok-Clone
//
//  Created by Sam Ding on 9/14/20.
//  Copyright © 2020 Kaishan. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ProfileHeaderView: UICollectionReusableView {

    // MARK: - UI Components
    @IBOutlet weak var profileImgView: UIImageView! {
        didSet {
            profileImgView.layer.cornerRadius = profileImgView.frame.width / 2
            profileImgView.layer.borderWidth = 1
            profileImgView.layer.borderColor = UIColor.Background.cgColor
        }
    }
    @IBOutlet weak var clearCacheBtn: UIButton! {
        didSet {
            clearCacheBtn.layer.cornerRadius = clearCacheBtn.frame.width / 2
        }
    }

    private var usernameLabel: UILabel!
    private var handleLabel: UILabel!
    private var followingCountLabel: UILabel!
    private var followersCountLabel: UILabel!
    private var likesCountLabel: UILabel!
    private var bioLabel: UILabel!
    private var editProfileButton: UIButton!
    private var shareProfileButton: UIButton!
    private var hasSetupCustomViews = false

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if !hasSetupCustomViews {
            hasSetupCustomViews = true
            setupCustomViews()
        }
    }

    private func setupCustomViews() {
        // Username
        usernameLabel = UILabel()
        usernameLabel.text = "@creator"
        usernameLabel.font = .systemFont(ofSize: 14, weight: .regular)
        usernameLabel.textColor = .lightGray
        usernameLabel.textAlignment = .center
        addSubview(usernameLabel)

        // Display name
        handleLabel = UILabel()
        handleLabel.text = "Creator"
        handleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        handleLabel.textColor = .white
        handleLabel.textAlignment = .center
        addSubview(handleLabel)

        // Stats row
        let statsStack = UIStackView()
        statsStack.axis = .horizontal
        statsStack.distribution = .equalSpacing
        statsStack.alignment = .center
        statsStack.spacing = 20
        addSubview(statsStack)

        followingCountLabel = makeStatLabel(count: "0", title: "Following")
        followersCountLabel = makeStatLabel(count: "0", title: "Followers")
        likesCountLabel = makeStatLabel(count: "0", title: "Likes")

        statsStack.addArrangedSubview(followingCountLabel)
        statsStack.addArrangedSubview(makeDivider())
        statsStack.addArrangedSubview(followersCountLabel)
        statsStack.addArrangedSubview(makeDivider())
        statsStack.addArrangedSubview(likesCountLabel)

        // Edit Profile button
        editProfileButton = UIButton(type: .system)
        editProfileButton.setTitle("Edit profile", for: .normal)
        editProfileButton.setTitleColor(.white, for: .normal)
        editProfileButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        editProfileButton.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        editProfileButton.layer.cornerRadius = 4
        addSubview(editProfileButton)

        // Share Profile button
        shareProfileButton = UIButton(type: .system)
        shareProfileButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareProfileButton.tintColor = .white
        shareProfileButton.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        shareProfileButton.layer.cornerRadius = 4
        addSubview(shareProfileButton)

        // Bio
        bioLabel = UILabel()
        bioLabel.text = "No bio yet."
        bioLabel.font = .systemFont(ofSize: 14)
        bioLabel.textColor = .lightGray
        bioLabel.textAlignment = .center
        bioLabel.numberOfLines = 0
        addSubview(bioLabel)

        // Layout
        let centerX = self.bounds.midX

        profileImgView.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
            make.width.height.equalTo(96)
        }
        profileImgView.layer.cornerRadius = 48

        handleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImgView.snp.bottom).offset(12)
        }

        usernameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(handleLabel.snp.bottom).offset(4)
        }

        statsStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameLabel.snp.bottom).offset(16)
        }

        editProfileButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-22)
            make.top.equalTo(statsStack.snp.bottom).offset(16)
            make.width.equalTo(200)
            make.height.equalTo(36)
        }

        shareProfileButton.snp.makeConstraints { make in
            make.left.equalTo(editProfileButton.snp.right).offset(8)
            make.centerY.equalTo(editProfileButton)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }

        bioLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(editProfileButton.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }

        // Hide the old clear cache button (keep it wired but out of sight)
        clearCacheBtn.isHidden = true
    }

    private func makeStatLabel(count: String, title: String) -> UILabel {
        let label = UILabel()
        let attributed = NSMutableAttributedString()
        attributed.append(NSAttributedString(string: count, attributes: [
            .font: UIFont.systemFont(ofSize: 17, weight: .bold),
            .foregroundColor: UIColor.white
        ]))
        attributed.append(NSAttributedString(string: "\n" + title, attributes: [
            .font: UIFont.systemFont(ofSize: 12, weight: .regular),
            .foregroundColor: UIColor.lightGray
        ]))
        label.attributedText = attributed
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }

    private func makeDivider() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        view.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(20)
        }
        return view
    }

    @IBAction func clearCache(_ sender: Any) {
        VideoCacheManager.shared.clearCache(completion: { size in
            let message = "Remove Cache Size: " + size + "MB"
            ProfileViewModel.shared.displayMessage(message: message)
            ProfileViewModel.shared.cleardCache.onNext(true)
        })
    }
}
