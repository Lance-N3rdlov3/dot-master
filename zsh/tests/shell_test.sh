#!/bin/bash

# Shell configuration tests
# Run this script from dot-master directory

echo "=== ZSH Configuration Tests ==="

# Test 1: Check files exist
test_files_exist() {
    echo "[TEST] Checking if zsh files exist..."
    local files=(
        "zsh/.zshenv"
        "zsh/.zshprofile"
        "zsh/.zshrc"
    )

    for file in "${files[@]}"; do
        if [[ -f "$file" ]]; then
            echo "  ✓ $(basename "$file") exists"
        else
            echo "  ✗ $(basename "$file") missing"
            return 1
        fi
    done
}

# Test 2: Check conf.d files
test_conf_d_files() {
    echo "[TEST] Checking conf.d files..."
    local files=(
        "10-environment.zsh"
        "20-paths.zsh"
        "30-options.zsh"
        "40-completion.zsh"
        "50-bindings.zsh"
        "80-aliases.zsh"
        "90-functions.zsh"
    )

    for file in "${files[@]}"; do
        if [[ -f "zsh/conf.d/$file" ]]; then
            echo "  ✓ $file exists"
        else
            echo "  ✗ $file missing"
            return 1
        fi
    done
}

# Test 3: Check platform configs
test_platform_configs() {
    echo "[TEST] Checking platform configs..."
    local platforms=("arch.zsh" "macos.zsh" "linux.zsh")

    for platform in "${platforms[@]}"; do
        if [[ -f "zsh/platform/$platform" ]]; then
            echo "  ✓ $platform exists"
        else
            echo "  ✗ $platform missing"
            return 1
        fi
    done
}

# Test 4: Check tool configs
test_tool_configs() {
    echo "[TEST] Checking tool configs..."
    local tools=("bat.zsh" "eza.zsh" "fzf.zsh" "starship.zsh")

    for tool in "${tools[@]}"; do
        if [[ -f "zsh/tools/$tool" ]]; then
            echo "  ✓ $tool exists"
        else
            echo "  ✗ $tool missing"
            return 1
        fi
    done
}

# Test 5: Check for syntax errors (basic)
test_syntax() {
    echo "[TEST] Checking for syntax errors..."
    local error_count=0

    for file in zsh/conf.d/*.zsh zsh/platform/*.zsh zsh/tools/*.zsh; do
        if [[ -f "$file" ]] && ! zsh -n "$file" 2>/dev/null; then
            echo "  ✗ Syntax error in: $file"
            ((error_count++))
        fi
    done

    if [[ $error_count -eq 0 ]]; then
        echo "  ✓ No syntax errors found"
        return 0
    else
        echo "  ✗ Found $error_count syntax errors"
        return 1
    fi
}

# Test 6: Check for duplicate function definitions
test_duplicate_functions() {
    echo "[TEST] Checking for duplicate function definitions..."
    local duplicates=$(grep -h "^function " zsh/conf.d/*.zsh zsh/platform/*.zsh zsh/tools/*.zsh 2>/dev/null | sort | uniq -d | wc -l)

    if [[ $duplicates -eq 0 ]]; then
        echo "  ✓ No duplicate function definitions found"
        return 0
    else
        echo "  ✗ Found $duplicates duplicate function definitions"
        return 1
    fi
}

# Test 7: Check Starship themes
test_starship_themes() {
    echo "[TEST] Checking Starship themes..."
    local themes=("dev.toml" "sysadmin.toml" "pentest.toml" "cloud.toml" "mobile.toml" "minimal.toml" "fun.toml")

    for theme in "${themes[@]}"; do
        if [[ -f "starship/themes/$theme" ]]; then
            echo "  ✓ $theme exists"
        else
            echo "  ✗ $theme missing"
            return 1
        fi
    done
}

# Test 8: Check backup exists
test_backup() {
    echo "[TEST] Checking if backup exists..."
    local backup_dir="/tmp/zsh-backup-20251226"

    if [[ -d "$backup_dir" ]]; then
        echo "  ✓ Backup exists at $backup_dir"
        return 0
    else
        echo "  ✗ Backup not found"
        return 1
    fi
}

# Run all tests
main() {
    local passed=0
    local failed=0

    test_files_exist && ((passed++)) || ((failed++))
    test_conf_d_files && ((passed++)) || ((failed++))
    test_platform_configs && ((passed++)) || ((failed++))
    test_tool_configs && ((passed++)) || ((failed++))
    test_syntax && ((passed++)) || ((failed++))
    test_duplicate_functions && ((passed++)) || ((failed++))
    test_starship_themes && ((passed++)) || ((failed++))
    test_backup && ((passed++)) || ((failed++))

    echo ""
    echo "=== Test Results ==="
    echo "Passed: $passed"
    echo "Failed: $failed"
    echo "Total:  $((passed + failed))"

    if [[ $failed -eq 0 ]]; then
        echo ""
        echo "✓ All tests passed!"
        return 0
    else
        echo ""
        echo "✗ Some tests failed"
        return 1
    fi
}

main "$@"
