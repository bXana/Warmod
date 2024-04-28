local module = ... or D:module("Warmod")

-- конфиги
module:register_include("configs/warmodcfg");
module:register_include("configs/spawnlist");
module:register_include("configs/weaponlist");
module:register_include("configs/eventlist");

-- скрипты, необходимые для работы
-- Простые функции, заглушки и классы
module:register_include("scripts/energycontroller");
module:register_include("scripts/varbase");
module:register_include("scripts/functions");

-- навигационные конфиги
module:register_include("navigation/bank/navigationlist");
module:register_include("navigation/heat street/navigationlist");
module:register_include("navigation/diamond heist/navigationlist");
module:register_include("navigation/green bridge/navigationlist");
module:register_include("navigation/panic room/navigationlist");
module:register_include("navigation/slaughter house/navigationlist");
module:register_include("navigation/counterfeit/navigationlist");
module:register_include("navigation/undercover/navigationlist");
module:register_include("navigation/no mercy/navigationlist");

module:register_include("navigation/bank/vectorlist");
module:register_include("navigation/heat street/vectorlist");
module:register_include("navigation/diamond heist/vectorlist");
module:register_include("navigation/green bridge/vectorlist");
module:register_include("navigation/panic room/vectorlist");
module:register_include("navigation/slaughter house/vectorlist");
module:register_include("navigation/counterfeit/vectorlist");
module:register_include("navigation/undercover/vectorlist");
module:register_include("navigation/no mercy/vectorlist");

module:register_include("navigation/bank/triggerlist");
module:register_include("navigation/heat street/triggerlist");
module:register_include("navigation/diamond heist/triggerlist");
module:register_include("navigation/green bridge/triggerlist");
module:register_include("navigation/panic room/triggerlist");
module:register_include("navigation/slaughter house/triggerlist");
module:register_include("navigation/counterfeit/triggerlist");
module:register_include("navigation/undercover/triggerlist");
module:register_include("navigation/no mercy/triggerlist");

-- новое из хак-триггеров
module:register_include("navigation/specialtriggers");

-- Полноценные модули для работы Warmod'а
module:register_include("scripts/weaponcontroller");
module:register_include("scripts/navigationcontroller");
module:register_include("scripts/spawncontroller");
module:register_include("scripts/warmodnavigationcontroller");

-- сами перехватчики
module:hook_post_require( "lib/managers/dlcmanager", "scripts/navigationmanager.lua" );
module:hook_post_require( "lib/managers/mission/elementspawnenemydummy", "scripts/d7.lua" );
module:hook_post_require( "lib/units/enemies/cop/copbase", "scripts/d5.lua" );
module:hook_post_require( "lib/managers/hudmanager", "scripts/g414.lua" );
module:hook_post_require( "lib/units/beings/player/states/playerstandard", "scripts/g415.lua" );
module:hook_post_require( "lib/network/extensions/player/huskplayermovement", "scripts/g413.lua" );
--module:hook_post_require( "lib/managers/trademanager", "scripts/g416.lua" );
module:hook_post_require( "lib/network/base/hostnetworksession", "scripts/g417.lua" );
module:hook_post_require( "lib/managers/group_ai_states/groupaistatebesiege", "scripts/jx25.lua" );
module:hook_post_require( "lib/managers/group_ai_states/groupaistatestreet", "scripts/jx24.lua" );
module:hook_post_require( "lib/managers/group_ai_states/groupaistatebase", "scripts/jx26.lua" );
module:hook_post_require( "lib/managers/mission/elementspecialobjective", "scripts/jx23.lua" );
module:hook_post_require( "lib/tweak_data/groupaitweakdata", "scripts/ik1.lua" );
module:hook_post_require( "lib/managers/mission/elementpointofnoreturn", "scripts/g5.lua" );
module:hook_post_require( "lib/units/enemies/tank/logics/tankcoplogicattack", "scripts/z1.lua" );
module:hook_post_require( "lib/units/enemies/shield/logics/shieldlogicattack", "scripts/z2.lua" );
module:hook_post_require( "lib/units/enemies/taser/logics/taserlogicattack", "scripts/z3.lua" );
module:hook_post_require( "lib/units/enemies/cop/logics/coplogicintimidated", "scripts/d8.lua" );
module:hook_post_require( "lib/units/enemies/cop/copbrain", "scripts/y40.lua" );
module:hook_post_require( "lib/units/enemies/cop/logics/coplogictravel", "scripts/y41.lua" );
module:hook_post_require( "lib/units/enemies/cop/logics/coplogicattack", "scripts/y42.lua" );
module:hook_post_require( "core/lib/managers/mission/coremissionscriptelement", "scripts/missionscriptcontroller.lua" );
module:hook_post_require( "lib/managers/mission/missionscriptelement", "scripts/missionscriptcontroller2.lua" );
module:hook_post_require( "lib/network/networkgame", "scripts/chatwarn.lua" );
