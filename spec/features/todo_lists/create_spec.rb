require 'spec_helper'

describe "Creating todo lists" do
  it "redirects to the todo list page on sucess" do
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page). to have_content("New Todo List")

    fill_in "Title", with: "My todo list"
    fill_in "Description", with: "The thing that is saving me from my own anxiety."
    click_button "Create Todo list"

    expect(page).to have_content("My todo list")
  end

  it "displays an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page). to have_content("New Todo List")

    fill_in "Title", with: ""
    fill_in "Description", with: "The thing that is saving me from my own anxiety."
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "todo_lists"
    expect(page).to_not have_content("The thing that is saving me from my own anxiety.")
  end

  it "displays an error when the todo list has no description" do
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page). to have_content("New Todo List")

    fill_in "Title", with: "My todo list"
    fill_in "Description", with: ""
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "todo_lists"
    expect(page).to_not have_content("My todo list")
  end
end
