workflow "Publish" {
  resolves = ["GitHub Action for npm"]
  on = "release"
}

action "GitHub Action for npm" {
  uses = "actions/npm@1.0.0"
  secrets = ["NPM_TOKEN"]
  runs = "npm publish"
}
