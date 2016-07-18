def submit_form
  find('button[type="submit"]').click
  sleep 3
end

def click_cancel
  find('button.js-cancel').click
end