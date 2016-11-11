module ApplicationHelper
  def rails_to_bootstrap_alert(flash_type)
    case flash_type
    when 'notice'
      'info'
    when 'alert'
      'warning'
    else
      flash_type
    end
  end
end
