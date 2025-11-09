#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Pester tests for vSphere 8 training content validation
.DESCRIPTION
    Automated tests to validate training content structure and quality
#>

BeforeAll {
    $ProjectRoot = Split-Path $PSScriptRoot -Parent
}

Describe "Training Content Structure" {
    Context "Module Structure" {
        It "Should have 10 training modules" {
            $modules = Get-ChildItem "$ProjectRoot/modules" -Directory
            $modules.Count | Should -Be 10
        }
        
        It "Each module should have README.md" {
            $modules = Get-ChildItem "$ProjectRoot/modules" -Directory
            foreach ($module in $modules) {
                "$($module.FullName)/README.md" | Should -Exist
            }
        }
        
        It "Each module README should have Learning Objectives" {
            $moduleReadmes = Get-ChildItem "$ProjectRoot/modules" -Recurse -Name "README.md"
            foreach ($readme in $moduleReadmes) {
                $content = Get-Content "$ProjectRoot/modules/$readme" -Raw
                $content | Should -Match "## Learning Objectives"
            }
        }
    }
    
    Context "Lab Structure" {
        It "Should have lab directory" {
            "$ProjectRoot/labs" | Should -Exist
        }
        
        It "Lab files should follow naming convention" {
            $labs = Get-ChildItem "$ProjectRoot/labs" -Filter "*.md"
            foreach ($lab in $labs) {
                $lab.Name | Should -Match "^lab-\d{2}-.*\.md$"
            }
        }
    }
    
    Context "Documentation Quality" {
        It "Should have instructor guide" {
            "$ProjectRoot/docs/INSTRUCTOR_GUIDE.md" | Should -Exist
        }
        
        It "README should have badges" {
            $readme = Get-Content "$ProjectRoot/README.md" -Raw
            $readme | Should -Match "!\[.*\]\(.*badge.*\)"
        }
    }
}

Describe "PowerShell Scripts" {
    Context "Script Validation" {
        It "All PowerShell scripts should have valid syntax" {
            $scripts = Get-ChildItem $ProjectRoot -Recurse -Filter "*.ps1"
            foreach ($script in $scripts) {
                { 
                    $null = [System.Management.Automation.PSParser]::Tokenize(
                        (Get-Content $script.FullName -Raw), [ref]$null
                    )
                } | Should -Not -Throw
            }
        }
        
        It "Scripts should have help documentation" {
            $scripts = Get-ChildItem "$ProjectRoot/scripts" -Filter "*.ps1"
            foreach ($script in $scripts) {
                $content = Get-Content $script.FullName -Raw
                $content | Should -Match "\.SYNOPSIS"
                $content | Should -Match "\.DESCRIPTION"
            }
        }
    }
}

Describe "Content Quality" {
    Context "Markdown Validation" {
        It "Markdown files should not have broken internal links" {
            $markdownFiles = Get-ChildItem $ProjectRoot -Recurse -Filter "*.md"
            foreach ($file in $markdownFiles) {
                $content = Get-Content $file.FullName -Raw
                $links = [regex]::Matches($content, '\[.*?\]\(((?!http).*?)\)')
                foreach ($link in $links) {
                    $linkPath = $link.Groups[1].Value
                    if ($linkPath -match '^\.\.?/') {
                        $fullPath = Join-Path (Split-Path $file.FullName) $linkPath
                        $fullPath | Should -Exist -Because "Link in $($file.Name) points to non-existent file: $linkPath"
                    }
                }
            }
        }
    }
