#Install dependencies globally
${function:npmg} = { npm i -g }
#Install and save to dependencies in your package.json
${function:npmS} = { npm i -S }
#Install and save to dev-dependencies in your package.json
${function:npmD} = { npm i -D }
#Run npm start Dev
${function:npmRD} = { npm run dev }
#Run npm start server
${function:npmRS} = { npm run server }
#Run npm build
${function:npmB} = { npm run build }

#PSSCRIPTANALYZER -PSUseShouldProcessForStateChangingF
function Remove-Node-Modules { get-childitem -Include node_modules -Recurse -force | Remove-Item -Force -Recurse }

function Get-Laravel-VueJs-Compilation() {
    $currentDir = Get-Location
    $appsDir = Join-Path -Path $currentDir -ChildPath "\resources\apps"
    Get-ChildItem $appsDir | ForEach-Object { Set-Location $_.FullName; npm run build }
}
