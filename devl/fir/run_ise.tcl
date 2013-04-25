#########################
###  DEFINE VARIABLES ###
#########################
set DesignName	"fir"
set FamilyName	"VIRTEX5"
set DeviceName	"xc5vfx130t"
set PackageName	"FF1738"
set SpeedGrade	"-2"
set TopModule	"fir"
set EdifFile	"fir.edn"
if {![file exists $DesignName.ise]} {

project new $DesignName.ise

project set family $FamilyName
project set device $DeviceName
project set package $PackageName
project set speed $SpeedGrade

xfile add $EdifFile
if {[file exists synplicity.ucf]} {
    xfile add synplicity.ucf
}

project set "Netlist Translation Type" "Timestamp"
project set "Other NGDBuild Command Line Options" "-verbose"
project set "Generate Detailed MAP Report" TRUE

project close
}


file delete -force $DesignName\_xdb

project open $DesignName.ise

process run "Implement Design" -force rerun_all

project close

