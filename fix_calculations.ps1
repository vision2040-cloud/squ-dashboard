$content = Get-Content .\index.html -Raw

# Fix 1: Replace weightedComp function - include null values as 0%
$oldWeightedComp = @"
  function weightedComp(arr){
    var valid=arr.filter(function(x){return x.completion!==null&&x.completion!==undefined&&!isNaN(x.completion);});
    if(!valid.length)return null;
    var withW=valid.filter(function(x){var w=x.weight;return (w!=null)&&!isNaN(w)&&w>0;});
    var sw=0, swp=0;
    var src=withW.length?withW:valid;
    src.forEach(function(x){
      var w=(withW.length)?x.weight:1;
      var c=Math.min(Math.max(x.completion,0),100); // clamp 0..100
      sw+=w; swp+=w*c;
    });
    if(sw<=0)return null;
    return Math.round(swp/sw);
  }
"@

$newWeightedComp = @"
  function weightedComp(arr){
    // FIX: Include ALL indicators (missing = 0%, not excluded)
    if(!arr||arr.length===0)return 0;
    var sw=0, swp=0;
    arr.forEach(function(x){
      var w=(x.weight&&!isNaN(parseFloat(x.weight)))?parseFloat(x.weight):1;
      // Treat null/undefined as 0% instead of excluding the element
      var c=Math.min(Math.max((x.completion===null||x.completion===undefined||isNaN(parseFloat(x.completion)))?0:parseFloat(x.completion),0),100);
      sw+=w; swp+=w*c;
    });
    if(sw<=0)return 0;
    return Math.round(swp/sw);
  }
"@

$content = $content -replace [regex]::Escape($oldWeightedComp), $newWeightedComp

# Fix 2: Replace rOv function - include null values as 0%
$oldROv = @"
  function rOv(obj,arr){
    var valid=arr.filter(function(x){return x[obj]!==null&&x[obj]!==undefined&&!isNaN(x[obj]);});
    if(!valid.length)return null;
    return Math.round(valid.reduce(function(s,x){return s+x[obj];},0)/valid.length);
  }
"@

$newROv = @"
  function rOv(obj,arr){
    // FIX: Include ALL elements (missing = 0%, not excluded)
    if(!arr||arr.length===0)return 0;
    var sum=0;
    arr.forEach(function(x){
      // Treat null/undefined as 0% instead of excluding the element
      var val=(x[obj]===null||x[obj]===undefined||isNaN(parseFloat(x[obj])))?0:parseFloat(x[obj]);
      sum+=val;
    });
    return Math.round(sum/arr.length);
  }
"@

$content = $content -replace [regex]::Escape($oldROv), $newROv

# Save the fixed file
$content | Set-Content .\index.html

Write-Host "Fixed calculations applied successfully!"
