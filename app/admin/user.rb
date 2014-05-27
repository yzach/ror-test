ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :role
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :role
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.inputs "Role" do
      f.input :is_admin
      f.input :role
    end

    f.inputs "Languages" do
      f.has_many :language_pairs, heading: false do |pair_f|
        languages = Language.all.map {|l| [l.code, l.id]}
        pair_f.input :from_language_id, as: :select, collection: languages
        pair_f.input :to_language_id, as: :select, collection: languages
        pair_f.input :_destroy, as: :boolean, label: 'Destory?'
      end
    end

    f.actions
  end

  controller do
    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end

    def permitted_params
       params.permit!
    end
  end
end
