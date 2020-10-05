# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardChannel do
  it 'stream from dashboard' do
    subscribe
    expect(subscription).to have_stream_from('dashboard')
  end
end
