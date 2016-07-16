def submit_form
  find('button[type="submit"]').click
end

def click_cansel
  find('button.js-cancel').click
end