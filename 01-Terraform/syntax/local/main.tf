provider "local" {
}

# Infra resource
resource "local_file" "foo" {
  # path.module - String inter pdation terraform 변수
  # ${path.module} : string interpolation 문법
  # 파일이 위치한 디렉토리 경로, main.tf
  filename = "${path.module}/foo.txt"
  content  = data.local_file.bar.content
}

# 입력 데이터파일 지정
data "local_file" "bar" {
  filename = "${path.module}/bar.txt"
}

# 데이터 출력 지정
output "file_bar" {
  value = data.local_file.bar
}

