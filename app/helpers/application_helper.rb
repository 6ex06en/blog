module ApplicationHelper
  def error_container object, key
    if object.errors.include? key
      content_tag :div, object.errors[key], class: "alert alert-danger form-danger"
    end
  end
end
