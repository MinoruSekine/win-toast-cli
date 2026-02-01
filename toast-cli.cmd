@echo off
rem SPDX-License-Identifier: AGPL-3.0-or-later
rem
rem toast-cli.cmd - Wrapper to toast-cli.ps1 to use easily on command prompt.
rem Copyright (C) 2026  Minoru Sekine
rem
rem This program is free software: you can redistribute it and/or modify
rem it under the terms of the GNU Affero General Public License as
rem published by the Free Software Foundation, either version 3 of the
rem License, or (at your option) any later version.
rem
rem This program is distributed in the hope that it will be useful,
rem but WITHOUT ANY WARRANTY; without even the implied warranty of
rem MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
rem GNU Affero General Public License for more details.
rem
rem You should have received a copy of the GNU Affero General Public License
rem along with this program.  If not, see <https://www.gnu.org/licenses/>.

setlocal

set "ps_script_name=toast-cli.ps1"

powershell %~dp0%ps_script_name% %*

exit /b %ERRORLEVEL%

