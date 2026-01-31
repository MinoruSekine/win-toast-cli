$status = @(scoop status 6>$null | Where-Object { $_.PSObject.Properties['Name'] })

if ($status) {
    # Toast title.
    $num_updatable_apps = $status.Count
    $title = "Scoop: $num_updatable_apps app updates"
    # Toast body.
    $body = $status.Name -join ', '
    # Invoke toast notification.
    & "$PSScriptRoot\..\toast-cli.ps1" -title $title -body $body
}

exit 0
