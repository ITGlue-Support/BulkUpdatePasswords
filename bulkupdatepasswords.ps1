$api_key = "ITG.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
$path = Read-Host "Enter the file path"
$CSVData = Import-Csv -Path $path
$asset_id_list = $CSVData | Select-Object -ExpandProperty id
$count = 0


foreach($id in $asset_id_list)
{

	$PatchUrl = "https://api.itglue.com/passwords/"+$id
	$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/vnd.api+json")
$headers.Add("x-api-key", $api_key)

$body = @"
{
    `"data`":
         {          
             `"type`": `"passwords`",
             `"attributes`": {
                `"password-category-id`":`"pass_type_id`"
             }
         }
 }

"@

$response = Invoke-RestMethod $PatchUrl -Method 'PATCH' -Headers $headers -Body $body
$response | ConvertTo-Json

$count++
Write-Host "Password No.: "$count
}
