# this function is run when a koan file changes
function Run-Rake {
	# clear the screen
	cls
	
	# run rake 
	& rake
	
	# tell folks how to get off this crazy train
	Write-Host ""
	Write-Host "Press any key to exit Auto Koan..."
}

# run rake once so we know where we are
Run-Rake

# create a FileSystemWatcher on the currect directory
$watcher = New-object System.IO.FileSystemWatcher $(pwd)
$watcher.Filter = "about_*.rb" 
$watcher.IncludeSubdirectories = $false

# set a one second timeout 
$timeout = 1000

# Loop till we see a key press
do {
  $result = $watcher.WaitForChanged("Changed", $timeout)
  
	if ( -not $result.TimedOut) { 
    Run-Rake
	}

} until ( [System.Console]::KeyAvailable )

Write-Host ""
Write-Host "Auto Koan Exiting!"
