# Funciones
function Show-NetworkInfo {
    Get-NetAdapter
    Get-NetIPAddress -AddressFamily IPv4
    Get-NetRoute -AddressFamily IPv4
}

function Set-NetworkAdapter {
    $adapter = Get-NetAdapter | Out-GridView -Title "Seleccione un adaptador de red" -PassThru
    $IPv4Address = Read-Host "Ingrese la nueva direccion IPv4"
    $SubnetMask = Read-Host "Ingrese la nueva mascara de subred"
    $Gateway = Read-Host "Ingrese la nueva direccion de gateway"

    New-NetIPAddress -InterfaceIndex $adapter.ifIndex -IPAddress $IPv4Address -PrefixLength $SubnetMask -DefaultGateway $Gateway
}

function Show-RunningProcesses {
    Get-Process
}

function Stop-ProcessById {
    $process = Get-Process | Out-GridView -Title "Seleccione el proceso a detener" -PassThru
    Stop-Process -Id $process.Id -Force
}

function Show-Services {
    Get-Service
}

function Start-ServiceByName {
    $service = Get-Service | Out-GridView -Title "Seleccione el servicio a iniciar" -PassThru
    Start-Service -Name $service.Name
}

function Stop-ServiceByName {
    $service = Get-Service | Out-GridView -Title "Seleccione el servicio a detener" -PassThru
    Stop-Service -Name $service.Name
}

function Backup-Files {
    $source = Read-Host "Introduzca la ruta del directorio a respaldar"
    $destination = Read-Host "Introduzca la ruta del directorio donde se guardaran los archivos respaldados"
    Copy-Item -Path $source -Destination $destination -Recurse -Force
}

function Show-Users {
    Get-LocalUser
}

function Add-User {
    $username = Read-Host "Ingrese el nombre de usuario"
    $password = Read-Host "Ingrese el password" -AsSecureString
    $description = Read-Host "Ingrese una descripcion (opcional)"

    New-LocalUser -Name $username -Password $password -Description $description -FullName $username
}

function Remove-User {
    $user = Get-LocalUser | Out-GridView -Title "Seleccione el usuario a eliminar" -PassThru
    Remove-LocalUser -Name $user.Name
}

function Show-HardwareInfo {
    Get-CimInstance -ClassName Win32_ComputerSystem
    Get-CimInstance -ClassName Win32_Processor
    Get-CimInstance -ClassName Win32_OperatingSystem
    Get-CimInstance -ClassName Win32_LogicalDisk
}

# Menu principal
do {
    Clear-Host
    Write-Host "Seleccione una opcion:"
    Write-Host "1. Informacion de Red"
    Write-Host "2. Procesos en Ejecucion"
    Write-Host "3. Servicios del Sistema"
    Write-Host "4. Realizar Backup de Archivos"
    Write-Host "5. Usuarios del Sistema"
    Write-Host "6. Informacion del Hardware"
    Write-Host "7. Salir"

    $input = Read-Host "Ingrese el numero de opcion"

    switch ($input) {
        '1' {
            do {
                Clear-Host
	Write-Host "Submenu de Red:"
                Write-Host "1. Mostrar informacion de red"
                Write-Host "2. Cambiar configuracion de adaptador de red"
                Write-Host "3. Regresar al menu principal"
                $inputNetwork = Read-Host "Ingrese el numero de opcion"

                switch ($inputNetwork) {
                    '1' {
                        Show-NetworkInfo
                        pause
                    }
                    '2' {
                        Set-NetworkAdapter
                        pause
                    }
                    '3' {
                        break
                    }
                    default {
                        Write-Host "Por favor, seleccione una opcion valida."
                        pause
                    }
                }
            } while ($inputNetwork -ne '3')
        }
        '2' {
            do {
                Clear-Host
                Write-Host "Submenu de Procesos:"
                Write-Host "1. Mostrar procesos en ejecucion"
                Write-Host "2. Detener proceso por ID"
                Write-Host "3. Regresar al menu principal"
                $inputProcess = Read-Host "Ingrese el numero de opcion"

                switch ($inputProcess) {
                    '1' {
                        Show-RunningProcesses
                        pause
                    }
                    '2' {
                        Stop-ProcessById
                        pause
                    }
                    '3' {
                        break
                    }
                    default {
                        Write-Host "Por favor, seleccione una opcion valida."
                        pause
                    }
                }
            } while ($inputProcess -ne '3')
        }
        '3' {
            do {
                Clear-Host
                Write-Host "Submenu de Servicios:"
                Write-Host "1. Mostrar servicios del sistema"
                Write-Host "2. Iniciar servicio por nombre"
                Write-Host "3. Detener servicio por nombre"
                Write-Host "4. Regresar al menu principal"
                $inputService = Read-Host "Ingrese el numero de opcion"

                switch ($inputService) {
                    '1' {
                        Show-Services
                        pause
                    }
                    '2' {
                        Start-ServiceByName
                        pause
                    }
                    '3' {
                        Stop-ServiceByName
                        pause
                    }
                    '4' {
                        break
                    }
                    default {
                        Write-Host "Por favor, seleccione una opcion valida."
                        pause
                    }
                }
            } while ($inputService -ne '4')
        }
        '4' {
            Backup-Files
            pause
        }
        '5' {
            do {
                Clear-Host
                Write-Host "Submenu de Usuarios:"
                Write-Host "1. Mostrar usuarios del sistema"
                Write-Host "2. Agregar usuario"
                Write-Host "3. Eliminar usuario"
                Write-Host "4. Regresar al menu principal"
                $inputUser = Read-Host "Ingrese el numero de opcion"

                switch ($inputUser) {
                    '1' {
                        Show-Users
                        pause
                    }
                    '2' {
                        Add-User
                        pause
                    }
                    '3' {
                        Remove-User
                        pause
                    }
                    '4' {
                        break
                    }
                    default {
                        Write-Host "Por favor, seleccione una opcion valida."
                        pause
                    }
                }
            } while ($inputUser -ne '4')
        }
        '6' {
            Show-HardwareInfo
            pause
        }
        '7' {
            exit
        }
        default {
            Write-Host "Por favor, seleccione una opcion valida."
            pause
        }
    }
} while ($input -ne '7')			