# frozen_string_literal: true

require 'test_helper'

class PromosControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get promos_index_url
    assert_response :success
  end
end
