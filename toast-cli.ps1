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

[CmdletBinding(DefaultParameterSetName = "Default")]
param (
    [string]$body,
    [string]$title,
    [string]$detail,
    [string]$link,
    [string]$url,
    [switch]$version
)

$ToastCliVersion = '0.0.2'

function Show-Toast {
    [CmdletBinding(DefaultParameterSetName = "Default")]
    param (
        [Parameter(Mandatory = $false)]
        [string]$title,
        [Parameter(Mandatory = $false)]
        [string]$body,
        [Parameter(Mandatory = $false)]
        [string]$detail,
        [Parameter(Mandatory = $false)]
        [string]$link,
        [Parameter(Mandatory = $false)]
        [string]$url
    )

    # Check BurntToast availability.
    if (-not (Get-Module -ListAvailable BurntToast)) {
        throw @'
Missing required module: BurntToast.
Install it with `Install-Module -Name BurntToast -Scope CurrentUser`.
'@
    }

    # Parameters check.
    if (-not $body) {
        throw [System.ArgumentException]@'
Missing required argument: -Body. See -? for usage.
'@
    }
    if ($link -xor $url) {
        throw [System.ArgumentException]@'
Both -link and -url are required for toast notification with link
'@
    }

    Import-Module BurntToast

    if ($link -and $url) {
        $button = New-BTButton -Content $link -Arguments $url
        New-BurntToastNotification `
          -Text $title, $body, $detail -Button $button
    } else {
        New-BurntToastNotification -Text $title, $body, $detail
    }
}

if ($version) {
    Write-Output "$($MyInvocation.MyCommand.Name) $ToastCliVersion"
} else {
    Show-Toast @PSBoundParameters
}

exit 0
