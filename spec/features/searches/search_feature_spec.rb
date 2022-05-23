require 'rails_helper'
require 'spec_helper'

RSpec.feature "Search", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    visit search_path
  end

  describe "検索機能" do
    context "投稿の検索" do
      let!(:others_post) { FactoryBot.create(:post, :others) }
      let!(:posts) { FactoryBot.create_list(:post, rand(3), :with_feedback) }

      scenario "部分一致(曲名)" do
        fill_in "word", with: "ful"
        find("#range").find("option[value='投稿']").select_option
        find("#search").find("option[value='partial_match']").select_option
        click_button '検索'
        expect(page).to have_content("検索結果: 1件")
        expect(page.all('.post-view-box').count).to eq 1
      end

      scenario "前方一致(曲名)" do
        fill_in "word", with: "youth"
        find("#range").find("option[value='投稿']").select_option
        find("#search").find("option[value='forward_match']").select_option
        click_button '検索'
        expect(page).to have_content("検索結果: 1件")
        expect(page.all('.post-view-box').count).to eq 1
      end

      scenario "後方一致(曲名)" do
        fill_in "word", with: "days"
        find("#range").find("option[value='投稿']").select_option
        find("#search").find("option[value='backward_match']").select_option
        click_button '検索'
        expect(page).to have_content("検索結果: 1件")
        expect(page.all('.post-view-box').count).to eq 1
      end

      scenario "完全一致(曲名)" do
        fill_in "word", with: "youthful days"
        find("#range").find("option[value='投稿']").select_option
        find("#search").find("option[value='perfect_match']").select_option
        click_button '検索'
        expect(page).to have_content("検索結果: 1件")
        expect(page.all('.post-view-box').count).to eq 1
      end

      scenario "部分一致(歌手名)" do
        fill_in "word", with: "child"
        find("#range").find("option[value='投稿']").select_option
        find("#search").find("option[value='partial_match']").select_option
        click_button '検索'
        expect(page).to have_content("検索結果: 1件")
        expect(page.all('.post-view-box').count).to eq 1
      end

      scenario "前方一致(歌手名)" do
        fill_in "word", with: "Mr."
        find("#range").find("option[value='投稿']").select_option
        find("#search").find("option[value='forward_match']").select_option
        click_button '検索'
        expect(page).to have_content("検索結果: 1件")
        expect(page.all('.post-view-box').count).to eq 1
      end

      scenario "後方一致(歌手名)" do
        fill_in "word", with: "ren"
        find("#range").find("option[value='投稿']").select_option
        find("#search").find("option[value='backward_match']").select_option
        click_button '検索'
        expect(page).to have_content("検索結果: 1件")
        expect(page.all('.post-view-box').count).to eq 1
      end

      scenario "完全一致(歌手名)" do
        fill_in "word", with: "Mr.Children"
        find("#range").find("option[value='投稿']").select_option
        find("#search").find("option[value='perfect_match']").select_option
        click_button '検索'
        expect(page).to have_content("検索結果: 1件")
        expect(page.all('.post-view-box').count).to eq 1
      end

      scenario "投稿詳細ページに移動できる" do
        fill_in "word", with: "youthful days"
        find("#range").find("option[value='投稿']").select_option
        find("#search").find("option[value='perfect_match']").select_option
        click_button '検索'
        find('.post-link-box').click
        expect(current_path).to eq post_path(others_post.id)
      end
    end

    context "質問の検索" do
      let!(:others_question) { FactoryBot.create(:question, :q_others) }
      let!(:question) { FactoryBot.create(:question) }

      scenario "部分一致" do
        fill_in "word", with: "new"
        find("#range").find("option[value='質問']").select_option
        find("#search").find("option[value='partial_match']").select_option
        click_button '検索'
        expect(page).to have_content("検索結果: 1件")
        expect(page.all('.post-view-box').count).to eq 1
      end

      scenario "前方一致" do
        fill_in "word", with: "brand"
        find("#range").find("option[value='質問']").select_option
        find("#search").find("option[value='forward_match']").select_option
        click_button '検索'
        expect(page).to have_content("検索結果: 1件")
        expect(page.all('.post-view-box').count).to eq 1
      end

      scenario "後方一致" do
        fill_in "word", with: "planet"
        find("#range").find("option[value='質問']").select_option
        find("#search").find("option[value='backward_match']").select_option
        click_button '検索'
        expect(page).to have_content("検索結果: 1件")
        expect(page.all('.post-view-box').count).to eq 1
      end

      scenario "完全一致" do
        fill_in "word", with: "brand new planet"
        find("#range").find("option[value='質問']").select_option
        find("#search").find("option[value='perfect_match']").select_option
        click_button '検索'
        expect(page).to have_content("検索結果: 1件")
        expect(page.all('.post-view-box').count).to eq 1
      end

      scenario "質問詳細ページに移動できる" do
        fill_in "word", with: "brand new planet"
        find("#range").find("option[value='質問']").select_option
        find("#search").find("option[value='perfect_match']").select_option
        click_button '検索'
        find('.post-link-box').click
        expect(current_path).to eq question_path(others_question.id)
      end
    end
  end
end
