* get publish api from [powershellgallery](https://www.powershellgallery.com/account/apikeys)
    
* pubish it:
```powershell
Publish-Module -Path .\directory-stack\ -NuGetApiKey $your_api -Verbose
```