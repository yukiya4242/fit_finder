require 'rails_helper'

RSpec.describe "Routing", :type => :routing do
  it "routes root to the homes controller" do
    expect(get("/")).to route_to("homes#top")
  end

  it "routes homes/about to the homes controller" do
    expect(get("/homes/about")).to route_to("homes#about")
  end

  it "routes /users_guest_sign_in to the users/sessions controller" do
    expect(post("/users_guest_sign_in")).to route_to("users/sessions#new_guest")
  end

  it "routes /posts to the posts controller" do
    expect(get("/posts")).to route_to("posts#index")
  end

  it "routes /posts/:post_id/comments to the comments controller" do
    expect(post("/posts/1/comments")).to route_to("comments#create", post_id: "1")
    expect(delete("/posts/1/comments/1")).to route_to("comments#destroy", post_id: "1", id: "1")
  end

  it "routes /posts/:post_id/likes to the likes controller" do
    expect(post("/posts/1/likes")).to route_to("likes#create", post_id: "1")
    expect(delete("/posts/1/likes/1")).to route_to("likes#destroy", post_id: "1", id: "1")
  end

  it "routes /chats/:id to the chats controller" do
    expect(get("/chats/1")).to route_to("chats#show", id: "1")
    expect(post("/chats")).to route_to("chats#create")
    expect(delete("/chats/1")).to route_to("chats#destroy", id: "1")
    expect(patch("/chats/1/read")).to route_to("chats#read", id: "1")
  end

  it "routes /relationships to the relationships controller" do
    expect(post("/relationships")).to route_to("relationships#create")
  end

  it "routes /notifications to the notifications controller" do
    expect(get("/notifications")).to route_to("notifications#index")
    expect(patch("/notifications/1")).to route_to("notifications#update", id: "1")
  end

  it "routes /rooms/:id to the rooms controller" do
    expect(get("/rooms/1")).to route_to("rooms#show", id: "1")
  end

  it "routes /saved_files to the saved_files controller" do
    expect(post("/saved_files")).to route_to("saved_files#create")
  end

  it "routes /users/:id/liked_posts to the users controller" do
    expect(get("/users/1/liked_posts")).to route_to("users#liked_posts", id: "1")
  end

  it "routes /users/:id/chat_history to the users controller" do
    expect(get("/users/1/chat_history")).to route_to("users#chat_history", id: "1")
  end

  it "routes /users/:id/following to the users controller" do
    expect(get("/users/1/following")).to route_to("users#following", id: "1")
  end

  it "routes /users/:id/followers to the users controller" do
    expect(get("/users/1/followers")).to route_to("users#followers", id: "1")
  end

  it "routes /users/:id/follow to the users controller" do
    expect(post("/users/1/follow")).to route_to("users#follow", id: "1")
  end

  it "routes /users/:id/unfollow to the users controller" do
    expect(delete("/users/1/unfollow")).to route_to("users#unfollow", id: "1")
  end

  it "routes /users/:id/hide to the users controller" do
    expect(delete("/users/1/hide")).to route_to("users#hide", id: "1")
  end

  it "routes /users/search to the users controller" do
    expect(get("/users/search")).to route_to("users#search")
  end

end
