module ErrorsHelper
  def resource_error_messages!(resource)
    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-danger"> 
      <button type="button" class="close" data-dismiss="alert">×</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end
end 
