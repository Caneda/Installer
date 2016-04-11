Caneda Installer
================
This is the Caneda Installer source code to generate installers for Windows. For other operating systems, the installation is straighforward, and an installer is not neccessary. In some Linux distributions Caneda is available from the official repositories, making the whole process even simplier.

Following, the complete release process to obtain an installer for Windows is described. This is not normally done by the final users, but by the release manager instead, every time a new release of Caneda is available. The resulting
binary installer should be then uploaded to the official distribution channels.

The first part of the process is to obtain Caneda's binaries. The steps are similar to a normal compilation.

## Requirements
In order to compile Caneda sources, you will need the following libraries installed in your system:

  * Cmake
  * Qt
  * Qwt
  * Qt-Installer-Framework

In the following sections it is assumed the previous requirements are installed in the default directory locations.

## Compilation and Installation
Next we must compile and install Caneda, using the following steps:

Unpack the distribution tarball.

Edit the root `CMakeLists.txt` file and change the line `SET( CMAKE_BUILD_TYPE Debug )` to `SET( CMAKE_BUILD_TYPE Release )` to generate a release binary. This allows the use of the release versions of the Qt dll libraries, giving place to a smaller package.

Open the mingw32 command prompt with administrative privileges (using the context menu).

Change into the source directory:

`$ cd caneda-<version>`

Create a new directory for Cmake to work in:

`$ mkdir build`

Change into the recently created directory:

`$ cd build`

Configure the source package for your system:

`$ cmake -G "MinGW Makefiles" ../`

Compile the package:

`$ mingw32-make`

Install Caneda:

`$ mingw32-make install`

Although not neccessary, to be able to test the binaries from QtCreator the Qwt libraries' location (`C:/Qwt-6.1.2/lib/`) must be added to the _Run_ profile inside the PATH definitions.

## Windows Deployment
In order to execute Caneda, the needed DLL libraries must reside in the `bin` directory. There is a Qt tool named _windeployqt_ that automates that but some DLLs must be copied mannualy.

Change into Caneda `bin` installed directory:

`cd "C:\Program Files (x86)\Caneda\bin\"`

Execute the _windeployqt_ tool:

`windeployqt --release caneda.exe`

Manually copy the file `Qt5OpenGL.dll` into the `bin` installed directory (`C:\Program Files (x86)\Caneda\bin\`). The DLL file `Qt5OpenGL.dll` is located in `C:\Qt\5.5\mingw492_32\bin`.

Manually copy the file `qwt.dll` into the `bin` installed directory (`C:\Program Files (x86)\Caneda\bin\`). The DLL file `qwt.dll` is located in `C:\Qwt-6.1.2\lib`.


## ngspice Instalation
To be able to simulate circuits, a circuit simulator must be installed. The recommended software is [ngspice](http://ngspice.sourceforge.net/). Once installed, if the binaries are added to the system _PATH_, no additional steps should be required. However to make the installation foolproof, ngspice is bundled with Caneda.

Download the last ngspice binary packages for Windows from [ng-spice-rework](https://sourceforge.net/projects/ngspice/files/ng-spice-rework/26/). In particular, the file `ngspice-26_140112.zip` contains the Windows binaries.

Mannually copy the files inside the `bin` directory from ngspice to the `bin` directory from Caneda (`C:\Program Files (x86)\Caneda\bin\`).

## Caneda Installer Compilation
The final step is to create an installer with the previously generated files and directories. For this step, the sources contained in this repository are used. The tools used are provided by Qt, under the folder `C:\Qt\QtIFW2.0.1\bin\`, in case that folder is not added to your system path you can run the following commands from inside that folder.

Update the xmls in this repository to reflect Caneda's changes. At minimum the software versions should be bumped. Copy the repository files into your system, for example in the folder `C:\sources\`.

Generate a 7z file from the Caneda installed files.

`archivegen caneda.7z "C:\Program Files (x86)\Caneda\*"`

Mannualy copy the generated 7z file into the folder `C:\sources\packages\com.caneda.caneda\data`

Create the installer by executing the binarycreator tool:

`binarycreator -c C:\sources\config\config.xml -p C:\sources\packages CanedaInstaller.exe`

References
==========
  * [Qt-Installer-Framework](https://download.qt.io/official_releases/qt-installer-framework/)
  * [Qt-Installer-Framework Overview](http://doc.qt.io/qtinstallerframework/ifw-overview.html) 
  * [Qt-Installer-Framework Tutorial](http://doc.qt.io/qtinstallerframework/ifw-tutorial.html)