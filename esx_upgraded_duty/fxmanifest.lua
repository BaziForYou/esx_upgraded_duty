fx_version "adamant"
game "gta5"

name "esx_upgraded_duty"
description 'The upgraded version of esx_duty and work better and optimizer and advance stuff'
author "BaziForYou#9907"
version '1.2'

server_scripts {
  '@es_extended/locale.lua',
  '@mysql-async/lib/MySQL.lua',
  'locale/*.lua',
  'config.lua',
  'server/main.lua',
  'server/jobgenetor.lua',
}

client_scripts {
  '@es_extended/locale.lua',
  'locale/*.lua',
  'config.lua',
  'client/main.lua',
}

