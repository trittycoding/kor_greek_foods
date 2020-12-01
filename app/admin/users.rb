ActiveAdmin.register User do
  permit_params :name, :address, :province_id, :email, :password, :password_confirmation

  # DSL form - used to modify active admin form for Products
  form do |f|
    f.semantic_errors
    f.inputs
    f.actions
  end
end
