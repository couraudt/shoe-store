# frozen_string_literal: true

ActiveAdmin.register Store do
  menu priority: 2

  actions :index, :show

  index do
    selectable_column
    id_column
    column :name
    column :models_count
    actions
  end

  filter :name

  action_item :view, only: :show do
    link_to 'Show linked Models', models_path(q: { store_id_eq: resource.id })
  end

  show do
    attributes_table do
      row :name
      row :models_count
      row :created_at
      row :updated_at
    end
  end
end
