#!/usr/bin/env powershell
# Test the calculation functions

Write-Host "=== Testing Fixed Calculation Functions ===" -ForegroundColor Cyan

# Test 1: weightedComp
Write-Host "`nTest 1: weightedComp (weighted average)" -ForegroundColor Yellow

$testData = @(
  @{completion=100; weight=1},
  @{completion=80; weight=1},
  @{completion=$null; weight=1},
  @{completion=$null; weight=1},
  @{completion=$null; weight=1}
)

# Simulate the new function
function Test-WeightedComp($arr) {
  if (!$arr -or $arr.Count -eq 0) { return 0 }
  $sw = 0
  $swp = 0
  
  foreach ($x in $arr) {
    $w = if ($x.weight -and -not [double]::IsNaN($x.weight)) { [double]$x.weight } else { 1 }
    
    if ($x.completion -eq $null -or [double]::IsNaN($x.completion)) {
      $c = 0
    } else {
      $c = [Math]::Min([Math]::Max($x.completion, 0), 100)
    }
    
    $sw += $w
    $swp += $w * $c
  }
  
  if ($sw -le 0) { return 0 }
  return [Math]::Round($swp / $sw)
}

$result = Test-WeightedComp $testData
Write-Host "Result: $result%" -ForegroundColor Green
Write-Host "Expected: 36% (100+80+0+0+0)/5" -ForegroundColor Gray

if ($result -eq 36) {
  Write-Host "[PASS] Result is correct!" -ForegroundColor Green
} else {
  Write-Host "[FAIL] Result is incorrect!" -ForegroundColor Red
}

# Test 2: meanComp
Write-Host "`nTest 2: meanComp (simple average)" -ForegroundColor Yellow

function Test-MeanComp($arr) {
  if (!$arr -or $arr.Count -eq 0) { return 0 }
  $sum = 0
  
  foreach ($x in $arr) {
    if ($x.completion -eq $null -or [double]::IsNaN($x.completion)) {
      $c = 0
    } else {
      $c = $x.completion
    }
    $sum += $c
  }
  
  return [Math]::Round($sum / $arr.Count)
}

$result = Test-MeanComp $testData
Write-Host "Result: $result%" -ForegroundColor Green
Write-Host "Expected: 36% (100+80+0+0+0)/5" -ForegroundColor Gray

if ($result -eq 36) {
  Write-Host "[PASS] Result is correct!" -ForegroundColor Green
} else {
  Write-Host "[FAIL] Result is incorrect!" -ForegroundColor Red
}

# Test 3: Overall average calculation
Write-Host "`nTest 3: Overall average (L2, L3, L4)" -ForegroundColor Yellow

$l2 = 75
$l3 = $null
$l4 = 50

$vals = @($l2, $l3, $l4) | ForEach-Object {
  if ($_ -eq $null -or [double]::IsNaN($_)) { 0 } else { $_ }
}

$overall = [Math]::Round(($vals | Measure-Object -Sum).Sum / $vals.Count)

Write-Host "L2: $l2%, L3: null, L4: $l4%" -ForegroundColor Gray
Write-Host "Result: $overall%" -ForegroundColor Green
Write-Host "Expected: 42% (75+0+50)/3" -ForegroundColor Gray

if ($overall -eq 42) {
  Write-Host "[PASS] Result is correct!" -ForegroundColor Green
} else {
  Write-Host "[FAIL] Result is incorrect!" -ForegroundColor Red
}

Write-Host "`n=== Test Complete ===" -ForegroundColor Cyan
