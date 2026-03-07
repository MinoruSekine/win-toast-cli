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

[CmdletBinding()]
param (
    [string]$body,
    [string]$title,
    [string]$detail,
    [switch]$version
)

$ToastCliVersion = '0.0.2'

function Show-Toast {
    param (
        [Parameter(Mandatory = $false)][string]$title,
        [Parameter(Mandatory = $false)][string]$message,
        [Parameter(Mandatory = $false)][string]$detail
    )

    Import-Module BurntToast

    New-BurntToastNotification -Text $title, $message, $detail
}


if ($version) {
    Write-Output "$($MyInvocation.MyCommand.Name) $ToastCliVersion"
} else {
    if ($body) {
        if (-not (Get-Module -ListAvailable BurntToast)) {
            Write-Error @'
Missing required module: BurntToast.
Install it with `Install-Module -Name BurntToast -Scope CurrentUser`.
'@
            exit 1
        }

        Show-Toast -title $title -message $body -detail $detail
    } else {
        Write-Error "Missing required argument: -Body. See -? for usage."
        exit 1
    }
}

exit 0
