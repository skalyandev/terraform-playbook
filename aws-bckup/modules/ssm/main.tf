##################################################################################
# SSM MANAGED POLICY ATTACHMENT
##################################################################################

resource "aws_iam_role_policy_attachment" "ssm_core" {

  role = var.iam_role_name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}
