# SPDX-License-Identifier: AGPL-3.0-or-later
#
# toast-cli.ps1 - Show toast notification by command-line on Windows.
# Copyright (C) 2026  Minoru Sekine
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

param (
    [Parameter(Mandatory = $true)][string]$body,
    [Parameter(Mandatory = $false)][string]$title,
    [Parameter(Mandatory = $false)][string]$detail
)

function Show-Toast {
    param (
        [Parameter(Mandatory = $false)][string]$title,
        [Parameter(Mandatory = $false)][string]$message,
        [Parameter(Mandatory = $false)][string]$detail
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
