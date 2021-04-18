resource "aws_iam_policy" "task_execution_role_policy" {
  name        = "${var.prefix}-task-exec-role-policy"
  path        = "/"
  description = "Allow retrieving of images and adding to logs"
  policy      = fileexists("${local.module_path}/task-exec-role.json") ? file("${local.module_path}/task-exec-role.json") : file("${local.default_path}/task-exec-role.json")
}

resource "aws_iam_role" "task_execution_role" {
  name               = "${var.prefix}-task-exec-role"
  assume_role_policy = fileexists("${local.module_path}/assume-role-policy.json") ? file("${local.module_path}/assume-role-policy.json") : file("${local.default_path}/assume-role-policy.json")

  tags = var.common_tags
}

resource "aws_iam_role_policy_attachment" "task_execution_role" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.task_execution_role_policy.arn
}

resource "aws_iam_role" "app_iam_role" {
  name               = "${var.prefix}-nginx-task"
  assume_role_policy = fileexists("${local.module_path}/assume-role-policy.json") ? file("${local.module_path}/assume-role-policy.json") : file("${local.default_path}/assume-role-policy.json")

  tags = var.common_tags
}