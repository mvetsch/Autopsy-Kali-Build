

export TSK_HOME=/tmp/build/tsk
mkdir -p $TSK_HOME

tar -xf libs/libewf-20140608.tar.gz -C $TSK_HOME

cd sleuthkit
./bootstrap
./configure --prefix=$TSK_HOME --with-libewf=$TSK_HOME/libewf-20140608

make
make install
cd ..



mkdir -p $TSK_HOME/bindings/java/dist
mkdir -p $TSK_HOME/bindings/java/lib

cp -v  sleuthkit/bindings/java/lib/*jar $TSK_HOME/bindings/java/lib
cp -v  sleuthkit/bindings/java/dist/Tsk_DataModel.jar $TSK_HOME/bindings/java/dist/Tsk_DataModel_PostgreSQL.jar

cd Autopsy
ant suite.build-zip
cd -


rm -rf autopsy-package/opt/autopsy
mkdir -p  autopsy-package/opt/autopsy
unzip Autopsy/dist/autopsy.zip -d autopsy-package/opt/autopsy

dpkg-deb -b autopsy-package


