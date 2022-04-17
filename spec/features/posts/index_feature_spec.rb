require 'rails_helper'

RSpec.feature "Posts::Index", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post) }

  before do
    sign_in user
    visit posts_path
  end

  describe "post_nav内のリンクが正常に作動する" do
    context ".post-nav-pc内のリンク" do
      scenario "質問一覧に移動" do
        within('.post-nav-pc') do
          click_link '質問一覧'
          expect(current_path).to eq questions_path
        end
      end

      scenario "新規投稿に移動" do
        within('.post-nav-pc') do
          click_link '投稿する'
          expect(current_path).to eq new_post_path
        end
      end

      scenario "新規質問に移動" do
        within('.post-nav-pc') do
          click_link '質問する'
          expect(current_path).to eq new_question_path
        end
      end
    end

    context ".post-nav-mobile内のリンク" do
      scenario "質問一覧に移動" do
        within('.post-nav-mobile') do
          click_link '質問一覧'
          expect(current_path).to eq questions_path
        end
      end

      scenario "新規投稿に移動" do
        within('.post-nav-mobile') do
          click_link '投稿する'
          expect(current_path).to eq new_post_path
        end
      end

      scenario "新規質問に移動" do
        within('.post-nav-mobile') do
          click_link '質問する'
          expect(current_path).to eq new_question_path
        end
      end
    end
  end

  scenario "投稿情報を表示" do
    expect(page).to have_content post.user.name
    expect(page).to have_selector("img[src$='#{post.user.user_icon.identifier}']")
    expect(page).to have_content post.created_at.strftime("%Y年 %m月%d日 %H時%M分")
    expect(page).to have_content post.updated_at.strftime("%Y年 %m月%d日 %H時%M分")
    expect(page).to have_content post.title
    expect(page).to have_content post.content
  end
end
