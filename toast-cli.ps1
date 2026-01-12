param (
    [parameter(mandatory=$true)][string]$body,
    [parameter(mandatory=$false)][string]$title,
    [parameter(mandatory=$false)][string]$detail
)

function Show-Toast {
    param (
        [parameter(mandatory=$false)][string]$title,
        [parameter(mandatory=$false)][string]$message,
        [parameter(mandatory=$false)][string]$detail
    )

    [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
    [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
    [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

    Set-Variable -Name app_id -Value '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe' -Option Constant
    Set-Variable -Name xml -Value @"
<?xml version="1.0" encoding="utf-8"?>
<toast>
    <visual>
        <binding template="ToastGeneric">
            <text>$($title)</text>
            <text>$($message)</text>
            <text>$($detail)</text>
        </binding>
    </visual>
</toast>
"@ -Option Constant
    $xml_document = New-Object Windows.Data.Xml.Dom.XmlDocument
    $xml_document.LoadXml($xml)
    $toast = New-Object Windows.UI.Notifications.ToastNotification $xml_document
    [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($app_id).Show($toast)
}

Show-Toast -title $title -message $body -detail $detail
