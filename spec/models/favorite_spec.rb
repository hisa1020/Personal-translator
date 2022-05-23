require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:post) { FactoryBot.create(:post) }
  let(:favorite) { FactoryBot.create(:favorite, post_id: post.id) }

  it 'お気に入りに登録された投稿を取得' do
    expect(favorite.post.title).to eq post.title
    expect(favorite.post.content).to eq post.content
  end
end
