$ie = New-Object -ComObject 'internetExplorer.Application'
$ie.Visible= $true

function login {
    $ie.Navigate("https://demo.moodle.net/login/index.php")
    while ($ie.Busy -eq $true){Start-Sleep -seconds 1;}
    $ie.document.querySelector('#username').value = 'admin'
    $ie.document.querySelector('#password').value = 'sandybox'
    $ie.document.querySelector('#loginbtn').click()
    while ($ie.Busy -eq $true){Start-Sleep -seconds 1;}
    if ($ie.Document.querySelector('span.usertext').textcontent -ne "Admin User") { throw "login couldn't be verified" }

}

function logout {
    $ie.Navigate("https://demo.moodle.net/login/logout.php")
    while ($ie.Busy -eq $true){Start-Sleep -seconds 1;}
    if ($ie.document.querySelector('input[type="submit"]').value -ne $null ) { $ie.document.querySelector('input[type="submit"]').click()}
    while ($ie.Busy -eq $true){Start-Sleep -seconds 1;}
    if ($ie.document.querySelector('input[type="submit"]').value -ne $null ) { $ie.document.querySelector('input[type="submit"]').click()}
}

try {
    login
    write-host "Login to 'moodle-admin-demo' was successful." -ForegroundColor green
} catch {
    log-json "login-failed" "logging in to 'moodle-admin-demo' was not successful. Even trying to logoff and re-login failed. Please check URI and Credentials!" $env:logFile
    write-host "Login to 'moodle-admin-demo' failed!" -ForegroundColor red
}
logout
$ie.quit()
