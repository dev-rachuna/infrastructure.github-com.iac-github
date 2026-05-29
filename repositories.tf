resource "github_repository" "repositories" {
  for_each = local.repositories

  name            = each.key
  description     = each.value.description
  visibility      = each.value.visibility
  has_issues      = each.value.has_issues
  has_projects    = each.value.has_projects
  has_wiki        = each.value.has_wiki
  has_discussions = each.value.has_discussions
  archived        = each.value.archived
  allow_forking   = each.value.allow_forking
  is_template     = each.value.is_template
  topics          = each.value.topics

  lifecycle {
    ignore_changes = [
      has_downloads,
      ignore_vulnerability_alerts_during_read,
    ]
  }
}

resource "github_branch_default" "repositories" {
  for_each = {
    for name, repository in local.repositories : name => repository
    if repository.default_branch != "main"
  }

  repository = github_repository.repositories[each.key].name
  branch     = each.value.default_branch
}
