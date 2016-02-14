function Component()
{
    // default constructor
}

Component.prototype.createOperations = function()
{
    // call default implementation to actually install the files!
    component.createOperations();

    if (systemInfo.productType === "windows") {
        component.addOperation("CreateShortcut", "@TargetDir@/share/caneda/README.md", "@StartMenuDir@/README.lnk",
            "workingDirectory=@TargetDir@", "iconPath=%SystemRoot%/system32/SHELL32.dll",
            "iconId=2");
        component.addOperation("CreateShortcut", "@TargetDir@/bin/caneda.exe", "@StartMenuDir@/Caneda.lnk",
            "workingDirectory=@HomeDir@", "iconPath=%SystemRoot%/system32/SHELL32.dll",
            "iconId=194");
    }
}
