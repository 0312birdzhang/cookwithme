# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = HealthLife

CONFIG += sailfishapp

SOURCES += src/HealthLife.cpp

OTHER_FILES += qml/HealthLife.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/HealthLife.spec \
    rpm/HealthLife.yaml \
    translations/*.ts \
    HealthLife.desktop \
    rpm/HealthLife.changes \
    qml/pages/storge.js \
    qml/pages/foodlist.js\
    qml/pages/fooddetail.js \
    qml/pages/FoodDetail.qml \
    qml/pages/FoodList.qml \
    qml/pages/AboutPage.qml \
    qml/pages/FoodClass.qml \
    qml/img/foodclass.png \
    qml/img/*.png \
    qml/img/cover.png\
    qml/pages/SearchFood.qml \
    qml/pages/search.js \
    qml/pages/foodclass.js

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/HealthLife-de.ts

