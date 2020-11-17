module ApplicationHelper
  def jbuild_props(template, locals)
    JbuilderTemplate.new(self) do |json|
      json.partial!(partial: template, formats: [:json], handlers: [:jbuilder], locals: locals)
    end.attributes!
  end
end
