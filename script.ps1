#List format, Useful for fewer objects, larger properties 
Get-Process | Format-List -Property Name, Id

#Table format, useful for higher object counts, shorter properties
Get-Process | Format-Table -Property Name, Id


#Table format, useful for single properties in multiple coloums 
Get-Process | Format-Wide -Property { $_.Name + ' ' + $_.Id }

#We are missing the creation time
Get-ChildItem


#Retrieve the existing format data (if available)
#Get-FormatData -TypeName System.Diagnostics.Process | Export-FormatData -Path process.ps1xml

Update-Formatdata -PrependPath ./process.ps1xml

Get-ChildItem
