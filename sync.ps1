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
    if ($LASTEXITCODE -ne 0) {
        Write-Host "提交失败" -ForegroundColor Red
        exit 1
    }
    Write-Host "已提交：$msg" -ForegroundColor Cyan
} else {
    Write-Host "没有新的改动" -ForegroundColor Yellow
}

git push
if ($LASTEXITCODE -eq 0) {
    Write-Host "同步完成" -ForegroundColor Green
} else {
    Write-Host "推送失败：网络连接被重置，稍后重试（多试几次通常能成）" -ForegroundColor Red
}
