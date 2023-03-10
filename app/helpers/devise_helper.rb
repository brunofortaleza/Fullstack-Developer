module DeviseHelper
  # Customize Devise's flash messages using Bootstrap classes
  def devise_flash_messages
    flash_messages = []

    flash.each do |key, value|
      if key == 'notice'
        flash_messages << "<div class='alert alert-success alert-dismissible fade show' role='alert'>#{value}<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>"
      elsif key == 'alert'
        flash_messages << "<div class='alert alert-danger alert-dismissible fade show' role='alert'>#{value}<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button></div>"
      end
    end

    flash_messages.join.html_safe
  end
end
