﻿Если Источник.СуммаВключаетНДС Тогда
	Значение = ОбъектКоллекции.Сумма;
Иначе
	Значение = ОбъектКоллекции.Сумма + ОбъектКоллекции.СуммаНДС;
КонецЕсли;
