WarmodBankNavigation =
{
	[1] =
	{
		-- Вход в банк
		[11] = { "leftangle", "rightangle" },
		-- Площадь дрели
		[9] = { "flywindow", "drillelevator" },
		-- Задний ксерокс
		[53] = { "rightoffice", "flywindow" },
		-- Центр
		[55] = { "flywindow", "rightoffice" },
		-- Кафитерий
		[2] = {"tasercall","tasercall2","rightoffice"},
		-- Офис рядом с кафитерием
		[77] = { "rightoffice", "tasercall","tasercall2" },
		-- Лестница
		[1] = {"tasercall","tasercall2","rightoffice"},
		
		----------- 2-й этаж --------------
		-- Внешний коридор
		[3] = {"rightoffice","tasercall","tasercall2","management"},
		-- Конферент. зал
		[54] = {"rightoffice","tasercall","tasercall2"},
		-- Коридор рядом с офисами
		[5] = { "management","leftoffice","tasercall2" },
		-- Комната менеджера
		[74] = { "management" },
		-- Левый офис
		[73] = { "leftoffice" },
		-- Серверная
		[71] = {"leftoffice","management","cloakercall","tasercall2"},
		-- Коридор рядом с серверной
		[72] = { "leftoffice","floorelevator" },
		-- малая точка
		[89] = { "tasercall", "floorelevator" },
		-- Внешний коридор 2
		[76] =
		{ "tasercall", "floorelevator", "tasercall2" },
		-- Квадрат
		[58] = { "tasercall", "cloakercall", "floorelevator" },
		-- Балкон
		[57] = { "cloakercall", "floorelevator", "drillelevator" },
		-- Шахта клокеров
		[7] = { "cloakercall","tasercall", "floorelevator", "drillelevator" },
		-- Рядом со стальной дверью
		[88] = { "cloakercall", "drillelevator" },
		-- Балкон рядом с дрелью
		[70] = { "drillelevator", "flywindow", "cloakercall" },
		-- Лестница рядом с дрелью
		[6] = { "drillelevator", "flywindow" },
		
		-------- Хранилище --------
		
		-- Вход в хранилище
		[78] = { "flywindow", "drillelevator" },
		-- Холл хранилища
		[8] = { "elevator" },
		-- Спуск к хранилищу
		[79] = { "ventilation", "longventilation" },
		-- Cпуск к хранилищу 2
		[84] = { "longventilation", "lastventilation" },
		-- Узкий коридор
		[82] = { "lastventilation" },
		-- Левый офис хранилища
		[80] = { "longventilation", "lastventilation" },
		-- Правый офис
		[81] = { "longventilation", "lastventilation" },
		-- Правый офис 2
		[10] = { "longventilation", "lastventilation" },
		-- Хранилище внутри
		[0] = { "elevator", "ventilation" },
		-- Выход из хранилища
		[180] = { "elevator", "ventilation"	},
		-- Ovedrill ?
		[268] = { "lastventilation" },
		-- Overdrill vault
		[269] = { "lastventilation" }		
	},
	[2] =
	{
		-- Вход в банк
		[11] = { "backwindow", "backelevator" },
		-- Площадь дрели
		[9] = { "backwindow", "backelevator" },
		-- Задний ксерокс
		[53] = { "backwindow", "backelevator" },
		-- Центр
		[55] = { "backwindow", "backelevator" },
		-- Кафитерий
		[2] = { "backwindow", "backelevator" },
		-- Офис рядом с кафитерием
		[77] = { "backwindow", "backelevator" },
		-- Лестница
		[1] = { "backwindow", "backelevator" },
		
		----------- 2-й этаж --------------
		-- Внешний коридор
		[3] = { "backwindow", "backelevator" },
		-- Конферент. зал
		[54] = { "backwindow", "backelevator" },
		-- Коридор рядом с офисами
		[5] = { "backwindow", "backelevator" },
		-- Комната менеджера
		[74] = { "backwindow", "backelevator" },
		-- Левый офис
		[73] = { "backwindow", "backelevator" },
		-- Серверная
		[71] = { "backwindow", "backelevator" },
		-- Коридор рядом с серверной
		[72] = { "backwindow", "backelevator" },
		-- малая точка
		[89] = { "backwindow", "backelevator" },
		-- Внешний коридор 2
		[76] = { "backwindow", "backelevator" },
		-- Квадрат
		[58] = { "backwindow", "backelevator" },
		-- Балкон
		[57] = { "backwindow", "backelevator" },
		-- Шахта клокеров
		[7] = { "backwindow", "backelevator" },
		-- Рядом со стальной дверью
		[88] = { "backwindow", "backelevator" },
		-- Балкон рядом с дрелью
		[70] = { "backwindow", "backelevator" },
		-- Лестница рядом с дрелью
		[6] = { "backwindow", "backelevator" },
		
		-------- Хранилище --------
		
		-- Вход в хранилище
		[78] = { "backwindow", "backelevator" },
		-- Холл хранилища
		[8] = { "backwindow", "backelevator" },
		-- Спуск к хранилищу
		[79] = { "backwindow", "backelevator" },
		-- Cпуск к хранилищу 2
		[84] = { "backwindow", "backelevator" },
		-- Узкий коридор
		[82] = { "backwindow", "backelevator" },
		-- Левый офис хранилища
		[80] = { "backwindow", "backelevator" },
		-- Правый офис
		[81] = { "backwindow", "backelevator" },
		-- Правый офис 2
		[10] = { "backwindow", "backelevator" },
		-- Хранилище внутри
		[0] = { "backwindow", "backelevator" },
		-- Выход из хранилища
		[180] = { "backwindow", "backelevator" },
		-- Ovedrill ?
		[268] = { "backwindow", "backelevator" },
		-- Overdrill vault
		[269] = { "backwindow", "backelevator" },
	
		-- Взрыв стены
		[90] = { "backwindow", "backelevator" },
		-- Задний двор
		[103] = { "backventilation", "backelevator", "backwindow" },
		-- Узк коридор
		[266] = { "backventilation", "backelevator" },
		[181] = { "backventilation" }
	}
};