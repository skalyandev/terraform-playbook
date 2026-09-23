output "budget_ids" {
  description = "AWS Budget IDs."

  value = {
    for key, budget in aws_budgets_budget.this :
    key => budget.id
  }
}

output "budget_names" {
  description = "AWS Budget names."

  value = {
    for key, budget in aws_budgets_budget.this :
    key => budget.name
  }
}
