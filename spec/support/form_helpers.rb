def submit_form
  find('button[type="submit"]').click
  sleep 4
end

def click_cancel
  find('button.js-cancel').click
end