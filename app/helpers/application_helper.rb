module ApplicationHelper

  def error_container object, key
    if object.errors.include? key
      if object.errors[key].one?
        content_tag :div, object.errors[key].first, class: "alert alert-danger form-danger"
      else
        content_tag :div do
          object.errors[key].map do |error|
            concat(content_tag :div, error, class: "alert alert-danger form-danger")
          end
        end
      end
    end
  end

  def owner?(post)
    post.user_id == current_user.id
  end

end
