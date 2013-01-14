#!/bin/sh

cd
mkdir sources
cd sources

wget http://download.osgeo.org/geos/geos-3.3.2.tar.bz2
tar -xjf geos-3.3.2.tar.bz2
cd geos-3.3.2
./configure
make && make install
cd ..

wget http://download.osgeo.org/proj/proj-4.7.0.tar.gz
tar -zxvf proj-4.7.0.tar.gz
cd proj-4.7.0
./configure
make && make install
cd ..

wget  http://download.osgeo.org/gdal/gdal-1.9.0.tar.gz
tar -zxvf gdal-1.9.0.tar.gz
cd gdal-1.9.0
./configure
make && make install
cd ..

cd sources
#rm -r geos-3.3.2* proj-4.7.0* gdal-1.9.0*
cd
