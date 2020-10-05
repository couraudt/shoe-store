# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Last 20 Received Events', id: 'last_events' do
          table_for [] do
            column 'Store'
            column 'Store Model'
            column 'Inventory'
          end
        end
      end
      column do
        panel 'Shoe Store Dashboard' do
          h5 "Get started"
          span "In order to receive events, start rake task using the command:"
          br 'br'
          code 'docker-compose exec website rails websocket:inventory'

          h5 "Few useful links"
          ul do
            li link_to 'Sidekiq admin panel', '/sidekiq', target: '_blank'
            li link_to 'Api Documentation', 'https://editor.swagger.io/?url=https://raw.githubusercontent.com/couraudt/shoe-store/master/api-description-swagger.yaml
', target: '_blank'
          end
        end
      end
    end
  end
end
