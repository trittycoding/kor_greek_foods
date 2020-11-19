ActiveAdmin.register Product do
  permit_params :name, :price, :category_id, :description, :stockquantity

  # DSL form - used to modify active admin form for Products
  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image) : ''
    end
    f.actions
  end
end
