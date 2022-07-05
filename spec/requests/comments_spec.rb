# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CommentsController', type: :request do
  let!(:product) { FactoryBot.create(:product) }
  let!(:user) { FactoryBot.create(:user, email: 'abd0@gmail.com') }
  let!(:comment) {FactoryBot.create(:comment, product: product, user: user)}

  describe 'GET /products/:product_id/comments' do
    let!(:testcomment) { create(:comment, product: product, user: user)}
    it 'return all comments of product' do
      get product_comments_path(product_id: product.id)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /products/:product_id/comments' do
    context 'for signed in user' do
      it 'creates new comment' do
        signed_in(user)
        post product_comments_path(product_id: product.id), params: { comment: { body: 'test comment' } }
        expect(response).to have_http_status(:ok)
      end
      it 'should return unauthorised status when user tries to comment on his own product' do
        user = product.user
        signed_in(user)
        post product_comments_path(product_id: product.id), params: { comment: { body: 'test comment' } }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    it 'should return unauthorised status for unauthenticated user' do
      post product_comments_path(product_id: product.id), params: { comment: { body: 'test comment' } }
      expect(response).to have_http_status(:unauthorized)
    end

  end

  describe 'delete products/:product_id/comments/:id' do
    it 'deletes a comment' do
      signed_in(user)
      delete product_comment_path(product_id: product.id, id: comment.id)
      expect(response).to have_http_status(:no_content)
    end

    it 'should return unauthorised status for unauthenticated user' do
      delete product_comment_path(product_id: product.id, id: comment.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it 'cannot delete a comment of other users' do
      user = product.user
      signed_in(user)
      delete product_comment_path(product_id: product.id, id: comment.id)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'get /products/:product_id/comments/:id/edit' do
    it 'should return unauthorised status for unauthenticated user' do
      get edit_product_comment_path(product_id: product.id, id: comment.id), params: { comment: { body: 'test comment' } }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'edits a comment' do
      get edit_product_comment_path(product_id: product.id, id: comment.id), params: { comment: { body: 'test comment' } }
      signed_in(user)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'patch/put product_comment' do
    it 'updates a comment' do
      signed_in(user)
      put product_comment_path(product_id: product.id, id: comment.id), params: { comment: { body: 'test comment' } }
      expect(response).to have_http_status(:no_content)
    end

    it 'should return unauthorised status for unauthenticated user' do
      patch product_comment_path(product_id: product.id, id: comment.id), params: { comment: { body: 'test comment' } }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'cannot update a comment of other users' do
      user = product.user
      signed_in(user)
      patch product_comment_path(product_id: product.id, id: comment.id), params: { comment: { body: 'test comment' } }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'render edit page on invalid params' do
      signed_in(user)
      put product_comment_path(product_id: product.id, id: comment.id), params: { comment: { body: nil } }
      expect(response).to have_http_status(:ok)
    end
  end

  private

  def signed_in(user)
    user.confirm
    sign_in user
    get authenticated_root_path
  end
end





# expect(controller.current_user).to eq(user)

