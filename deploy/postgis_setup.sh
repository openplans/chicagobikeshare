#!/bin/sh

cd
mkdir sources
cd sources

if [ ! -d geos-3.3.2 ]
then
  wget http://download.osgeo.org/geos/geos-3.3.2.tar.bz2
  tar -xjf geos-3.3.2.tar.bz2
fi
cd geos-3.3.2
make install || ( ./configure && make && make install && )
cd ..

if [ ! -d proj-4.7.0 ]
then
  wget http://download.osgeo.org/proj/proj-4.7.0.tar.gz
  tar -zxvf proj-4.7.0.tar.gz
fi
cd proj-4.7.0
make install || ( ./configure && make && make install && )
cd ..

if [ ! -d gdal-1.9.0 ]
then
  wget  http://download.osgeo.org/gdal/gdal-1.9.0.tar.gz
  tar -zxvf gdal-1.9.0.tar.gz
fi
cd gdal-1.9.0
make install || ( ./configure && make && make install && )
cd ..

#rm -r geos-3.3.2* proj-4.7.0* gdal-1.9.0*
cd
