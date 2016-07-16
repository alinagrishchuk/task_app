def submit_form
  find('button[type="submit"]').click
end

def click_cancel
  find('button.js-cancel').click
end