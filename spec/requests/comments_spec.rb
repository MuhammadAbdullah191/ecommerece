# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CommentsController', type: :request do

  describe 'GET /products/:product_id/comments' do
    it 'return all comments of product' do
      product = FactoryBot.create(:product)
      user = FactoryBot.create(:user, email: 'abd0@gmail.com')
      comment = FactoryBot.create(:comment, product: product, user: user)
      comment = FactoryBot.create(:comment, product: product, user: user)
      get product_comments_path(product_id: product.id)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /products/:product_id/comments' do
    it 'creates new comment' do
      product = FactoryBot.create(:product)
      user = FactoryBot.create(:user, email: 'abd0@gmail.com')
      user.confirm
      sign_in user
      get authenticated_root_path
      expect(controller.current_user).to eq(user)
      post product_comments_path(product_id: product.id), params: { comment: { body: 'test comment' } }
      expect(response).to have_http_status(:ok)
    end

    it 'redirects to sign in and give code 302 if not-signed in user create comment' do
      product = FactoryBot.create(:product)
      post product_comments_path(product_id: product.id), params: { comment: { body: 'test comment' } }
      expect(response).to have_http_status(:found)
    end

    it 'cannot add comment to own product' do
      product = FactoryBot.create(:product)
      user = product.user
      user.confirm
      sign_in user
      get authenticated_root_path
      expect(controller.current_user).to eq(user)
      post product_comments_path(product_id: product.id), params: { comment: { body: 'test comment' } }
      expect(response).to have_http_status(:found)
    end
  end

  describe 'delete products/:product_id/comments/:id' do
    it 'deletes a comment' do
      product = FactoryBot.create(:product)
      user = FactoryBot.create(:user, email: 'abd0@gmail.com')
      comment = FactoryBot.create(:comment, product: product, user: user)
      user.confirm
      sign_in user
      get authenticated_root_path
      expect(controller.current_user).to eq(user)
      delete product_comment_path(product_id: product.id, id: comment.id)
      expect(response).to have_http_status(:no_content)
    end

    it 'cannot delete a comment without signing in' do
      product = FactoryBot.create(:product)
      user = FactoryBot.create(:user, email: 'abd0@gmail.com')
      comment = FactoryBot.create(:comment, product: product, user: user)
      delete product_comment_path(product_id: product.id, id: comment.id)
      expect(response).to have_http_status(:found)
    end

    it 'cannot delete a comment of other users' do
      product = FactoryBot.create(:product)
      user = FactoryBot.create(:user, email: 'abd0@gmail.com')
      comment = FactoryBot.create(:comment, product: product, user: user)
      user = product.user
      user.confirm
      sign_in user
      get authenticated_root_path
      expect(controller.current_user).to eq(user)
      delete product_comment_path(product_id: product.id, id: comment.id)
      expect(response).to have_http_status(:found)
    end
  end

  describe 'get /products/:product_id/comments/:id/edit' do
    it 'edits a comment' do
      product = FactoryBot.create(:product)
      user = FactoryBot.create(:user, email: 'abd0@gmail.com')
      comment = FactoryBot.create(:comment, product: product, user: user)
      get edit_product_comment_path(product_id: product.id, id: comment.id), params: { comment: { body: 'test comment' } }
      expect(response).to have_http_status(:found)
    end
  end

  describe 'updates product_comment' do
    it 'updates a comment' do
      product = FactoryBot.create(:product)
      user = FactoryBot.create(:user, email: 'abd0@gmail.com')
      comment = FactoryBot.create(:comment, product: product, user: user)
      user.confirm
      sign_in user
      get authenticated_root_path
      expect(controller.current_user).to eq(user)
      put product_comment_path(product_id: product.id, id: comment.id), params: { comment: { body: 'test comment' } }
      expect(response).to have_http_status(:no_content)
    end

    it 'cannnot update a comment without signing in' do
      product = FactoryBot.create(:product)
      user = FactoryBot.create(:user, email: 'abd0@gmail.com')
      comment = FactoryBot.create(:comment, product: product, user: user)
      patch product_comment_path(product_id: product.id, id: comment.id), params: { comment: { body: 'test comment' } }
      expect(response).to have_http_status(:found)
    end

    it 'cannot update a comment of other users' do
      product = FactoryBot.create(:product)
      user = FactoryBot.create(:user, email: 'abd0@gmail.com')
      comment = FactoryBot.create(:comment, product: product, user: user)
      user = product.user
      user.confirm
      sign_in user
      get authenticated_root_path
      expect(controller.current_user).to eq(user)
      patch product_comment_path(product_id: product.id, id: comment.id), params: { comment: { body: 'test comment' } }
      expect(response).to have_http_status(:found)
    end

    it 'render edit page on invalid params' do
      product = FactoryBot.create(:product)
      user = FactoryBot.create(:user, email: 'abd0@gmail.com')
      comment = FactoryBot.create(:comment, product: product, user: user)
      signe_in(user)
      put product_comment_path(product_id: product.id, id: comment.id), params: { comment: { body: nil } }
      expect(response).to have_http_status(:ok)
    end
  end

  private

  def signe_in(user)
    user.confirm
    sign_in user
    get authenticated_root_path
  end
end

