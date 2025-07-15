#!/usr/bin/env pwsh
# Investment Repository Cleanup and Maintenance Script
# Prevents deleted files from reappearing and maintains repository hygiene

Write-Host "🧹 Investment Repository Cleanup Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Function to check if we're in a git repository
function Test-GitRepository {
    try {
        git rev-parse --git-dir *> $null
        return $true
    }
    catch {
        return $false
    }
}

# Function to clean untracked files and directories
function Remove-UntrackedFiles {
    Write-Host "`n📁 Checking for untracked files and directories..." -ForegroundColor Yellow
    
    # Show what would be removed (dry run)
    $cleanOutput = git clean -dn
    if ($cleanOutput) {
        Write-Host "Files that would be removed:" -ForegroundColor Red
        $cleanOutput | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
        
        $confirm = Read-Host "`nDo you want to remove these files? (y/N)"
        if ($confirm -eq 'y' -or $confirm -eq 'Y') {
            git clean -df
            Write-Host "✅ Untracked files removed" -ForegroundColor Green
        }
        else {
            Write-Host "⏭️  Skipped file removal" -ForegroundColor Yellow
        }
    }
    else {
        Write-Host "✅ No untracked files found" -ForegroundColor Green
    }
}

# Function to remove empty directories
function Remove-EmptyDirectories {
    Write-Host "`n📂 Checking for empty directories..." -ForegroundColor Yellow
    
    $emptyDirs = Get-ChildItem -Directory -Recurse | Where-Object { 
        (Get-ChildItem $_.FullName -Force | Measure-Object).Count -eq 0 
    }
    
    if ($emptyDirs) {
        Write-Host "Empty directories found:" -ForegroundColor Red
        $emptyDirs | ForEach-Object { Write-Host "  $($_.FullName)" -ForegroundColor Red }
        
        $confirm = Read-Host "`nDo you want to remove empty directories? (y/N)"
        if ($confirm -eq 'y' -or $confirm -eq 'Y') {
            $emptyDirs | Remove-Item -Force
            Write-Host "✅ Empty directories removed" -ForegroundColor Green
        }
        else {
            Write-Host "⏭️  Skipped directory removal" -ForegroundColor Yellow
        }
    }
    else {
        Write-Host "✅ No empty directories found" -ForegroundColor Green
    }
}

# Function to update .gitignore with common problematic patterns
function Update-GitIgnore {
    Write-Host "`n📋 Checking .gitignore configuration..." -ForegroundColor Yellow
    
    $gitignorePath = ".gitignore"
    if (Test-Path $gitignorePath) {
        $content = Get-Content $gitignorePath -Raw
        
        # Patterns that often cause file reappearance issues
        $problematicPatterns = @(
            "# VS Code auto-generated files",
            ".vscode/settings.json.backup",
            ".vscode/launch.json.backup",
            ".vscode/tasks.json.backup",
            "**/*.tmp",
            "**/*.temp",
            "**/~*",
            "**/.#*",
            "",
            "# OS auto-generated files that may reappear",
            "**/.DS_Store",
            "**/Thumbs.db",
            "**/desktop.ini",
            "",
            "# Git auto-generated files",
            "**/.git/index.lock",
            "**/.git/refs/remotes/*/HEAD"
        )
        
        $needsUpdate = $false
        foreach ($pattern in $problematicPatterns) {
            if ($pattern -and $content -notlike "*$pattern*") {
                $needsUpdate = $true
                break
            }
        }
        
        if ($needsUpdate) {
            Write-Host "Adding additional ignore patterns to prevent file reappearance..." -ForegroundColor Yellow
            $problematicPatterns | Add-Content $gitignorePath
            Write-Host "✅ .gitignore updated with protective patterns" -ForegroundColor Green
        }
        else {
            Write-Host "✅ .gitignore already has protective patterns" -ForegroundColor Green
        }
    }
}

# Function to check for VS Code workspace issues
function Test-VSCodeWorkspace {
    Write-Host "`n🔧 Checking VS Code workspace configuration..." -ForegroundColor Yellow
    
    $settingsPath = ".vscode/settings.json"
    if (Test-Path $settingsPath) {
        try {
            $settings = Get-Content $settingsPath | ConvertFrom-Json
            
            # Check for problematic settings
            $issues = @()
            
            if (-not $settings.'git.autofetch') {
                $issues += "git.autofetch should be disabled"
            }
            
            if (-not $settings.'git.autoStash') {
                $issues += "git.autoStash should be disabled"
            }
            
            if ($issues.Count -gt 0) {
                Write-Host "VS Code settings issues found:" -ForegroundColor Red
                $issues | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
                Write-Host "Consider updating .vscode/settings.json to prevent auto-operations" -ForegroundColor Yellow
            }
            else {
                Write-Host "✅ VS Code settings look good" -ForegroundColor Green
            }
        }
        catch {
            Write-Host "⚠️  Could not parse VS Code settings.json" -ForegroundColor Yellow
        }
    }
    else {
        Write-Host "ℹ️  No VS Code settings found" -ForegroundColor Blue
    }
}

# Function to check git configuration
function Test-GitConfiguration {
    Write-Host "`n⚙️  Checking Git configuration..." -ForegroundColor Yellow
    
    # Check for problematic git configs
    $autoStash = git config --get rebase.autoStash
    $autoSetupRemote = git config --get push.autoSetupRemote
    
    if ($autoStash -eq "true") {
        Write-Host "⚠️  Git rebase.autoStash is enabled - this can cause file reappearance" -ForegroundColor Yellow
        Write-Host "   Consider: git config rebase.autoStash false" -ForegroundColor Gray
    }
    
    if ($autoSetupRemote -eq "true") {
        Write-Host "ℹ️  Git push.autoSetupRemote is enabled" -ForegroundColor Blue
    }
    
    Write-Host "✅ Git configuration checked" -ForegroundColor Green
}

# Main execution
if (-not (Test-GitRepository)) {
    Write-Host "❌ Not in a Git repository!" -ForegroundColor Red
    exit 1
}

Write-Host "📍 Current directory: $(Get-Location)" -ForegroundColor Blue
Write-Host "🌿 Current branch: $(git branch --show-current)" -ForegroundColor Blue

# Run all checks and cleanups
Remove-UntrackedFiles
Remove-EmptyDirectories
Update-GitIgnore
Test-VSCodeWorkspace
Test-GitConfiguration

Write-Host "`n✨ Repository cleanup completed!" -ForegroundColor Green
Write-Host "`n📝 Recommendations to prevent file reappearance:" -ForegroundColor Cyan
Write-Host "   1. Always commit changes before closing VS Code" -ForegroundColor Gray
Write-Host "   2. Use 'git status' before reopening projects" -ForegroundColor Gray
Write-Host "   3. Disable VS Code settings sync if it causes issues" -ForegroundColor Gray
Write-Host "   4. Run this script periodically for maintenance" -ForegroundColor Gray
Write-Host "   5. Use 'git clean -df' to remove untracked files when needed" -ForegroundColor Gray
