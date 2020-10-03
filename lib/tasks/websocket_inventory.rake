# frozen_string_literal: true

namespace :websocket do
  desc 'Send random inventory through websocket'
  task inventory: :environment do
    # Code from https://github.com/mathieugagne/shoe-store/blob/master/inventory.rb
    # Transformed into rails websocket
    STORE_STORES = ['ALDO Centre Eaton', 'ALDO Destiny USA Mall', 'ALDO Pheasant Lane Mall', 'ALDO Holyoke Mall', 'ALDO Maine Mall', 'ALDO Crossgates Mall', 'ALDO Burlington Mall', 'ALDO Solomon Pond Mall', 'ALDO Auburn Mall', 'ALDO Waterloo Premium Outlets'].freeze
    SHOES_MODELS = %w[ADERI MIRIRA CAELAN BUTAUD SCHOOLER SODANO MCTYRE CADAUDIA RASIEN WUMA GRELIDIEN CADEVEN SEVIDE ELOILLAN BEODA VENDOGNUS ABOEN ALALIWEN GREG BOZZA].freeze
    INVENTORY = Array(0..100)
    RANDOMNESS = Array(1..3)

    Rails.logger.info "Start sending random inventory on channel #{StoreEvent::WS_CHANNEL_NAME}..."

    EM.run do
      ws = Faye::WebSocket::Client.new('ws://0.0.0.0:3000/websocket')

      loop = EM.add_periodic_timer(1) do
        RANDOMNESS.sample.times do
          data = {
            store: STORE_STORES.sample,
            model: SHOES_MODELS.sample,
            inventory: INVENTORY.sample
          }
          Rails.logger.info "Sending data: #{data}"
          ws.send(JSON.generate(command: 'message', identifier: JSON.generate(channel: StoreEvent::WS_CHANNEL_NAME), data: JSON.generate(data)))
        end
      end

      ws.on :open do
        Rails.logger.info "Connection opened with the rails server @ 'ws://0.0.0.0:3000/websocket'"
        ws.send(JSON.generate(command: 'subscribe', identifier: JSON.generate(channel: StoreEvent::WS_CHANNEL_NAME)))
      end

      ws.on :error do |event|
        Rails.logger.warn "Connection error with the rails server. Rails server is up? Error message: #{event.message}"
      end

      ws.on :close do |event|
        Rails.logger.info "Connection closed with the rails server. Code: #{event.code}. Reason: #{event.reason}"
        EM.cancel_timer(loop)
        ws = nil
      end
    end
  end
end
