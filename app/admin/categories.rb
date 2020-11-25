ActiveAdmin.register Category do
  permit_params :name, :image

  # DSL form - used to modify active admin form for Category
  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image) : ''
    end
    f.actions
  end
end
