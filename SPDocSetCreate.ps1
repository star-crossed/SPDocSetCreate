Set-Location "C:\Users\pchoquette\Source\Repos\PnP-Sites-Core\Assemblies\16" # Location of DLL's
Add-Type -Path (Resolve-Path "Microsoft.SharePoint.Client.dll")
Add-Type -Path (Resolve-Path "Microsoft.SharePoint.Client.Runtime.dll")
Add-Type -Path (Resolve-Path "Microsoft.SharePoint.Client.DocumentManagement.dll")

$ctx = New-Object Microsoft.SharePoint.Client.ClientContext("https://starcrossed.sharepoint.com")
$password = Read-Host -Prompt "Enter password" -AsSecureString
$ctx.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials("pchoquette@starcrossed.ninja", $password)

$list = $ctx.Web.Lists.GetByTitle("Documents")
$ctx.Load($list)
$parentFolder = $list.RootFolder
$listContentTypes = $list.ContentTypes
$ctx.Load($listContentTypes)
$myContentType = $listContentTypes.GetByID("0x0120D520000535852D838B324FA8890A7BB22EE31F")
$ctx.Load($myContentType)
$ctx.ExecuteQuery()

[Microsoft.SharePoint.Client.DocumentSet.DocumentSet]::Create($ctx, $parentFolder, "Whatever document set name you want goes here", $myContentType.Id)
$ctx.ExecuteQuery()
