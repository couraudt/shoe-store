# frozen_string_literal: true

ActiveAdmin.register StoreModel, as: 'Models' do
  menu priority: 3

  actions :index, :show

  includes :store

  index do
    selectable_column
    id_column
    column :store
    column :name
    column :inventory
    actions
  end

  filter :store
  filter :name

  show do
    attributes_table do
      row :store
      row :name
      row :inventory
      row :created_at
      row :updated_at
    end
  end
end
