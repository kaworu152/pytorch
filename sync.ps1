# 一键同步：提交并推送到 GitHub
# 用法：.\sync.ps1 "今天学了什么"
# 不写说明时，自动用日期时间作为提交信息
param(
    [string]$msg = "update $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
)

Set-Location $PSScriptRoot

git add .

$changes = git status --porcelain
if ($changes) {
    git commit -m $msg
} else {
    Write-Host "没有改动，跳过提交" -ForegroundColor Yellow
}

git push
Write-Host "同步完成" -ForegroundColor Green
