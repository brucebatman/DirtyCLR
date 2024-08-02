$dllPath = "C:\Users\admin\Desktop\DirtyCLR.dll"

# Load the DLL
$assembly = [System.Reflection.Assembly]::LoadFrom($dllPath)

# Get the Type
$type = $assembly.GetType("DirtyCLRDomain")

if ($type -eq $null) {
    Write-Host "Type not found. Please check the namespace and class name."
    return
}

# Get the default constructor (parameterless)
$constructor = $type.GetConstructor([Type[]]@())

if ($constructor -eq $null) {
    Write-Host "No parameterless constructor found."
    return
}

# Create an instance of the class using the parameterless constructor
$instance = $constructor.Invoke(@())

# Get the InitializeNewDomain method
$method = $type.GetMethod("InitializeNewDomain", [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::Instance)

if ($method -eq $null) {
    Write-Host "Method InitializeNewDomain not found."
    return
}

# Execute the method
$method.Invoke($instance, @([AppDomainSetup]::new()))
