fx_version 'adamant'

game 'gta5'

description 'GRZ core shop'

version '1.0.0'

-- grz 1

client_scripts {	
	'@extendedmode/locale.lua',
	'grz_1/locales/fr.lua',
	'grz_1/config.lua',
	'grz_1/client/cl_main.lua'
}

server_scripts {
	'@extendedmode/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'grz_1/locales/fr.lua',
	'grz_1/config.lua',
	'grz_1/server/sv_main.lua',
	'grz_1/server/sv_license.lua'
}


-- grz 2

client_scripts {
	'@grz_shop/grz_1/config.lua',
	'grz_2/cl_main.lua'
}