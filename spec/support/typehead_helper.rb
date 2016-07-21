def init_typehead_search(id, value)
  fill_in id, with: value
  page.execute_script %Q{ $('##{id}').trigger("keydown") }
  sleep 3
end

def click_typehead_search(value)
  page.execute_script %Q{ $('.tt-suggestion:contains("#{value}")').click() }
end

def init_and_click_typehead_search(id,value)
  init_typehead_search(id, value)
  click_typehead_search(value)
end
