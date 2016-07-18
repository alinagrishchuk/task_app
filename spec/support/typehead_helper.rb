def init_typehead_search(id, value)
  fill_in id, with: value
  page.execute_script %Q{ $('##{id}').trigger("keydown") }
  sleep 1
end

def click_typehead_search(value)
  page.execute_script %Q{ $('.tt-suggestion:contains("#{value}")').click() }
end