﻿Если Источник.Условие = Перечисления.УсловияСкидкиНаценки.ПоВидуОплаты Или Источник.Условие = Перечисления.УсловияСкидкиНаценки.ПоСуммеДокумента Тогда
	
	КоллекцияОбъектов = Новый ТаблицаЗначений;
	КоллекцияОбъектов.Колонки.Добавить("УсловиеПредоставления");
	
	НоваяСтрока = КоллекцияОбъектов.Добавить();
	
Иначе
	Отказ = Истина;
		
КонецЕсли;
