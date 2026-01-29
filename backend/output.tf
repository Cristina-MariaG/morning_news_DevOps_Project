output "bastien_id" {
	description = "ID AWS key Bastien"
	value = aws_iam_access_key.Bastien.id
}

output "bastien_secret" {
	description = "SECRET AWS key Bastien"
	value = aws_iam_access_key.Bastien.secret
	sensitive = true
}

output "cristina_id" {
	description = "ID AWS key Cristina"
	value = aws_iam_access_key.Cristina.id
}

output "cristina_secret" {
	description = "SECRET AWS key Cristina"
	value = aws_iam_access_key.Cristina.secret
	sensitive = true
}