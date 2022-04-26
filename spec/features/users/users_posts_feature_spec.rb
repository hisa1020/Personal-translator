require 'rails_helper'

RSpec.feature "Users::Posts", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user_id: user.id) }
  let!(:others_post) { FactoryBot.create(:post, :others) }
  let!(:comments) { FactoryBot.create_list(:comment, rand(10), post_id: post.id) }
  let!(:favorites) { FactoryBot.create_list(:favorite, rand(10), post_id: post.id) }

  before do
    sign_in user
    visit users_posts_path
  end

  describe "user_nav内のリンクが正常に作動する" do
    context ".user-nav-pc内のリンク" do
      scenario "プロフィールに移動" do
        within('.user-nav-pc') do
          click_link 'プロフィール'
          expect(current_path).to eq users_profile_path
        end
      end
    end

    context ".user-nav-mobile内のリンク" do
      scenario "プロフィールに移動" do
        within('.user-nav-mobile') do
          click_link 'プロフィール'
          expect(current_path).to eq users_profile_path
        end
      end
    end
  end

  scenario "ユーザーの投稿を表示" do
    user.posts.all? do |post|
      expect(page).to have_content post.created_at.strftime("%Y年 %m月%d日 %H時%M分")
      expect(page).to have_content post.title
      expect(page).to have_content post.content
      expect(page).to have_content post.favorites.count
      expect(page).to have_content post.comments.count
    end
  end

  scenario "ユーザーと紐づかない投稿を表示しない" do
    expect(page).not_to have_content others_post.title
    expect(page).not_to have_content others_post.content
  end
end
