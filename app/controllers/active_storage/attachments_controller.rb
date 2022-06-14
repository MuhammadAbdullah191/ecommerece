# frozen_string_literal: true

module ActiveStorage
  class AttachmentsController < ApplicationController
    before_action :set_attachment
    def destroy
      session[:return_to] ||= request.referer
      @attachment.purge
      redirect_to session.delete(:return_to)
    end

    private

    def set_attachment
      @attachment = ActiveStorage::Attachment.find(params[:id])
      @record = @attachment.record
    end
  end
end
