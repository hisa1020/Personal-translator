require 'rails_helper'
require 'spec_helper'

RSpec.feature "Posts::Index", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post) }

  before do
    sign_in user
    visit posts_path
  end

  describe "post_nav内のリンクが正常に作動する" do
    scenario "質問一覧に移動" do
      within('.post-nav') do
        click_link '質問一覧'
        expect(current_path).to eq questions_path
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
    expect(page).to have_content post.favorites.count
    expect(page).to have_content post.comments.count
  end
end
