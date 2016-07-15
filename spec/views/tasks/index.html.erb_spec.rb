require 'rails_helper'

RSpec.describe "tasks/index.html.erb", type: :view do
  let!(:first_task) { create(:task) }
  let!(:second_task) { create(:task) }

  it 'displays tasks list correctly' do
    assign(:tasks, Task.all.includes(:users))
    render
    expect(rendered).to have_content('Listing Tasks')
    expect(rendered).to have_link('', href: new_task_path)
    expect(rendered).to have_selector('.task', count: 2)
  end

  it 'displays task information correctly' do
    assign(:tasks, Task.all.includes(:users))
    render
    expect(rendered).to have_content(first_task.title)
    expect(rendered).to have_content(first_task.description)
  end
end
