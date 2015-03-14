#-------------------------------------------------------------------------------
# Helper macro to setup installer packages
macro(setup_package)
    set(PACKAGE_ROOT_DIR D:/Workspace/omegalib/master/install/packages/${PACKAGE_NAME})
    set(PACKAGE_DIR ${PACKAGE_ROOT_DIR}/data)
    file(REMOVE_RECURSE D:/Workspace/omegalib/master/install/packages/${PACKAGE_NAME})
    file(MAKE_DIRECTORY D:/Workspace/omegalib/master/install/packages/${PACKAGE_NAME}/data)
    file(MAKE_DIRECTORY D:/Workspace/omegalib/master/install/packages/${PACKAGE_NAME}/meta)
    configure_file(${PACKAGE_CONFIG_TEMPLATE} ${PACKAGE_ROOT_DIR}/meta/package.xml)
endmacro()

#-------------------------------------------------------------------------------
# For simple script modules, this macro will package the full module directory
macro(pack_module_dir)
    file(INSTALL DESTINATION ${PACKAGE_DIR}/modules
        TYPE DIRECTORY
        FILES
            ${SOURCE_DIR}/modules/${PACKAGE_NAME}
        PATTERN ".git" EXCLUDE
        )
endmacro()

#-------------------------------------------------------------------------------
# pack instructions for the omegalib core.
# Copy over some variables, they will be substituted by configure_file.
# Needed since this file will be executed from outside the main omegalib cmake
# run.
set(PACKAGE_ROOT_DIR D:/Workspace/omegalib/master/install/packages/core)
set(PACKAGE_DIR D:/Workspace/omegalib/master/install/packages/core/data)
set(OMEGALIB_VERSION 6.3)
set(BUILD_DIR D:/Workspace/omegalib/master/build)
set(SOURCE_DIR D:/Workspace/omegalib/master)

# needed to avoid wrong substitution in installer files
set(RootDir "")

set(PACKAGE_CONFIG_TEMPLATE ${PACKAGE_ROOT_DIR}/meta/package.xml.in)

if(WIN32)
    set(BIN_DIR ${BUILD_DIR}/bin/release)
else()
    set(BIN_DIR ${BUILD_DIR}/bin)
endif()

# Save the current date to a variable. Will be used during packaging.
string(TIMESTAMP BUILD_DATE "%Y-%m-%d")

file(REMOVE_RECURSE ${PACKAGE_DIR})
file(MAKE_DIRECTORY ${PACKAGE_DIR})

configure_file(
    D:/Workspace/omegalib/master/install/config/config-offline.xml.in 
    D:/Workspace/omegalib/master/install/config/config-offline.xml)

configure_file(
    D:/Workspace/omegalib/master/install/config/config-online.xml.in 
    D:/Workspace/omegalib/master/install/config/config-online.xml)
    
configure_file(
    ${PACKAGE_ROOT_DIR}/meta/core-package.xml.in 
    ${PACKAGE_ROOT_DIR}/meta/package.xml)

# Copy core files.
if(WIN32)
	file(INSTALL DESTINATION ${PACKAGE_DIR}/modules/python 
        TYPE DIRECTORY
        FILES
            ${SOURCE_DIR}/modules/python/DLLs
            ${SOURCE_DIR}/modules/python/Lib)

	file(INSTALL DESTINATION ${PACKAGE_DIR}/modules/python 
        TYPE DIRECTORY
        FILES
            ${SOURCE_DIR}/modules/python/DLLs
            ${SOURCE_DIR}/modules/python/Lib)
            
    file(INSTALL DESTINATION ${PACKAGE_DIR}/bin
        TYPE FILE
        FILES
            # Dlls
            ${BIN_DIR}/Collage.dll
            ${BIN_DIR}/Equalizer.dll
            ${BIN_DIR}/EqualizerServer.dll
            ${BIN_DIR}/msvcp120.dll
            ${BIN_DIR}/msvcr120.dll
            ${BIN_DIR}/omega.dll
            ${BIN_DIR}/omegaToolkit.dll
            ${BIN_DIR}/omicron.dll
            ${BIN_DIR}/PQMTClient.dll
            ${BIN_DIR}/pthread.dll
            ${BIN_DIR}/python27.dll
            # Executables
            ${BIN_DIR}/orun.exe
        )
        
    file(APPEND ${PACKAGE_DIR}/orun.bat ".\\bin\\orun.exe -D %~dp0%")
endif()

file(INSTALL DESTINATION ${PACKAGE_DIR}
    TYPE DIRECTORY
    FILES
        ${SOURCE_DIR}/fonts
        ${SOURCE_DIR}/menu_sounds
        ${SOURCE_DIR}/ui
        ${SOURCE_DIR}/system
    )
    
file(INSTALL DESTINATION ${PACKAGE_DIR}
    TYPE FILE
    FILES
        ${SOURCE_DIR}/default.cfg
        ${SOURCE_DIR}/default_init.py
        ${SOURCE_DIR}/omegalib-transparent-white.png
    )

    
#-------------------------------------------------------------------------------
# create the examples package
set(PACKAGE_NAME core.examples)
set(PACKAGE_DISPLAY_NAME "Examples")
set(PACKAGE_DESCRIPTION "Omegalib core examples")
set(PACKAGE_DEPENDENCIES "")
set(PACKAGE_VERSION ${OMEGALIB_VERSION})

setup_package()

if(WIN32)
    file(INSTALL DESTINATION ${PACKAGE_DIR}/bin
        TYPE FILE
        FILES
            ${BIN_DIR}/ohello.exe
            ${BIN_DIR}/ohelloWidgets.exe
            ${BIN_DIR}/text2texture.exe
        )
endif()

file(INSTALL DESTINATION ${PACKAGE_DIR}/examples
    TYPE DIRECTORY
    FILES
        ${SOURCE_DIR}/examples/python
    )

#-------------------------------------------------------------------------------
# create the utils package
set(PACKAGE_NAME core.utils)
set(PACKAGE_DISPLAY_NAME "Utilities")
set(PACKAGE_DESCRIPTION 
    "Omegalib core utilities. Includes mission control server, input server and asset cache server")
set(PACKAGE_DEPENDENCIES "")
set(PACKAGE_VERSION ${OMEGALIB_VERSION})

setup_package()

if(WIN32)
    file(INSTALL DESTINATION ${PACKAGE_DIR}/bin
        TYPE FILE
        FILES
            ${BIN_DIR}/mcsend.exe
            ${BIN_DIR}/mcserver.exe
            ${BIN_DIR}/ocachesrv.exe
            ${BIN_DIR}/ocachesync.exe
            ${BIN_DIR}/oimg.exe
            ${BIN_DIR}/oinputserver.exe
            ${BIN_DIR}/olauncher.exe
        )
endif()

    #====================================================
#D:/Workspace/omegalib/master/modules/omegaOsg/pack.cmake
set(PACKAGE_NAME omegaOsg)
set(PACKAGE_DISPLAY_NAME omegaOsg)
set(PACKAGE_DESCRIPTION "An OpenSceneGraph and Bullet Physics integration library for omegalib")
set(PACKAGE_DEPENDENCIES "")
set(PACKAGE_VERSION 6.3)
setup_package()
if(WIN32)
    file(INSTALL DESTINATION ${PACKAGE_DIR}/bin
        TYPE FILE
        FILES
            ${BIN_DIR}/omegaOsg.dll
            ${BIN_DIR}/osg100-osg.dll
            ${BIN_DIR}/osg100-osgAnimation.dll
            ${BIN_DIR}/osg100-osgDB.dll
            ${BIN_DIR}/osg100-osgFX.dll
            ${BIN_DIR}/osg100-osgGA.dll
            ${BIN_DIR}/osg100-osgManipulator.dll
            ${BIN_DIR}/osg100-osgParticle.dll
            ${BIN_DIR}/osg100-osgPresentation.dll
            ${BIN_DIR}/osg100-osgShadow.dll
            ${BIN_DIR}/osg100-osgSim.dll
            ${BIN_DIR}/osg100-osgTerrain.dll
            ${BIN_DIR}/osg100-osgText.dll
            ${BIN_DIR}/osg100-osgUtil.dll
            ${BIN_DIR}/osg100-osgViewer.dll
            ${BIN_DIR}/osg100-osgVolume.dll
            ${BIN_DIR}/osg100-osgWidget.dll
            ${BIN_DIR}/osgbCollision.dll
            ${BIN_DIR}/osgbDynamics.dll
            ${BIN_DIR}/osgbInteraction.dll
            ${BIN_DIR}/ot20-OpenThreads.dll
        )
    file(INSTALL DESTINATION ${PACKAGE_DIR}/bin
        TYPE DIRECTORY
        FILES
            ${BIN_DIR}/osgPlugins-3.2.1
        )
endif()
#====================================================
#D:/Workspace/omegalib/master/modules/omegaOsgEarth/pack.cmake
set(PACKAGE_NAME omegaOsgEarth)
set(PACKAGE_DISPLAY_NAME omegaOsgEarth)
set(PACKAGE_DESCRIPTION "An OpenSceneGraph module for terrain rendering")
set(PACKAGE_DEPENDENCIES "omegaOsg")
set(PACKAGE_VERSION 6.3)
setup_package()
if(WIN32)
    file(INSTALL DESTINATION ${PACKAGE_DIR}/bin
        TYPE FILE
        FILES
            ${BIN_DIR}/cairo.dll
            ${BIN_DIR}/cfitsio.dll
            ${BIN_DIR}/freexl.dll
            ${BIN_DIR}/fribidi.dll
            ${BIN_DIR}/ftgl.dll
            ${BIN_DIR}/gdal110.dll
            ${BIN_DIR}/geos_c.dll
            ${BIN_DIR}/hdf5dll.dll
            ${BIN_DIR}/iconv.dll
            ${BIN_DIR}/icudt.dll
            ${BIN_DIR}/libcurl.dll
            ${BIN_DIR}/libeay32.dll
            ${BIN_DIR}/libecwj2.dll
            ${BIN_DIR}/libexpat.dll
            ${BIN_DIR}/libfcgi.dll
            ${BIN_DIR}/libmysql.dll
            ${BIN_DIR}/libpq.dll
            ${BIN_DIR}/libtiff.dll
            ${BIN_DIR}/libxml2.dll
            ${BIN_DIR}/lti_dsdk.dll
            ${BIN_DIR}/lti_lidar_dsdk.dll
            ${BIN_DIR}/mapserver.dll
            ${BIN_DIR}/msvcp100.dll
            ${BIN_DIR}/msvcr100.dll
            ${BIN_DIR}/netcdf.dll
            ${BIN_DIR}/openjp2.dll
            ${BIN_DIR}/openjpeg.dll
            ${BIN_DIR}/osgEarth.dll
            ${BIN_DIR}/osgEarthAnnotation.dll
            ${BIN_DIR}/osgEarthFeatures.dll
            ${BIN_DIR}/osgEarthSymbology.dll
            ${BIN_DIR}/osgEarthUtil.dll
            ${BIN_DIR}/proj.dll
            ${BIN_DIR}/spatialite.dll
            ${BIN_DIR}/sqlite3.dll
            ${BIN_DIR}/ssleay32.dll
            ${BIN_DIR}/xerces-c_2_8.dll
            ${BIN_DIR}/zlib1.dll
        )
endif()
#====================================================
#D:/Workspace/omegalib/master/modules/scsound/pack.cmake
set(PACKAGE_NAME scsound)
set(PACKAGE_DISPLAY_NAME scsound)
set(PACKAGE_DESCRIPTION "A preconfigured SuperCollider desktop sound server for omegalib")
set(PACKAGE_DEPENDENCIES "")
set(PACKAGE_VERSION 6.3)
setup_package()
pack_module_dir()#====================================================
#D:/Workspace/omegalib/master/modules/cyclops/pack.cmake
set(PACKAGE_NAME cyclops)
set(PACKAGE_DISPLAY_NAME cyclops)
set(PACKAGE_DESCRIPTION "Cyclops is a utility library that sits on top of omegalib and OpenSceneGraph. It is designed to speed-up development of simple graphical applications, without having to deal with the low-level details of osg")
set(PACKAGE_DEPENDENCIES "omegaOsg,omegaOsgEarth")
set(PACKAGE_VERSION 6.3)
setup_package()
if(WIN32)
    file(INSTALL DESTINATION ${PACKAGE_DIR}/bin
        TYPE FILE
        FILES
            ${BIN_DIR}/cyclops.dll
            ${BIN_DIR}/cyclops.pyd
        )
    
    file(INSTALL DESTINATION ${PACKAGE_DIR}
        TYPE FILE
        FILES
            ${SOURCE_DIR}/modules/cyclops/physics.bat
            ${SOURCE_DIR}/modules/cyclops/spincube.bat
        )
endif()

file(INSTALL DESTINATION ${PACKAGE_DIR}/modules/cyclops
    TYPE DIRECTORY
    FILES
        ${SOURCE_DIR}/modules/cyclops/common
        ${SOURCE_DIR}/modules/cyclops/test
    )

file(INSTALL DESTINATION ${PACKAGE_DIR}/examples/cyclops
    TYPE DIRECTORY
    FILES
        ${SOURCE_DIR}/modules/cyclops/examples/python/
    )
    #====================================================
#D:/Workspace/omegalib/master/modules/sprite/pack.cmake
set(PACKAGE_NAME sprite)
set(PACKAGE_DISPLAY_NAME sprite)
set(PACKAGE_DESCRIPTION "A module adding support for 3D sprites to omegalib. Sprites can be placed in 3D space but have a fixed pixel size")
set(PACKAGE_DEPENDENCIES "cyclops")
set(PACKAGE_VERSION 6.3)
setup_package()
pack_module_dir()
